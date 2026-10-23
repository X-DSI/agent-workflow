---
title: Validate generated content by structure only, for now
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
Planning agents generate content that code consumes (for example, exam question banks in YAML).
Structural errors are cheap to catch automatically; factual errors (a wrong answer) are not. An
automated second-model review in CI would catch more, but costs money on every content PR.

## Options
- **Structure-only validation** — free, fast; wrong facts can ship.
- **Automated independent-model review in CI** — catches more errors; paid per PR.
- **Mandatory human review of all content** — accurate; does not scale.

## Decision
Generated content is validated by schema and structural lint only (required fields, uniqueness,
internal references, exactly-one-correct-answer style rules). Items carry `reviewed: false` until a
person reviews them, and projects should give users a way to flag wrong items.

## Consequences
- No ongoing cost.
- Factual errors are caught by use, not by CI; the flagging path is the safety net.
- Revisit when content volume or the cost of errors grows. A superseding ADR would add an AI review
  check.
