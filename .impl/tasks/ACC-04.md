# ACC-04: Audit trail

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 1 |
| Wave | 7 |
| Parallel | no (runs alone) |
| Depends on | ACC-01, ACC-03 |
| Lane (proposed) | domain:audit |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §4 ACC-04; TRACEABILITY key specs: `03` §6, `10` §4 |
| Decisions | D-017 |
| Surfaces | data |
| Touches red line | no |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/ACC-04 (on dispatch) |
| Review rounds | 0 |

## Goal
Audit trail — `specs/15-implementation-plan.md` package ACC-04, Phase 1. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` ACC-04)
- [ ] AC1: The audit entry of `03` §6 and its admin view (`10` §4), ready for every later money-affecting model.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Models/AuditEntry.php`, its migration, `app/Audit/**` (recorder later packages call)
- `app/Http/Controllers/Staff/Audit/**`, `resources/js/Pages/Staff/Audit/**`
- `tests/Feature/Audit/**`, `tests/Isolation/Audit/**`

Shared files it may edit (serialized by wave planning):
- none

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- ACC-01 — explicit: isolation harness
- ACC-03 — inferred: the admin view needs the admin role and the matrix cell "Dashboard, audit trail"

## Notes from main
- Closes Phase 1: owns the Phase 1 exit browser test extension (invite operations user and owner) together with ACC-03's journey, if not already delivered.

## Log

