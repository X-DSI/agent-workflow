---
title: The project-handoff Agent Skill
status: open
assignee: agent:any
base_sha: 24db7b8
adrs:
  - 2026-10-23-agents-md-and-agent-skills.md
  - 2026-10-23-pull-requests-as-transport.md
plan_pr: 1
impl_pr: null
review: human
---

## Goal
One Agent Skill that teaches any agent how to take part in the protocol: plan, hand off, pick up,
implement, report back.

## Scope
**In:**
- `skill/project-handoff/SKILL.md` — thin: locate and follow `docs/PROTOCOL.md`; procedures for
  "start a planning session", "write an ADR", "write a handoff", "pick the next handoff",
  "write the Outcome", "open a PR via the REST API".
- `skill/project-handoff/templates/` — ADR, handoff and Outcome templates matching PROTOCOL §4–5.
- A protocol-version check: the skill states the protocol version it was written for and tells the
  agent to warn the user when `docs/PROTOCOL.md` reports a different version.
- `make skill-zip` to build the claude.ai upload bundle (git-ignored output).
- The template copies the skill into `.agents/skills/` and mirrors it into `.claude/skills/`.

**Out:** slash commands and Claude Code plugin packaging (later, if needed).

## Acceptance criteria
- [ ] The skill loads in Claude Code from a generated project.
- [ ] The zipped skill uploads to claude.ai and triggers on "plan the next step" style requests.
- [ ] Following the skill end to end produces files that pass ADR and handoff lint.

## Constraints
- The skill must not restate the protocol's rules; it points to them. One source of truth.
- `name` and `description` in the frontmatter follow the Agent Skills spec.

## Implementer may decide
Wording, the split between SKILL.md and reference files.

## Must escalate
Anything that would make the skill contradict PROTOCOL.md.

## Attached content
None.
