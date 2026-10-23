---
title: Default-pass review, with a mandatory gate on self-modifying changes
status: Superseded
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: 2026-10-23-code-owner-gating.md
review: auto
---

## Context
Collaborators will join, and the maintainer wants work to flow without a human approving every PR.
Human review should happen only when asked for. But an agent that can merge changes to its own
instructions or CI could loosen its own constraints, by mistake or through prompt injection.

## Options
- **Require human approval on every PR** — safe, but slow, and blocks auto-merge.
- **Pure default-pass** — fast, but lets agents rewrite the rules that constrain them.
- **Default-pass with a mandatory gate on rule-bearing paths** — fast for normal work, safe for the
  rules.

## Decision
PRs merge automatically when required checks pass, with zero required approvals. A PR needs an
approving human review when (a) it carries the `needs-human-review` label or an ADR/handoff in it
has `review: human`, or (b) — always, regardless of labels — it changes `AGENTS.md`, `CLAUDE.md`,
`docs/PROTOCOL.md`, `.agents/skills/**`, `.claude/**`, `.github/workflows/**` or
`.github/CODEOWNERS`. A `review-gate` status check enforces this.

## Consequences
- Normal work flows without waiting on a human.
- Changes to the system's own rules always get human eyes.
- The `review-gate` check must exist before auto-merge is switched on in adopting projects.
