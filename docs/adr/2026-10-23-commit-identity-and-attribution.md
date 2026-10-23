---
title: Agent commits use the maintainer's identity; no AI co-author trailers; PRs keep an origin footer
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
The maintainer prompts or approves everything that lands, so the work is his. Cloud agent sessions
default to the vendor's git identity (for Claude: `Claude <noreply@anthropic.com>`) and some add a
`Co-Authored-By:` trailer. The maintainer still wants to know where each PR came from.

## Options
- **Vendor identity on commits** — clear provenance, but commits don't count as the maintainer's.
- **Maintainer identity, no trailer, origin noted on the PR** — commits are the maintainer's;
  provenance is kept at the PR level.

## Decision
Commits are authored with the maintainer's configured git identity. Commits never carry a
`Co-Authored-By:` trailer naming an AI agent or vendor. PRs opened by an agent keep the agent's
footer (for Claude Code: the "Generated with Claude Code" line and session link). A
`commit-identity` CI check rejects commits authored or committed by an `@anthropic.com` address, and
commits with an AI co-author trailer.

## Consequences
- Commit history shows the maintainer as author; PRs show where the work came from.
- Every agent environment must be configured with the maintainer's identity; CI catches misses.
- Revisit if workflows become fully automated without a human prompting or approving them.
