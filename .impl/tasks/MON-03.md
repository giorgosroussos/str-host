# MON-03: Statement lifecycle

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 4 |
| Wave | 14 |
| Parallel | yes |
| Depends on | MON-01, MON-02, RES-02, RES-04 |
| Lane (proposed) | domain:statement |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §7 MON-03; TRACEABILITY key specs: `06` §9 |
| Decisions | D-028, D-031, D-038 |
| Surfaces | data, scope, external |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/MON-03 (on dispatch) |
| Review rounds | 0 |

## Goal
Statement lifecycle — `specs/15-implementation-plan.md` package MON-03, Phase 4. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` MON-03)
- [ ] AC1: Drafts, finalisation snapshot, payout recording, the self-owned monthly view (`06` §9).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Models/{Statement,Payout}.php` + migrations
- `app/Actions/Statements/**` (draft, finalise snapshot, payout), `app/Policies/StatementPolicy.php`
- `app/Http/Controllers/Staff/Statements/**`, `resources/js/Pages/Staff/Statements/**` incl. self-owned monthly view
- `routes/staff/statements.php`, `lang/{el,en}/statements.php`
- `tests/{Feature,Isolation}/Statements/**`

Shared files it may edit (serialized by wave planning):
- `resources/js/navigation/staff.ts` (Statements) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- MON-01 — inferred: drafts are computed by the engine
- MON-02 — inferred: payout subtracts owner-charged expenses (06 §7)
- RES-02 — inferred: finalisation needs complete money lines (D-028)
- RES-04 — inferred: owner-paid turnover cost on the reservation line (D-015)

## Notes from main
- none yet

## Log

