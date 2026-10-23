---
title: Separate the method (this repo) from each project's knowledge (its own repo)
status: Accepted
date: 2026-10-23
deciders: [X-DSI]
origin: web
supersedes: null
superseded_by: null
review: auto
---

## Context
The system must be reusable across all future projects and must be able to evolve as it is used.
Projects need their own decisions and history; the method needs one home.

## Options
- **Copy files into each project by hand** — no tooling, but every project drifts.
- **A template with update support (copier) plus reusable CI workflows** — projects start from the
  template and pull later improvements.
- **Cookiecutter** — popular, but cannot update a project after it is generated.

## Decision
`X-DSI/agent-workflow` holds the method: protocol, copier template, Agent Skill and reusable GitHub
Actions workflows. Each project keeps its own ADRs, handoffs, status and content in its own repo.
Projects are created with `copier copy`, pull method updates with `copier update`, and call CI via
`uses: X-DSI/agent-workflow/.github/workflows/<name>.yml@<tag>`.

## Consequences
- Project decisions never land in this repo; method changes never require editing every project.
- Guardrail fixes ship once, as a new workflow tag.
- This repo must itself follow the protocol (dogfooding), and versions its releases with tags.
