---
title: Scale the process to the size of the change
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
Running every change through plan, handoff, implementation and Outcome is absurd for a typo. If the
process feels like paperwork, people bypass it, and a half-followed protocol is worse than none.

## Options
- **Same process for everything** — consistent, but heavy for small work.
- **Tiers by size and reversibility** — proportional; needs a clear test for each tier.

## Decision
Every change is a pull request. The paperwork around it scales in four tiers: **0 Trivial**
(PR only), **1 Small** (PR, plus a changelog fragment if behaviour changes), **2 Feature** (PR,
fragment, handoff), **3 Decision** (PR, fragment, ADR, usually a handoff). A change is tier 3 if
any of these is true: a reasonable engineer could choose differently; it is costly to reverse; it
constrains future work.

## Consequences
- Small work stays fast; the expensive artifacts are reserved for work that needs them.
- Tier is a judgement call; when unsure, agents pick the higher tier.
