# OPS-04: Release acceptance

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 6 |
| Wave | 20 |
| Parallel | no (runs alone) |
| Depends on | OPS-01, OPS-02, OPS-03 |
| Lane (proposed) | infra |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §9 OPS-04; TRACEABILITY key specs: `12` §6, `12` §7 |
| Decisions | D-006, D-036 |
| Surfaces | scope |
| Touches red line | no |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | no (no security/data surface, no red line, no contract change) |
| Risk | low |
| Agent ID |  |
| Branch / worktree | impl/OPS-04 (on dispatch) |
| Review rounds | 0 |

## Goal
Release acceptance — `specs/15-implementation-plan.md` package OPS-04, Phase 6. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` OPS-04)
- [ ] AC1: Every journey of `12` §6 and the release gate of `12` §7.

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `tests/Browser/**` (complete the seven journeys of 12 §6)
- release evidence in `TRACEABILITY.md` via LANDING only

Shared files it may edit (serialized by wave planning):
- none

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- OPS-01 — inferred: release gate covers retention
- OPS-02 — inferred
- OPS-03 — inferred: the gate holds on the production host

## Notes from main
- Needs the owner: a month of real reservations matched to the owner's hand calculation (12 §7). Closes Phase 6 + Product Owner checkpoint.

## Log

