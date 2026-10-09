# MON-02: Expenses and receipts

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 4 |
| Wave | 13 |
| Parallel | yes |
| Depends on | PRP-01, ACC-04 |
| Lane (proposed) | domain:expense |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §7 MON-02; TRACEABILITY key specs: `06` §6, `03` §2, `10` §5 |
| Decisions | D-021 |
| Surfaces | data, scope, external, ux |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/MON-02 (on dispatch) |
| Review rounds | 0 |

## Goal
Expenses and receipts — `specs/15-implementation-plan.md` package MON-02, Phase 4. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` MON-02)
- [ ] AC1: Expenses and receipt files (`06` §6), stored and served per `03` §2 and `10` §5.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Models/{Expense,Receipt}.php` + migrations + factories
- `app/Actions/Expenses/**`, `app/Policies/{Expense,Receipt}Policy.php`
- private receipt disk + authorised receipt controller `app/Http/Controllers/Staff/Expenses/**`
- `resources/js/Pages/Staff/Expenses/**`, `routes/staff/expenses.php`, `lang/{el,en}/expenses.php`
- `tests/{Feature,Isolation,Unit}/Expenses/**`

Shared files it may edit (serialized by wave planning):
- `config/filesystems.php` (private disk) and `composer.json` (HEIC conversion, D-021) — contract root
- `resources/js/navigation/staff.ts` (Expenses) — registry
- `tests/Browser/RunAMonth*` (append "enter expenses with receipts" step, 09 §3 #3)

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- PRP-01 — inferred: an expense belongs to a property
- ACC-04 — explicit: expenses are audited

## Notes from main
- none yet

## Log

