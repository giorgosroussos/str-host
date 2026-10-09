# ACC-03: Logins, invitations, roles and second factor

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 1 |
| Wave | 6 |
| Parallel | no (runs alone) |
| Depends on | ACC-01, ACC-02 |
| Lane (proposed) | domain:login |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §4 ACC-03; TRACEABILITY key specs: `07` §1–§4, `10` §9 |
| Decisions | D-033, D-039 |
| Surfaces | data, security |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/ACC-03 (on dispatch) |
| Review rounds | 0 |

## Goal
Logins, invitations, roles and second factor — `specs/15-implementation-plan.md` package ACC-03, Phase 1. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` ACC-03)
- [ ] AC1: Invitations, the admin and operations roles, the permission matrix as policies, the owner login type, and the second factor (`07` §1–§4, `10` §9).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `app/Models/Login.php` (roles, owner login type), invitations model/migration
- `app/Actions/Logins/**`, `app/Actions/Invitations/**`
- `app/Authorization/**` — the whole 07 §2 permission matrix (central policies), staff/owner surface guards
- account settings + staff logins pages `resources/js/Pages/Staff/Settings/**`
- second factor, password reset (09 §7, 10 §9) pages and mails
- `tests/Isolation/Matrix/**` (every cell testable now), `tests/Feature/Logins/**`

Shared files it may edit (serialized by wave planning):
- `config/fortify.php`, `FortifyServiceProvider` (2FA, reset) — contract root
- `HandleInertiaRequests` (auth/role props) — contract root

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- ACC-01 — explicit: isolation harness
- ACC-02 — inferred: logins belong to an approved account; both edit the Login aggregate and Fortify config, so they never share a wave

## Notes from main
- Proposed: encode the complete 07 §2 matrix here so later packages only add per-model `app/Policies/<Model>Policy.php` and their cell tests, never edit the central matrix. Password reset is not cited by any package; proposed here (10 §9 rate-limits reset forms).

## Log

