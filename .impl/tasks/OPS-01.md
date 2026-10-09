# OPS-01: Retention jobs

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 6 |
| Wave | 19 |
| Parallel | yes |
| Depends on | Phase 5 exit, RES-01, ACC-04, PRP-01, PRP-03 |
| Lane (proposed) | domain:retention |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §9 OPS-01; TRACEABILITY key specs: `10` §5 |
| Decisions | D-017, D-025 |
| Surfaces | data |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/OPS-01 (on dispatch) |
| Review rounds | 0 |

## Goal
Retention jobs — `specs/15-implementation-plan.md` package OPS-01, Phase 6. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` OPS-01)
- [ ] AC1: Anonymisation and erasure of `10` §5 on the scheduler.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Actions/Retention/**`, `app/Jobs/Retention/**`
- `tests/Feature/Retention/**`

Shared files it may edit (serialized by wave planning):
- `routes/console.php` (daily schedule) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 5 exit — explicit: 15 §2 P4,P5 → P6
- RES-01 — inferred: guest data to anonymise
- ACC-04 — inferred: audit entries are anonymised too (10 §5)
- PRP-01 — inferred: archived owners
- PRP-03 — inferred: archived cleaners

## Notes from main
- none yet

## Log

