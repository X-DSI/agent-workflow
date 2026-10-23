---
title: Use AGENTS.md and Agent Skills as the agent-neutral formats
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
The system must work with agents beyond Claude (Codex, Cursor, Copilot, Gemini CLI, …). Claude Code
reads `CLAUDE.md`, not `AGENTS.md`; most other agents read `AGENTS.md`. Agent Skills (`SKILL.md`
folders) are an open format supported by Claude (web and Code) and many other agents.

## Options
- **CLAUDE.md only** — simplest, but other agents walk in blind.
- **AGENTS.md as source, CLAUDE.md imports it** — one file to maintain; works on every OS.
- **Symlink CLAUDE.md → AGENTS.md** — one file, but symlinks are awkward on Windows.

## Decision
`AGENTS.md` is the source of truth for agent instructions. `CLAUDE.md` contains `@AGENTS.md` plus any
Claude-only notes. Reusable procedures ship as Agent Skills in `.agents/skills/`, and are mirrored
into `.claude/skills/` until Claude Code's discovery of `.agents/skills/` is confirmed.

## Consequences
- One instruction file serves every agent.
- The claude.ai copy of a skill is a manual upload, so skills carry a version and must warn when it
  differs from the repo's protocol version.
