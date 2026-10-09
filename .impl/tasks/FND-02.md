# FND-02: CI baseline

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 0 |
| Wave | 2 |
| Parallel | no (runs alone) |
| Depends on | FND-01 |
| Lane (proposed) | infra |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §3 FND-02; TRACEABILITY key specs: `12` §1 |
| Decisions | D-006, D-036 |
| Surfaces | ux |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/FND-02 (on dispatch) |
| Review rounds | 0 |

## Goal
CI baseline — `specs/15-implementation-plan.md` package FND-02, Phase 0. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` FND-02)
- [ ] AC1: A pipeline on the project's remote, running on every merge request and every push to the default branch, against PostgreSQL 16 as a service, never a lighter substitute (`12` §1).
- [ ] AC2: Every job runs exactly one `Makefile` target, so "CI is green" and "`make verify` is green" are the same statement; `README.md` maps job to command.
- [ ] AC3: `make check-docs` runs as its own job.
- [ ] AC4: Every gate the testing specification requires but nothing implements yet is a failing-forward tripwire: a job that passes only while the gate is provably absent and fails with promotion instructions the moment it becomes runnable. A missing gate and a silently passing gate must never look alike.
- [ ] AC5: Dependency and secret scanning; artifact and cache strategy; no job retries.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `.github/workflows/**`
- `README.md` "Continuous integration" section only
- CI helper scripts under `scripts/ci/**` (new)

Shared files it may edit (serialized by wave planning):
- `Makefile`: only if a target needs a CI-friendly flag (contract root)

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- FND-01 — explicit: every job runs a Makefile target FND-01 makes real; PLAN.md Next #1

## Notes from main
- The remote is github.com; a pre-receive hook cannot be installed there. Proposed: add a job that runs `scripts/lock-guard.py` over the pushed range (it reads a diff from stdin) so lock enforcement exists server-side. FND-02 text does not name this job; owner to confirm (roadmap-proposal.md §5).
- Exit criterion "a red pipeline blocks a merge" needs branch protection on GitHub: an owner action, not a code change.

## Log


## Owner ruling (2026-10-09)
Include a CI job that runs the lock check over a commit range (new make target that accepts a range). This changes the Makefile target list, so the package's LANDING block must include a DECISIONS.md entry (via the event log) recording it. See `.impl/decisions-log.md`.
