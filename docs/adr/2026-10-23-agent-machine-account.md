---
title: Agents act on GitHub through a dedicated machine account
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
Agents first acted on GitHub as the maintainer's own account. GitHub does not let anyone approve
their own pull request, so no approval-based gate could ever pass for agent PRs, and GitHub could not
tell the agent apart from the maintainer: anything the maintainer can do, the agent could do. The
"agent tokens must not have merge rights" consequence of the PR-transport ADR was not achievable.

## Options
- **Accept honor-system gating** — no setup, but the gates are conventions only.
- **A machine user for agents** — one free extra GitHub account per person; agents get their own
  identity and role.
- **A custom GitHub App** — cleanest identity, but claude.ai sessions can't act through a
  self-made app.

## Decision
All agents push, open PRs and comment through a dedicated machine account (for this project:
`X-DSI-agent`), added to each repository as a collaborator with the **Write** role, never Maintain or
Admin. claude.ai connects to GitHub as that account; local agents receive its token through the
environment of the agent process only. Commits are still authored with the maintainer's git
identity (see the commit-identity ADR). Only the maintainer is on the ruleset bypass list.

## Consequences
- The maintainer can approve agent PRs, which makes approval-based gates work. Verified on
  2026-10-23: a code-owner-gated PR from the agent was blocked with "Waiting on code owner review",
  and an ungated one merged with zero approvals.
- The agent can merge PRs that satisfy every rule, but cannot change rules, settings or rulesets.
- Each new repository needs the agent invited as a collaborator (a bootstrap step).
- The agent's token must be rotated; classic tokens with `repo` and `workflow` scopes are needed,
  because fine-grained tokens generally can't reach another personal account's repositories.
