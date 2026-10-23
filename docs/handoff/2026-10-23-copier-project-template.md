---
title: Copier template for new projects
status: open
assignee: agent:any
base_sha: e0b8105
adrs:
  - 2026-10-23-method-repo-and-project-repos.md
  - 2026-10-23-agents-md-and-agent-skills.md
  - 2026-10-23-agent-machine-account.md
  - 2026-10-23-code-owner-gating.md
  - 2026-10-23-proposed-adr-folder.md
  - 2026-10-23-untrusted-input.md
plan_pr: 1
impl_pr: null
review: human
---

## Goal
A `copier` template in `template/` that turns an empty repository into an agent-workflow project in
one command, and can later pull method updates with `copier update`.

## Scope
**In:**
- `copier.yml` with questions: project name, slug, description, maintainer GitHub handle,
  maintainer git name and email, agent account handle, primary language, whether the project has
  generated content, whether it accepts public reports.
- Generated files: `AGENTS.md` (project stub with a "follow docs/PROTOCOL.md" section), `CLAUDE.md`
  (`@AGENTS.md`), `CONTRIBUTING.md`, `docs/PROTOCOL.md` (copied from this repo), `docs/STATUS.md`,
  `docs/adr/` with a first ADR, `docs/adr/proposed/`, `docs/handoff/`, `changelog.d/`,
  `CHANGELOG.md`, `.gitignore` (including `*.local.md`), `.github/CODEOWNERS` (the paths in
  PROTOCOL §8, owned by the maintainer), `.github/workflows/ci.yml` calling the reusable workflows,
  `.github/pull_request_template.md`.
- If generated content is enabled: `schemas/`, `content/`, and a content-validation job.
- If public reports are enabled: a GitHub issue form with fixed choices and a schema for the stored
  records (PROTOCOL §9).
- A bootstrap checklist in the generated README, in this order: invite the agent account as a
  collaborator with **Write**; connect the agent account to claude.ai (and give local agents its
  token via `GH_TOKEN` in the agent process only); set the agent sessions' git identity to the
  maintainer's; create the default-branch ruleset (require a PR, **0** approvals, **Require review
  from Code Owners**, required CI checks, block force pushes and deletions, maintainer on the bypass
  list); turn on auto-merge and automatic branch deletion.
- Tests that render the template and check the output.

**Out:** the Agent Skill itself (separate handoff), language-specific project scaffolding.

## Acceptance criteria
- [ ] `copier copy gh:X-DSI/agent-workflow <dir>` produces a project whose own checks pass — check: `pytest tests/test_template_render.py`
- [ ] `copier update` on a generated project applies a template change cleanly — check: `pytest tests/test_template_update.py`
- [ ] Generated `docs/PROTOCOL.md` is identical to this repo's version — check: `pytest tests/test_template_render.py`
- [ ] Generated `CODEOWNERS` owns exactly the paths in PROTOCOL §8, and not `docs/adr/proposed/` — check: `pytest tests/test_template_render.py`
- [ ] Tests run in this repo's CI — check: the PR's CI run shows the template test job

## Constraints
- Use copier, not cookiecutter (update support is the reason — see the method ADR).
- Generated projects pin reusable workflows to a tag, not `main`.

## Implementer may decide
Template file layout, test tooling.

## Must escalate
Any change to the adopting-project layout in PROTOCOL §4.

## Attached content
None.
