# PRP-03: Cleaners and their links

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 2 |
| Wave | 8 |
| Parallel | yes |
| Depends on | ACC-03, ACC-01 |
| Lane (proposed) | domain:cleaner |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §5 PRP-03; TRACEABILITY key specs: `05` §3, `10` §2 |
| Decisions | D-013 |
| Surfaces | data, security |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/PRP-03 (on dispatch) |
| Review rounds | 0 |

## Goal
Cleaners and their links — `specs/15-implementation-plan.md` package PRP-03, Phase 2. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` PRP-03)
- [ ] AC1: Cleaners, link issue, revoke and reissue (`05` §3, `10` §2).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `app/Models/Cleaner.php` + migration + factory
- `app/Actions/Cleaners/**`, `app/Policies/CleanerPolicy.php`
- `app/Support/LinkTokens/**` (256-bit token, SHA-256 hash, D-013) reused by OUT-02/OUT-03
- `app/Http/Controllers/Staff/Cleaners/**`, `resources/js/Pages/Staff/Cleaners/**`, `routes/staff/cleaners.php`, `lang/{el,en}/cleaners.php`
- `tests/{Feature,Isolation,Unit}/Cleaners/**`

Shared files it may edit (serialized by wave planning):
- `resources/js/navigation/staff.ts` (09 §1 has no "Cleaners" section; where cleaners sit is a worker question) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- ACC-03 — inferred: operations may manage cleaners (07 §2)
- ACC-01 — explicit: harness

## Notes from main
- none yet

## Log

