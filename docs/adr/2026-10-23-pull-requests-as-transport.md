---
title: Planning agents write to the repo by opening pull requests
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
Handing a plan from the web app to a coding agent by copy-paste is slow and error-prone. The
requirement is "no paste" from the start. A test on 2026-10-23 confirmed that a Claude web session
with the Claude GitHub App granted on a repository can branch, commit, push and open a pull request.
The same test showed GitHub's GraphQL API is blocked in those sessions while the REST API works.

## Options
- **Session repo attach via the Claude GitHub App** — no extra infrastructure; access is per
  repository.
- **GitHub's official remote MCP server as a connector** — works in more clients, but needs an
  OAuth app or a personal access token.
- **A small self-hosted GitHub MCP server** — full control, but something to maintain.

## Decision
Planners deliver their work as a branch and a pull request. The default route is the Claude GitHub
App with per-repository access; the protocol is transport-independent, so the other routes remain
valid fallbacks. Agents open PRs with the REST API when GraphQL is unavailable.

## Consequences
- Every new repository must be inside the Claude GitHub App's repository access, or agents can read
  but not push. This is a bootstrap step.
- Pull requests become the single unit of change for planners, implementers and humans alike.
- Tokens given to agents must not include merge rights; merging happens via auto-merge.
