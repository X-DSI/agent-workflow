# The agent-workflow protocol

**Version:** 0.1.0

This is the rulebook. Every agent (Claude on the web, Claude Code, Codex, Cursor, …) and every human
contributor working in a repository that adopts agent-workflow follows it. When this file and any
other instruction disagree, this file wins — except where the project's own `AGENTS.md` explicitly
overrides a rule.

The key words **MUST**, **MUST NOT**, **SHOULD** and **MAY** are used as in RFC 2119.

---

## 1. Principles

1. **The repository is the shared memory.** Decisions, plans, status and history live in
   version-controlled files. Nothing important lives only in a chat transcript.
2. **Git is the transport.** Agents hand work to each other by opening pull requests, never by a
   human copy-pasting text between tools.
3. **Record decisions when they are made.** Rationale is written down at the moment of the decision,
   not reconstructed later.
4. **Agent-neutral formats.** Plain Markdown, YAML frontmatter, `AGENTS.md` and Agent Skills — no
   format that only one vendor's tool can read.
5. **Machines check structure; humans check judgement.** CI enforces everything mechanical. Human
   review is opt-in, except where an agent could loosen its own constraints.

## 2. Roles

Roles describe *what someone is doing*, not *who they are*. Any agent or human can take any role.

| Role | Typical actor | Produces |
|---|---|---|
| **Planner** | Claude in the web/desktop app, or a human | ADRs, handoffs, generated content, schemas |
| **Implementer** | Claude Code, Codex, Cursor, or a human | Code, tests, Outcome sections, changelog fragments, `Proposed` ADRs |
| **Approver** | A human maintainer | Reviews on gated PRs; accepts `Proposed` ADRs |

## 3. Repository layout (adopting projects)

```
AGENTS.md                      Instructions for every agent. Source of truth.
CLAUDE.md                      One line: @AGENTS.md (plus Claude-only notes, if any)
CONTRIBUTING.md                Points humans to this protocol
docs/PROTOCOL.md               This file (pinned copy, updated via the template)
docs/STATUS.md                 Generated. Never edited by hand.
docs/adr/                      Architecture Decision Records
docs/handoff/                  Work orders from planners to implementers
changelog.d/                   One changelog fragment per PR
.agents/skills/                Agent Skills (SKILL.md folders)
.github/workflows/             Thin callers of agent-workflow's reusable workflows
```

## 4. Architecture Decision Records

**Location and name:** `docs/adr/YYYY-MM-DD-short-slug.md`. The filename is the ADR's ID.
Date-based names cannot collide when several branches add ADRs at once.

**Format:**

```markdown
---
title: Store question banks as one YAML file per exam objective
status: Accepted        # Proposed | Accepted | Rejected | Superseded
date: 2026-10-23
deciders: [X-DSI]       # GitHub handles
origin: web             # web | code | human
supersedes: null        # filename of the ADR this replaces, if any
superseded_by: null
review: auto            # auto | human
---

## Context
Why this decision is needed now. Constraints and forces at play.

## Options
- **Option A** — one-line trade-off.
- **Option B** — one-line trade-off.

## Decision
What we chose, in one paragraph.

## Consequences
What becomes easier, what becomes harder, and any follow-up work.
```

**Rules:**

- An ADR **MUST** be short: one decision per record.
- Planners **MAY** write ADRs as `Accepted` when a human decided in the planning session.
  Implementers **MUST** write new ADRs as `Proposed`; an approver accepts them in a later PR.
- An `Accepted` ADR **MUST NOT** be edited in substance. To change a decision, write a new ADR that
  supersedes it and set `superseded_by` on the old one. Typo fixes are fine.
- Agents **MUST** read the relevant ADRs before acting, and **MUST NOT** silently work against an
  `Accepted` ADR. If an ADR blocks the right solution, stop and propose a superseding ADR.
- `docs/adr/README.md` lists all ADRs with status. (Generated once the tooling exists.)

## 5. Handoffs

A handoff is a work order from a planner to an implementer.

**Location and name:** `docs/handoff/YYYY-MM-DD-short-slug.md`.

**Format:**

```markdown
---
title: Practice CLI skeleton
status: open            # open | in-progress | blocked | done | cancelled
assignee: agent:any     # a GitHub handle, or agent:any
base_sha: a1b2c3d       # repo state the plan was written against
adrs: [2026-10-23-question-bank-format.md]
plan_pr: 12
impl_pr: null
review: auto            # auto | human — human forces the review gate on the impl PR
---

## Goal
One or two sentences.

## Scope
**In:** …  
**Out:** …

## Acceptance criteria
- [ ] Testable criterion 1
- [ ] Testable criterion 2

## Constraints
Rules that apply to this work and aren't already in an ADR.

## Implementer may decide
Internal naming, helper structure, …

## Must escalate
Anything that touches an Accepted ADR, a schema, or a public interface.

## Attached content
Paths of generated files that are part of this handoff, if any.
```

**Rules:**

- To claim a handoff, an implementer sets `assignee` to itself and `status: in-progress` in the
  first commit of its implementation branch.
- Before starting, the implementer **MUST** compare `base_sha` with the current default branch. If
  files the handoff depends on have changed, it **MUST** say so in the Outcome and adapt or escalate.
- The implementer **MUST NOT** rewrite the planner's sections. It only appends the Outcome and
  updates frontmatter.

### Outcome (appended by the implementer)

```markdown
## Outcome
**Status:** done | partial | blocked  
**Commits:** abc1234..def5678 · **PR:** #13

### Acceptance criteria
- [x] Criterion 1 — evidence: `pytest tests/test_cli.py` (12 passed)
- [ ] Criterion 2 — not met, because …

### Deviations
What differs from the plan, and why.

### New decisions
- `docs/adr/2026-10-24-….md` (Proposed)

### Questions for the planner
- …
```

## 6. Branches and pull requests

| Kind of work | Branch | PR contains |
|---|---|---|
| Planning | `plan/<slug>` | ADRs, handoffs, schemas, generated content |
| Implementation | `impl/<slug>` | Code, tests, Outcome, changelog fragment, `Proposed` ADRs |
| Content only | `content/<slug>` | Generated content files |
| Maintenance | `chore/<slug>`, `fix/<slug>` | Anything else |

- Every change reaches the default branch through a pull request. The only exception is the
  repository's very first commit.
- An implementation PR **MUST** link its handoff in the description.
- PR titles and commit subjects follow [Conventional Commits](https://www.conventionalcommits.org/)
  (`feat:`, `fix:`, `docs:`, `chore:`, `test:`, `refactor:`).
- Agents that cannot use GitHub's GraphQL API (some cloud sessions) open PRs with the REST API,
  e.g. `gh api repos/{owner}/{repo}/pulls -X POST …`.

## 7. Review: default-pass with a self-modification gate

- **Default:** a PR merges automatically once every required check is green. No human approval is
  required.
- **Opt-in human review:** a PR waits for an approving review when it carries the
  `needs-human-review` label, or when any ADR or handoff it adds or changes has `review: human`.
- **Always gated (not optional):** a PR that changes any of the following waits for an approving
  human review, whoever opened it:
  - `AGENTS.md`, `CLAUDE.md`, `docs/PROTOCOL.md`
  - `.agents/skills/**`, `.claude/**`
  - `.github/workflows/**`, `.github/CODEOWNERS`

  This stops any agent — or a prompt injection that reaches one — from loosening the rules that
  constrain it and merging that change itself.
- Tokens given to agents **MUST NOT** have permission to merge or to change branch protection.
  Merging happens through auto-merge.

## 8. Generated content

- Generated data (question banks, fixtures, translations, …) lives under `content/` and **MUST**
  validate against a schema in `schemas/`.
- Each item **SHOULD** carry provenance: `generated_by`, `date`, and `reviewed: false`.
- CI checks structure only: schema validity, required fields, uniqueness, internal references.
  It cannot check factual correctness. Projects **SHOULD** give users a way to flag a wrong item
  (for example a `content/flags.yaml` file or an issue), and planners treat flags as a fix list.
- Implementers **MUST NOT** silently change the meaning of generated content. Formatting fixes are
  fine; a suspected wrong answer goes back to the planner as a question in the Outcome.

## 9. Changelog

- Every PR that changes behaviour adds one fragment: `changelog.d/<slug>.<type>.md`, where `<type>`
  is `added`, `changed`, `fixed`, `removed`, `deprecated` or `security`.
- Fragments are assembled into `CHANGELOG.md` at release time. Nobody edits the same changelog
  line in parallel, so there are no merge conflicts.

## 10. Status

- `docs/STATUS.md` is generated from handoff frontmatter and `Proposed` ADRs after every merge.
- Planners start every session by reading `docs/STATUS.md`.

## 11. Commit identity and attribution

- Commits made by an agent on a maintainer's behalf **MUST** be authored with that maintainer's
  configured git identity (`git config user.name` / `user.email`), not the agent vendor's.
- Commits **MUST NOT** carry a `Co-Authored-By:` trailer naming an AI agent or vendor.
- PRs opened by an agent **MUST** say so in the description footer (for Claude Code: the
  "Generated with Claude Code" line and session link), so their origin stays traceable.
- CI enforces the first two rules with the `commit-identity` workflow.

## 12. Personal settings

Personal, per-person agent preferences go in `AGENTS.local.md` / `CLAUDE.local.md`, which are
git-ignored. Shared files hold only what applies to everyone.

## 13. Changing this protocol

The protocol is versioned with [SemVer](https://semver.org/). Changes are made by PR to
`X-DSI/agent-workflow`, recorded as an ADR, and noted in the changelog. Adopting projects pull them in
with `copier update`.
