# MON-06: Dashboard and cleaner pay summary

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 4 |
| Wave | 14 |
| Parallel | yes |
| Depends on | MON-01, RES-02, RES-04 |
| Lane (proposed) | staff-ui |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §7 MON-06; TRACEABILITY key specs: `09` §2, `05` §4 |
| Decisions | D-022 |
| Surfaces | scope, external |
| Touches red line | no |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | no (no security/data surface, no red line, no contract change) |
| Risk | low |
| Agent ID |  |
| Branch / worktree | impl/MON-06 (on dispatch) |
| Review rounds | 0 |

## Goal
Dashboard and cleaner pay summary — `specs/15-implementation-plan.md` package MON-06, Phase 4. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` MON-06)
- [ ] AC1: The admin dashboard (`09` §2) and the cleaner pay summary (`05` §4).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `app/Http/Controllers/Staff/{Dashboard,CleanerPay}/**`, `resources/js/Pages/Staff/{Dashboard,CleanerPay}/**`
- `app/Queries/{Dashboard,CleanerPay}/**`
- `routes/staff/dashboard.php`, `lang/{el,en}/dashboard.php`
- `tests/{Feature,Isolation}/{Dashboard,CleanerPay}/**`

Shared files it may edit (serialized by wave planning):
- `resources/js/navigation/staff.ts` (Dashboard) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- MON-01 — inferred: net rental income comes from the engine
- RES-02 — inferred: money lines
- RES-04 — inferred: pay summary of done turnovers

## Notes from main
- Read-only: no migration.

## Log

