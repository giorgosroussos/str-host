# RES-02: Money lines and climate fee rates

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 3 |
| Wave | 11 |
| Parallel | yes |
| Depends on | RES-01, PRP-01 |
| Lane (proposed) | domain:reservation |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §6 RES-02; TRACEABILITY key specs: `04` §5, `06` §5 |
| Decisions | D-012 |
| Surfaces | data, external |
| Touches red line | no |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/RES-02 (on dispatch) |
| Review rounds | 0 |

## Goal
Money lines and climate fee rates — `specs/15-implementation-plan.md` package RES-02, Phase 3. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` RES-02)
- [ ] AC1: Money lines, the installation rate table and its operator command, and climate fee prefill (`04` §5, `06` §5).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- money-lines migration/model, `app/Models/ClimateFeeRate.php` + migration (installation-wide)
- `app/Actions/MoneyLines/**`, `app/Actions/ClimateFeeRates/**`, `app/Console/Commands/Operator/*ClimateFeeRate*`
- money-line pages `resources/js/Pages/Staff/Reservations/MoneyLines/**`
- `tests/{Feature,Isolation,Unit}/MoneyLines/**`, `tests/Unit/ClimateFee/**`

Shared files it may edit (serialized by wave planning):
- `app/Actions/Reservations/**` and reservation edit page (owned by RES-01, done)

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- RES-01 — inferred: money lines are part of the reservation aggregate; same aggregate never in one wave (15 §10)
- PRP-01 — inferred: property type for the climate rate lookup

## Notes from main
- none yet

## Log

