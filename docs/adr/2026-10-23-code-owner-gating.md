---
title: Enforce the self-modification gate with CODEOWNERS and code-owner review
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: 2026-10-23-default-pass-review-with-self-modification-gate.md
superseded_by: null
review: auto
---

## Context
The default-pass ADR required human review for changes to the rules, and planned a custom
`review-gate` status check to enforce it. A status check defined in the repository runs the PR's own
version of the workflow, so an agent could weaken the check in the same PR that it gates. With a
separate agent account in place, GitHub's native code-owner review can do the job instead.

## Options
- **Custom review-gate check** — flexible, but self-modifiable and more code to maintain.
- **CODEOWNERS + "Require review from Code Owners" in a ruleset** — native, enforced by GitHub
  outside the PR's control, zero code.

## Decision
Default-pass stays: rulesets require a pull request with **zero** approvals. Rule-bearing paths are
listed in `.github/CODEOWNERS` with the maintainer as owner, and the ruleset turns on **Require
review from Code Owners**. A PR touching an owned path cannot merge until the maintainer approves.
`CODEOWNERS` owns itself. The opt-in signals (`needs-human-review` label, `review: human`) are
still enforced by a small check, since they aren't path-based.

## Consequences
- The always-gated rule is now enforced by GitHub, not by convention.
- The planned `review-gate` check shrinks to the opt-in signals only.
- Adopting projects must ship a `CODEOWNERS` file and enable code-owner review in their ruleset.
- When the maintainer opens a gated PR himself, he merges it through the ruleset bypass.
