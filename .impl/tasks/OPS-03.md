# OPS-03: Production deployment and backups

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 6 |
| Wave | 19 |
| Parallel | yes |
| Depends on | Phase 5 exit, MON-02 |
| Lane (proposed) | infra |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §9 OPS-03; TRACEABILITY key specs: `11` §2–§3, `11` §5 |
| Decisions | D-019, D-034 |
| Surfaces | data, security, scope, external |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/OPS-03 (on dispatch) |
| Review rounds | 0 |

## Goal
Production deployment and backups — `specs/15-implementation-plan.md` package OPS-03, Phase 6. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` OPS-03)
- [ ] AC1: The production setup of `11` §2–§3, backups and a rehearsed restore (`11` §5).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `deploy/**`, `docker-compose.prod.yml`, proxy/TLS config, `scripts/backup/**`, restore runbook under `docs/operations/**`

Shared files it may edit (serialized by wave planning):
- `Makefile` `smoke` against production (contract root)

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 5 exit — explicit: 15 §2
- MON-02 — inferred: receipt files are part of the nightly backup (11 §5)

## Notes from main
- Needs owner-provided resources: EU VPS, domain/DNS, EU transactional email account (11 §2–§3). Rehearsed restore is a recorded run, not a test.

## Log

