---
title: Reusable CI workflows (opt-in review check, ADR lint, handoff lint, status generator)
status: open
assignee: agent:any
base_sha: e0b8105
adrs:
  - 2026-10-23-code-owner-gating.md
  - 2026-10-23-proposed-adr-folder.md
  - 2026-10-23-verifiable-acceptance-criteria.md
  - 2026-10-23-record-architecture-decisions.md
  - 2026-10-23-method-repo-and-project-repos.md
plan_pr: 1
impl_pr: null
review: human
---

## Goal
Ship the reusable GitHub Actions workflows that make the rest of the protocol enforceable,
following the pattern of `commit-identity.yml` (a `workflow_call` workflow plus a script in
`.github/scripts/`). Path-based gating is already handled by CODEOWNERS; these cover what CODEOWNERS
can't.

## Scope
**In:**
- `review-optin.yml` — fails while a PR carries the `needs-human-review` label, or implements a
  handoff with `review: human`, and has no approving review from someone other than the PR author.
  Re-runs on label and review events. (Path gating is **not** its job — see PROTOCOL §8.)
- `adr-lint.yml` — validates ADR filenames and frontmatter (PROTOCOL §5), and that each ADR's
  folder matches its status (`Proposed` only in `docs/adr/proposed/`).
- `handoff-lint.yml` — validates handoff filenames and frontmatter (PROTOCOL §6); fails if any
  acceptance criterion lacks `— check: <command>` or `— check: manual`; fails an `impl/` PR that
  doesn't reference a handoff.
- `status-generate.yml` — after a merge to the default branch, regenerates `docs/STATUS.md` and
  `docs/adr/README.md` and opens a `chore/` PR with the result.
- This repo's `ci.yml` calls all of them on itself.

**Out:** content validation (schemas are project-specific; it ships with the template), and
running `check:` commands automatically (a later version).

## Acceptance criteria
- [ ] Each workflow is callable as `uses: X-DSI/agent-workflow/.github/workflows/<name>.yml@<ref>` — check: a test repo or `ci.yml` in this repo calls each one successfully
- [ ] `review-optin` passes an unlabelled PR, and fails a labelled PR until it is approved — check: `pytest tests/test_review_optin.py`
- [ ] `adr-lint` rejects an Accepted ADR in `proposed/` and a Proposed ADR in `docs/adr/` — check: `pytest tests/test_adr_lint.py`
- [ ] `handoff-lint` rejects a criterion without a `check:` — check: `pytest tests/test_handoff_lint.py`
- [ ] The status generator is deterministic: running it twice produces no diff — check: `pytest tests/test_status_generate.py`
- [ ] This repo's own PRs run all checks — check: the PR's CI run shows every job

## Constraints
- No third-party actions except `actions/checkout` and `actions/setup-python`.
- Only the REST API; no GraphQL.
- Workflows request the least `permissions:` they need.
- The status generator's PR is opened as a `chore/` PR and may touch code-owned files
  (`docs/adr/README.md`), so it will wait for the maintainer; that is expected.

## Implementer may decide
Script language (Python or Bash), file names inside `.github/scripts/`, test framework.

## Must escalate
Any change to which paths are code-owned, or to the meaning of `review: human`.

## Attached content
None.
