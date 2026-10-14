# Deterministic HTTP acceptance server

Target: the same Ubuntu x86-64 Linux host as the real client.

This is an Idriç test program, not a replacement client or a job provider.
`receive_request : Socket → Text → IO Text` collects a bounded HTTP POST;
`answer_request` emits one specified status/body and closes the connection.
Inputs: port, status, fixture path, ready marker, captured-request path.
Outputs: HTTP response and exact synthetic request. Bind only 127.0.0.1.
The inherited compiler `network` package supplies socket calls; this test-only
server is below the client/ICU transport boundary and does not replace it.

Required invariants: read the whole Content-Length request, use UTF-8 byte
counts, return exact fixture bytes, fail on bind/read/write errors, exit after
one request, never use provider credentials. A malformed-response fixture is
deliberately sent unchanged. Client tests use synthetic-test-token only.

Current result: compiler and executable receipts accompany the CLI acceptance.
No fallback language or simulated live retrieval is used.
