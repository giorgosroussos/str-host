# ACC-02: Sign-up, approval and terms

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 1 |
| Wave | 5 |
| Parallel | no (runs alone) |
| Depends on | ACC-01 |
| Lane (proposed) | domain:account |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §4 ACC-02; TRACEABILITY key specs: `01` §4, `10` §8, `11` §4 |
| Decisions | D-023, D-033, D-035 |
| Surfaces | security, scope, external |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/ACC-02 (on dispatch) |
| Review rounds | 0 |

## Goal
Sign-up, approval and terms — `specs/15-implementation-plan.md` package ACC-02, Phase 1. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` ACC-02)
- [ ] AC1: Public sign-up with email verification, a pending state until the operator command approves it, and recorded terms acceptance (`01` §4, `10` §8, `11` §4).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `app/Actions/Accounts/**` (sign-up, approval)
- terms acceptance + terms versions model/migration
- `app/Console/Commands/Operator/**` base (command logging per 11 §4) + `ApproveAccount` command
- sign-up / verify / pending pages `resources/js/Pages/Auth/SignUp*`
- `app/Mail/AccountActive*`, verify-email mail view
- `tests/Feature/Accounts/**`, `tests/Isolation/Accounts/**`, `tests/Browser/GetAnAccount*`

Shared files it may edit (serialized by wave planning):
- `config/fortify.php`, `app/Providers/FortifyServiceProvider.php` (registration, email verification) — contract root

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- ACC-01 — explicit: "a reusable harness every later package extends"
- ACC-01 — inferred: sign-up creates an account and its first login

## Notes from main
- First operator command: proposed owner of the shared operator-command logging base reused by RES-02, OUT-02, OPS-02.

## Log

