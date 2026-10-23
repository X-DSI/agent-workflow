---
title: Reusable CI workflows (review-gate, ADR lint, handoff lint, status generator)
status: open
assignee: agent:any
base_sha: 24db7b8
adrs:
  - 2026-10-23-default-pass-review-with-self-modification-gate.md
  - 2026-10-23-record-architecture-decisions.md
  - 2026-10-23-method-repo-and-project-repos.md
plan_pr: 1
impl_pr: null
review: human
---

## Goal
Ship the reusable GitHub Actions workflows that make the protocol enforceable, following the
pattern of `commit-identity.yml` (a `workflow_call` workflow plus a script in `.github/scripts/`).

## Scope
**In:**
- `review-gate.yml` — fails while a PR needs human review and has no approval (rules in
  PROTOCOL §7: label, `review: human`, always-gated paths). Re-runs on review events.
- `adr-lint.yml` — validates ADR filenames and frontmatter (PROTOCOL §4).
- `handoff-lint.yml` — validates handoff filenames and frontmatter (PROTOCOL §5); fails an `impl/`
  PR that doesn't reference a handoff.
- `status-generate.yml` — after a merge to the default branch, regenerates `docs/STATUS.md` and
  `docs/adr/README.md` and opens a `chore/` PR with the result.
- This repo's `ci.yml` calls all of them on itself.

**Out:** content validation (schemas are project-specific; it ships with the template).

## Acceptance criteria
- [ ] Each workflow is callable as `uses: X-DSI/agent-workflow/.github/workflows/<name>.yml@<ref>`.
- [ ] Logic lives in scripts with tests runnable locally (`pytest` or `bats`).
- [ ] `review-gate` passes a normal PR, fails a labelled or always-gated PR until approved.
- [ ] The generator's output is deterministic (running it twice produces no diff).
- [ ] This repo's own PRs run all checks.

## Constraints
- No third-party actions except `actions/checkout` and `actions/setup-python`.
- Only the REST API; no GraphQL.
- Workflows request the least `permissions:` they need.

## Implementer may decide
Script language (Python or Bash), file names inside `.github/scripts/`, test framework.

## Must escalate
Any change to which paths are always gated, or to the meaning of `review: human`.

## Attached content
None.
