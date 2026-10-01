# Stack Exchange API surface pass

Audit baseline: 2026-10-01.

Current documented API family: `2.3`.

Canonical base:

```text
https://api.stackexchange.com/2.3
```

The public documentation index is `https://api.stackexchange.com/docs`. Stack Overflow is selected with `site=stackoverflow`.

This pass is aimed first at historical question-corpus work for Black Ball. It records the broader contracts because pagination, filters, throttling, compression, errors and site discovery affect any correct client.

## What is actually useful for the first corpus

The central endpoint is:

```text
GET /2.3/questions
```

Useful constraints include:

```text
site
fromdate
todate
sort
min
max
tagged
page
pagesize
filter
key
```

For `sort=votes`, `min` and `max` constrain question score. `fromdate` and `todate` constrain the creation window independently of the selected sort.

The documented `/questions` sorts are activity, creation, votes, hot, week and month. The hot/week/month sorts do not accept `min` or `max`.

On `/questions`, semicolon-separated `tagged` values are an AND constraint. The documentation warns that more than five tags therefore returns no results.

That differs from `/search` and `/search/advanced`, where `tagged` means that at least one listed tag is present. Do not hide this difference behind one ambiguous internal parameter.

## Question fields

The question type documents the fields needed for several independent signals:

- `question_id`
- `creation_date`
- `last_activity_date`
- `score`
- `up_vote_count`
- `down_vote_count`
- `view_count`
- `answer_count`
- `accepted_answer_id`
- `is_answered`
- `tags`
- `title`
- `body`
- `body_markdown`
- closure, migration and community-wiki metadata

Do not assume every field is present in the default response. The API's filter mechanism controls returned fields. The built-in `withbody` filter adds body fields to the default filter; custom filters are immutable and non-expiring and can be baked into a client once the desired corpus schema is fixed.

For Black Ball, preserve raw observable fields and derive interpretations later. In particular, `score` is a net voting signal, not a direct measurement of difficulty.

## Three different question sets

Keep these as separate operations:

| Endpoint | Meaning |
| --- | --- |
| `/questions` | all questions matching the supplied constraints |
| `/questions/no-answers` | questions with zero answers |
| `/questions/unanswered` | questions the site considers unanswered |

The current documentation says a question can have answers and still be in the site's unanswered set; at the time of this audit the documented rule requires at least one upvoted answer for a question to count as answered. The documentation also says that rule is subject to change.

That distinction is useful research evidence. "Nobody answered" and "answers existed but none cleared the site's adequacy rule" are different conditions.

## Search

`/search` is intentionally narrow and requires at least one of `tagged` or `intitle`.

`/search/advanced` adds criteria including:

- free text `q`
- accepted-answer state
- minimum answer count
- body text
- closed state
- migrated state
- post-notice state
- included and excluded tags
- title text
- owner user id
- URL text
- minimum views
- community-wiki state

The documentation explicitly says the free-text `q` matching algorithm is undocumented. Do not treat relevance scores or text-search matches as a stable semantic classifier.

## Tags and sites

`GET /tags` returns the tag inventory for one site and can sort by popularity, recent activity or name.

`GET /sites` discovers the Stack Exchange network and its `api_site_parameter` values. Its page-size rule is exceptional: the documentation permits an unbounded page size and recommends fetching the site list very infrequently, roughly caching for at least a day.

`GET /info` returns site-level statistics and is aggressively cached; the documentation recommends querying it sparingly, ideally no more than once an hour.

For the first Black Ball pass, hard-coding `stackoverflow` at the command boundary is reasonable, but the transport and data model should not pretend Stack Overflow is the whole API.

## Dates

The wire format for dates is integer Unix epoch seconds in UTC. Fractional times are not accepted or returned.

The docs allow a human-readable date format for ad-hoc keyless development, but explicitly say applications should not ship using it. A CLI may accept ISO dates from a person, but convert them to epoch seconds before constructing the API request.

Year windows should be half-open internally where possible:

```text
2025-01-01T00:00:00Z <= creation < 2026-01-01T00:00:00Z
```

Then translate carefully to the API's whole-second inclusive/exclusive behavior instead of silently losing or duplicating a boundary second.

## Paging

Most list methods use:

```text
page
pagesize
```

Pages start at 1. The documented default page size is 30 and normal maximum is 100.

Use the wrapper's `has_more` field to continue. Do not request `total` merely to decide whether another page exists; the documentation warns that computing `total` can be as expensive as fetching items.

Anonymous access with neither an access token nor an application key is documented as capped at page 25. Serious historical collection therefore needs an application key even though the public question endpoints do not require a user OAuth token.

A corpus dump should checkpoint each completed page to disk and be restartable. A dropped process should not force the year/tag window to restart at page 1.

## Common wrapper

Responses share one wrapper. Fields documented on it include:

```text
items
has_more
page
page_size
quota_max
quota_remaining
backoff
error_id
error_name
error_message
total
type
```

Treat `backoff` as a transport-control instruction, not merely metadata.

## Throttling and caching

The documented controls include:

- more than 30 requests per second from one IP can be dropped harshly;
- a default daily quota of 10,000 applies to the relevant anonymous/keyed or user/app quota;
- any method can return `backoff=N`, requiring the caller to stop calling that method for N seconds;
- semantically identical requests should not be repeated more often than once per minute because responses are heavily cached.

The first client should be deliberately boring: one bounded request stream, no speculative fan-out, durable page checkpoints, and exact backoff handling.

## Authentication and keys

Keep these concepts separate:

- an application key identifies a registered application and increases usable public-read quota;
- an OAuth access token represents a user and is required for user-specific/private/write operations.

The historical public-question corpus does not need user authentication. Do not make OAuth a prerequisite for the first read-only tool.

## Compression

The API documents compressed responses as normal behavior and supports gzip or deflate. It recommends sending `Accept-Encoding`; if a response lacks `Content-Encoding`, the client is told to assume gzip unless the payload itself proves otherwise.

That is a real transport requirement for ICU/Idric-Net. Do not treat decompression as a Stack-specific JSON concern.

## Errors

Method-call failures put `error_id`, `error_name` and `error_message` in the common wrapper.

The documentation lists named API error identifiers such as:

```text
bad_parameter
access_token_required
invalid_access_token
access_denied
no_method
key_required
access_token_compromised
write_failed
duplicate_request
internal_error
throttle_violation
temporarily_unavailable
```

The numbers shown beside those names in the documentation are API error ids. The error-handling page separately says ordinary method-call errors are returned with HTTP 400, except for JSONP behavior. Do not confuse the API error id with the HTTP status.

## Retry identity

Every request can carry a `request_id`. The duplicate-request documentation says a repeated id within a short window is rejected as `duplicate_request`, with a recognition window no shorter than five minutes.

This matters most once write operations exist. Read-only collection can usually retry idempotent GETs without inventing a write-style transaction abstraction.

## Raw documentation mirror

`mirror` reads `SOURCES.tsv` and stores the upstream bytes and response headers under a timestamped directory, along with SHA-256 hashes.

The checked-in analysis is not the mirror. It is our factual/commentary layer. If upstream changes, keep the old mirror as dated evidence and make a new one rather than rewriting history.

## First implementation slice

When implementation begins, the smallest honest slice is:

1. construct an exact `/2.3/questions` URL for `site=stackoverflow`;
2. accept an explicit creation-date window;
3. support `sort=votes` and one optional tag constraint;
4. request a fixed corpus filter;
5. decode the common wrapper;
6. write each page as an append-only or atomic page artifact;
7. obey `has_more`, `quota_remaining` and `backoff`;
8. resume after interruption without redownloading completed pages;
9. only then add no-answers, unanswered, search and tag discovery.

That gives Black Ball evidence before it gives Black Ball advice.
