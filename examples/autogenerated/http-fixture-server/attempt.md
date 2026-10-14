# Bounded HTTP fixture server

This is generic test infrastructure, adapted from the already executed Idriç
server in dilapidated-shed/idric-cli PR #8, “Finish the Idriç Indeed CLI”, source
a6230ee2f42bc07ea5223b445a9b21899d2f3087. It uses the same Network.Socket and
UTF-8 byte-count interfaces. It has no Jobicy, GraphQL or authentication logic.

Input: a loopback port and a finite list of (HTTP status, absolute body path,
exact expected request target). Output: real HTTP responses and exact captured
requests. A sequence permits first/intermediate/final cursor testing through
ICU instead of making fixture parsing stand in for transport execution.

`serve_remaining : listener → finite_scenarios → IO ()` accepts exactly one
connection per scenario, refuses a wrong GET request target and closes sockets.
Header capture is bounded to 64 KiB. It is a covering external-I/O action,
compiled through the maintained Chez backend. Tests record its actual exits.
Synthetic responses never constitute live-provider evidence.
