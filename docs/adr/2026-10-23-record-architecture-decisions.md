---
title: Record architecture decisions as dated Markdown ADRs
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
Planning happens in one AI session and implementation in another. Neither shares memory with the
other, so decisions made in one are lost or re-argued in the other. Documentation must start on day
one and be written as decisions happen, not reconstructed later. Several branches, agents and people
may add decisions at the same time.

## Options
- **Lightweight ADRs in the repo** — plain Markdown every agent and human can read; well-established
  practice.
- **Decisions in chat or a wiki** — invisible to coding agents; drifts from the code.
- **Sequentially numbered ADRs (0001, 0002…)** — familiar, but two branches adding ADRs collide on
  the same number.

## Decision
Record each architecturally significant decision as a short Markdown file in `docs/adr/`, named
`YYYY-MM-DD-slug.md`, with YAML frontmatter (`title`, `status`, `date`, `deciders`, `origin`,
`supersedes`, `superseded_by`, `review`) and four sections: Context, Options, Decision,
Consequences. The filename is the ID.

## Consequences
- Agents get the "why" behind the code at the start of every session.
- No numbering collisions between parallel branches.
- Accepted ADRs are immutable; changing a decision means writing a superseding ADR.
- An index (`docs/adr/README.md`) is hand-maintained until it can be generated.
