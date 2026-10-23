# Status

> This file will be generated from handoff frontmatter once `status-generate` exists
> (see the reusable CI workflows handoff). Until then it is updated by hand in each PR.

**Protocol version:** 0.2.0

## Maintainer actions pending

- [ ] Turn on **Require review from Code Owners** in this repo's `main` ruleset (needs this PR's
      `CODEOWNERS` on `main` first).

## Open handoffs

| Handoff | Assignee | Review |
|---|---|---|
| [Reusable CI workflows (opt-in review, ADR lint, handoff lint, status)](handoff/2026-10-23-reusable-ci-workflows.md) | agent:any | human |
| [Copier template for new projects](handoff/2026-10-23-copier-project-template.md) | agent:any | human |
| [The project-handoff Agent Skill](handoff/2026-10-23-project-handoff-skill.md) | agent:any | human |

Suggested order: CI workflows → copier template → skill. The template calls the workflows, and the
skill is copied by the template.

## Proposed ADRs awaiting acceptance

None.
