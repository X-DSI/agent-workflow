---
title: Copier template for new projects
status: open
assignee: agent:any
base_sha: 24db7b8
adrs:
  - 2026-10-23-method-repo-and-project-repos.md
  - 2026-10-23-agents-md-and-agent-skills.md
plan_pr: 1
impl_pr: null
review: human
---

## Goal
A `copier` template in `template/` that turns an empty repository into an agent-workflow project in
one command, and can later pull method updates with `copier update`.

## Scope
**In:**
- `copier.yml` with questions: project name, slug, description, maintainer git name and email,
  primary language, whether the project has generated content.
- Generated files: `AGENTS.md` (project stub with a "follow docs/PROTOCOL.md" section), `CLAUDE.md`
  (`@AGENTS.md`), `CONTRIBUTING.md`, `docs/PROTOCOL.md` (copied from this repo), `docs/STATUS.md`,
  `docs/adr/` with a first ADR, `docs/handoff/`, `changelog.d/`, `CHANGELOG.md`, `.gitignore`
  (including `*.local.md`), `.github/workflows/ci.yml` calling the reusable workflows,
  `.github/pull_request_template.md`.
- If generated content is enabled: `schemas/`, `content/`, and a content-validation job.
- A short bootstrap checklist in the generated README: grant the Claude GitHub App access, set the
  agent git identity, enable auto-merge, set branch protection.
- Tests that render the template and check the output.

**Out:** the Agent Skill itself (separate handoff), language-specific project scaffolding.

## Acceptance criteria
- [ ] `copier copy gh:X-DSI/agent-workflow <dir>` produces a project that passes its own CI.
- [ ] `copier update` on a generated project applies a template change cleanly.
- [ ] Generated `docs/PROTOCOL.md` is identical to this repo's version.
- [ ] Tests run in this repo's CI.

## Constraints
- Use copier, not cookiecutter (update support is the reason — see the method ADR).
- Generated projects pin reusable workflows to a tag, not `main`.

## Implementer may decide
Template file layout, test tooling.

## Must escalate
Any change to the adopting-project layout in PROTOCOL §3.

## Attached content
None.
