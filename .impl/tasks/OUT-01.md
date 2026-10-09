# OUT-01: Owner portal

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 5 |
| Wave | 17 |
| Parallel | yes |
| Depends on | Phase 4 exit, MON-05, MON-02, ACC-03 |
| Lane (proposed) | outside:owner |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §8 OUT-01; TRACEABILITY key specs: `08` §1 |
| Decisions | D-024, D-040 |
| Surfaces | data, security, scope, ux |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/OUT-01 (on dispatch) |
| Review rounds | 0 |

## Goal
Owner portal — `specs/15-implementation-plan.md` package OUT-01, Phase 5. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` OUT-01)
- [ ] AC1: The read-only portal of `08` §1 with statements, receipts and PDFs.

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `app/Http/Controllers/Owner/**`, `resources/js/Pages/Owner/**`, `routes/owner/*.php`, `lang/{el,en}/owner.php`
- `tests/{Feature,Isolation}/OwnerPortal/**`, `tests/Feature/Leaks/OwnerPortal*`, `tests/Browser/Owner*`

Shared files it may edit (serialized by wave planning):
- none

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 4 exit — explicit: 15 §2 P4 → P5
- MON-05 — inferred: PDF download
- MON-02 — inferred: receipts of owner-charged expenses
- ACC-03 — inferred: owner login and owner scoping

## Notes from main
- none yet

## Log

