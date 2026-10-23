# AGENTS.md — agent-workflow

Instructions for any AI agent working in this repository.

## What this repo is

agent-workflow is a reusable system that lets planning-side AI sessions (e.g. Claude in the web app)
and coding-side AI sessions (e.g. Claude Code, Codex) collaborate through a git repository. This repo
holds the **method**: the protocol, the project template, the Agent Skill, and reusable CI workflows.
It also **uses its own method** — treat it as an adopting project.

## Before you do anything

1. Read [`docs/PROTOCOL.md`](docs/PROTOCOL.md). It is binding.
2. Read [`docs/STATUS.md`](docs/STATUS.md) if it exists, and any open handoffs in `docs/handoff/`.
3. Read the ADRs in [`docs/adr/`](docs/adr/) that relate to your task.

## Rules that matter most here

- Every change goes through a pull request. Never push to `main`.
- Commits are authored with the maintainer's git identity. Never add a `Co-Authored-By:` trailer
  naming an AI agent. (Enforced by CI.)
- Changes to `AGENTS.md`, `CLAUDE.md`, `docs/PROTOCOL.md`, `.agents/skills/`, `.claude/`, or
  `.github/workflows/` always need a human review. Say so in the PR description.
- If a change alters a rule, write an ADR for it in the same PR.
- Add a `changelog.d/` fragment for any change in behaviour.
- Open PRs with the GitHub REST API if GraphQL (`gh pr create`) is unavailable in your session.

## Layout

| Path | Contents |
|---|---|
| `docs/PROTOCOL.md` | The rulebook adopting projects follow |
| `docs/adr/` | Decisions about agent-workflow itself |
| `docs/handoff/` | Open and finished work orders for this repo |
| `.github/workflows/` | Reusable workflows (`workflow_call`) that adopting projects call, and this repo's own CI |
| `template/` | *(planned)* copier template for new projects |
| `skill/` | *(planned)* the `project-handoff` Agent Skill |

## Commands

| Task | Command |
|---|---|
| Check commit identity locally | `bash .github/scripts/check-commit-identity.sh origin/main HEAD` |
