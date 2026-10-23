---
title: Every acceptance criterion names how it is checked
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
An implementer's Outcome is self-reported, and agents tend to overclaim "done". Criteria that only
the implementer can judge give the planner nothing to verify.

## Options
- **Trust the Outcome** — no overhead; unreliable.
- **Each criterion names its check; Outcomes cite CI evidence** — small overhead for planners;
  claims become verifiable.

## Decision
Every acceptance criterion in a handoff ends with `— check: <command>` or `— check: manual`. Outcomes
cite the CI run that ran the command as evidence. `manual` criteria are allowed but are listed
separately in the Outcome as unverified. Later, handoff lint rejects criteria without a check, and
CI may run the listed commands itself.

## Consequences
- Planners must think about verification while planning, which also sharpens the criteria.
- Unverified claims are visible instead of hidden.
