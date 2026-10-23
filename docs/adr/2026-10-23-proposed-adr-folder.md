---
title: Proposed ADRs live in docs/adr/proposed/; accepting one means moving it
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
ADRs are the most valuable artifact and the least checked: CI validates their format, not whether
they record the decision correctly. A misrecorded Accepted ADR silently becomes canon. The
maintainer wants a quick glance at every decision that becomes canon, without reviewing every PR.

## Options
- **Gate all of `docs/adr/`** — simple, but implementers' proposals then need approval just to be
  written down.
- **Separate folder for proposals** — proposals flow freely; only acceptance is gated.

## Decision
`docs/adr/` holds Accepted, Rejected and Superseded ADRs and is owned in `CODEOWNERS`.
`docs/adr/proposed/` holds Proposed ADRs and is not owned. Accepting a proposal means moving the file
into `docs/adr/` and setting `status: Accepted`, which requires the maintainer's approval. ADR lint
enforces that an ADR's status matches its folder.

## Consequences
- Every decision that becomes canon gets a human glance; nothing else does.
- Planners writing ADRs the maintainer decided in-session still go through that glance — it is the
  check that the decision was recorded correctly.
- Moving a file changes its path; links to Proposed ADRs must be updated on acceptance.
