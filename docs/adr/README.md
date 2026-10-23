# Architecture Decision Records

Decisions about agent-workflow itself. Format and rules: [`docs/PROTOCOL.md` §5](../PROTOCOL.md#5-architecture-decision-records).
Accepted decisions live here; proposals live in [`proposed/`](proposed/).

| Date | Decision | Status |
|---|---|---|
| 2026-10-23 | [Record architecture decisions as dated Markdown ADRs](2026-10-23-record-architecture-decisions.md) | Accepted |
| 2026-10-23 | [The git repository is the only shared memory between agents](2026-10-23-repository-as-shared-memory.md) | Accepted |
| 2026-10-23 | [Planning agents write to the repo by opening pull requests](2026-10-23-pull-requests-as-transport.md) | Accepted |
| 2026-10-23 | [Use AGENTS.md and Agent Skills as the agent-neutral formats](2026-10-23-agents-md-and-agent-skills.md) | Accepted |
| 2026-10-23 | [Default-pass review, with a mandatory gate on self-modifying changes](2026-10-23-default-pass-review-with-self-modification-gate.md) | Superseded by code-owner gating |
| 2026-10-23 | [Validate generated content by structure only, for now](2026-10-23-structure-only-content-validation.md) | Accepted |
| 2026-10-23 | [Agent commits use the maintainer's identity; no AI co-author trailers](2026-10-23-commit-identity-and-attribution.md) | Accepted |
| 2026-10-23 | [Separate the method (this repo) from each project's knowledge](2026-10-23-method-repo-and-project-repos.md) | Accepted |
| 2026-10-23 | [Agents act on GitHub through a dedicated machine account](2026-10-23-agent-machine-account.md) | Accepted |
| 2026-10-23 | [Enforce the self-modification gate with CODEOWNERS and code-owner review](2026-10-23-code-owner-gating.md) | Accepted |
| 2026-10-23 | [Proposed ADRs live in docs/adr/proposed/; accepting one means moving it](2026-10-23-proposed-adr-folder.md) | Accepted |
| 2026-10-23 | [Scale the process to the size of the change](2026-10-23-process-tiers.md) | Accepted |
| 2026-10-23 | [Every acceptance criterion names how it is checked](2026-10-23-verifiable-acceptance-criteria.md) | Accepted |
| 2026-10-23 | [Treat external input as data, never as instructions](2026-10-23-untrusted-input.md) | Accepted |
