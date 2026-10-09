# ACC-01: Tenancy and isolation harness

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 1 |
| Wave | 4 |
| Parallel | no (runs alone) |
| Depends on | Phase 0 exit |
| Lane (proposed) | domain:account |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §4 ACC-01; TRACEABILITY key specs: `02` §3, `12` §3 |
| Decisions | D-009, D-026, D-038, D-039 |
| Surfaces | security, external |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/ACC-01 (on dispatch) |
| Review rounds | 0 |

## Goal
Tenancy and isolation harness — `specs/15-implementation-plan.md` package ACC-01, Phase 1. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` ACC-01)
- [ ] AC1: `company_id` and the global scope of `02` §3 on a first tenant model; the isolation suite of `12` §3 as a reusable harness every later package extends.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Models/Account.php`, `app/Models/Concerns/BelongsToAccount*` (global scope), `app/Support/Tenancy/**`
- accounts migration + first tenant model migration
- `tests/Isolation/**` harness (`tests/Isolation/Support/**`), `tests/Isolation/Tenancy/**`
- tenant-context middleware `app/Http/Middleware/*Tenant*`

Shared files it may edit (serialized by wave planning):
- `bootstrap/app.php` (middleware registration) — contract root / global middleware

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 0 exit — explicit: 15 §2 P0 → P1

## Notes from main
- "A first tenant model": which model is not named. Propose `Login` (the first account-scoped entity, 03 §2) — but ACC-02/03 then extend it. Owner to confirm (roadmap-proposal.md §6).

## Log

