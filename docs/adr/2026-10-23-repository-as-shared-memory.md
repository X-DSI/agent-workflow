---
title: The git repository is the only shared memory between agents
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
Planning and coding sessions need a common state: decisions, open tasks, handoff notes, status. Every
change must be version-controlled.

## Options
- **Files in the repository** — every agent and human can already read them; history and review come
  free with git.
- **A custom MCP "project state" server** — live shared state, but needs hosting, auth and uptime,
  and becomes a second source of truth outside version control.
- **GitHub issues as the store** — good for humans, but not visible to every agent through every
  integration, and not part of the repo's history.

## Decision
All shared state lives as files in the project's repository. No external state service. MCP
servers may be used as *transport* (for example, to read or write the repo), never as a store.

## Consequences
- One source of truth, fully version-controlled and reviewable.
- Anything that can read a repo can take part, regardless of vendor.
- Status must be derived from files (see `docs/PROTOCOL.md` §10), which needs a small generator.
