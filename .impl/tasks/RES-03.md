# RES-03: Calendar and timeline

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 3 |
| Wave | 11 |
| Parallel | yes |
| Depends on | RES-01 |
| Lane (proposed) | staff-ui |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §6 RES-03; TRACEABILITY key specs: `04` §6, `09` §1 |
| Decisions | D-040 |
| Surfaces | scope, ux |
| Touches red line | no |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | no (no security/data surface, no red line, no contract change) |
| Risk | low |
| Agent ID |  |
| Branch / worktree | impl/RES-03 (on dispatch) |
| Review rounds | 0 |

## Goal
Calendar and timeline — `specs/15-implementation-plan.md` package RES-03, Phase 3. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` RES-03)
- [ ] AC1: Per-property calendar and the multi-property timeline as the staff home (`04` §6, `09` §1).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Http/Controllers/Staff/{Timeline,Calendar}/**`, `resources/js/Pages/Staff/{Timeline,Calendar}/**`
- `routes/staff/timeline.php`, `lang/{el,en}/timeline.php`
- `tests/{Feature,Isolation}/Timeline/**`

Shared files it may edit (serialized by wave planning):
- staff home redirect after login (Fortify `home`) — contract root
- `resources/js/navigation/staff.ts` (Timeline first) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- RES-01 — inferred: calendar and timeline are views of reservations

## Notes from main
- Read-only: no migration.

## Log

