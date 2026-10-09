# RES-04: Turnovers

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 3 |
| Wave | 12 |
| Parallel | no (runs alone) |
| Depends on | RES-01, PRP-03, PRP-01, PRP-02, RES-02 |
| Lane (proposed) | domain:turnover |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §6 RES-04; TRACEABILITY key specs: `05` §1–§2 |
| Decisions | D-014, D-015, D-020, D-029 |
| Surfaces | data, security, external, ux |
| Touches red line | no |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/RES-04 (on dispatch) |
| Review rounds | 0 |

## Goal
Turnovers — `specs/15-implementation-plan.md` package RES-04, Phase 3. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` RES-04)
- [ ] AC1: Turnovers at check-out, assignment, completion by staff, cost and following the reservation (`05` §1–§2).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `app/Models/Turnover.php` + migration + factory
- `app/Actions/Turnovers/**`, `app/Policies/TurnoverPolicy.php`
- `app/Http/Controllers/Staff/Turnovers/**`, `resources/js/Pages/Staff/Turnovers/**`, `routes/staff/turnovers.php`, `lang/{el,en}/turnovers.php`
- `tests/{Feature,Isolation,Unit}/Turnovers/**`, `tests/Browser/RunAMonth*` (Phase 3 exit, up to turnovers done)

Shared files it may edit (serialized by wave planning):
- `app/Actions/Reservations/**` (create/move/delete turnover on reservation changes; RES-01 done)
- `resources/js/navigation/staff.ts` (Turnovers) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- RES-01 — inferred: a turnover is created at a reservation's check-out
- PRP-03 — inferred: assigned to a cleaner
- PRP-01 — inferred: default turnover cost
- PRP-02 — inferred: who pays the turnover cost
- RES-02 — serialization: both edit `app/Actions/Reservations/**` (create/move/cancel hooks vs money lines); not a domain dependency

## Notes from main
- Closes Phase 3, then Product Owner checkpoint (16 §12).

## Log

