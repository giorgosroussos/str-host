# MON-04: Adjustments and carry-forward

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 4 |
| Wave | 15 |
| Parallel | no (runs alone) |
| Depends on | MON-03, MON-01 |
| Lane (proposed) | domain:adjustment |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §7 MON-04; TRACEABILITY key specs: `06` §7–§8 |
| Decisions | D-028 |
| Surfaces | data, external |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/MON-04 (on dispatch) |
| Review rounds | 0 |

## Goal
Adjustments and carry-forward — `specs/15-implementation-plan.md` package MON-04, Phase 4. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` MON-04)
- [ ] AC1: Computed adjustments after finalisation and negative carry-forward (`06` §7–§8).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Models/Adjustment.php` + migration
- `app/Actions/Adjustments/**`, `app/Policies/AdjustmentPolicy.php`
- `tests/{Feature,Isolation,Unit}/Adjustments/**`

Shared files it may edit (serialized by wave planning):
- `app/Actions/Statements/Finalise*` (negative carry-forward)
- edit hooks in `app/Actions/{Reservations,MoneyLines,Expenses,Turnovers}/**` (post an adjustment when a counted record changes)

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- MON-03 — inferred: adjustments arise after finalisation and carry-forward at finalisation
- MON-01 — inferred: computed by the engine

## Notes from main
- Touches four done packages' actions: runs alone.

## Log

