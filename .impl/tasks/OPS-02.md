# OPS-02: Account lifecycle and data requests

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 6 |
| Wave | 19 |
| Parallel | yes |
| Depends on | Phase 5 exit, ACC-02 |
| Lane (proposed) | domain:account-lifecycle |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §9 OPS-02; TRACEABILITY key specs: `10` §6–§7, `11` §4 |
| Decisions | D-023, D-025 |
| Surfaces | data, security, external |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/OPS-02 (on dispatch) |
| Review rounds | 0 |

## Goal
Account lifecycle and data requests — `specs/15-implementation-plan.md` package OPS-02, Phase 6. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` OPS-02)
- [ ] AC1: Suspend, export, delete and person export or erasure commands (`10` §6–§7, `11` §4).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Actions/{AccountLifecycle,DataRequests}/**`
- `app/Console/Commands/Operator/{Suspend,Export,Delete}Account*`, `*Person*`
- `tests/Feature/{AccountLifecycle,DataRequests}/**`

Shared files it may edit (serialized by wave planning):
- `routes/console.php` (90-day deletion schedule) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 5 exit — explicit: 15 §2
- ACC-02 — inferred: account status and the operator-command base

## Notes from main
- "Erase a person" (11 §4) and OPS-01 erasure may share code: keep it in OPS-02's folder and let OPS-01 not depend on it, or serialize.

## Log

