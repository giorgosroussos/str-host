# MON-01: Calculation engine

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 4 |
| Wave | 13 |
| Parallel | yes |
| Depends on | Phase 3 exit |
| Lane (proposed) | money |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §7 MON-01; TRACEABILITY key specs: `06` §1–§4, `12` §5 |
| Decisions | D-012, D-015, D-031, D-040 |
| Surfaces | data, external |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/MON-01 (on dispatch) |
| Review rounds | 0 |

## Goal
Calculation engine — `specs/15-implementation-plan.md` package MON-01, Phase 4. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` MON-01)
- [ ] AC1: The pure calculation of `06` §1–§4 and §7 in `app/Money`, with the golden tests of `12` §5.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Money/**` only (no database, no framework calls; 02 §1)
- `tests/Unit/Money/**` (golden tests of 12 §5)

Shared files it may edit (serialized by wave planning):
- none

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 3 exit — explicit: 15 §2 P3 → P4

## Notes from main
- Pure module; could run any time after FND-01 but phases run in order.

## Log

