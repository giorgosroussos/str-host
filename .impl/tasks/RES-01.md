# RES-01: Reservations and overlap

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 3 |
| Wave | 10 |
| Parallel | no (runs alone) |
| Depends on | Phase 2 exit, PRP-01, ACC-04 |
| Lane (proposed) | domain:reservation |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §6 RES-01; TRACEABILITY key specs: `04` §1–§4 |
| Decisions | D-010, D-020, D-040 |
| Surfaces | data, scope |
| Touches red line | no |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/RES-01 (on dispatch) |
| Review rounds | 0 |

## Goal
Reservations and overlap — `specs/15-implementation-plan.md` package RES-01, Phase 3. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` RES-01)
- [ ] AC1: Reservation entry, channels, lifecycle and cancellation, and the overlap constraint (`04` §1–§4).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `app/Models/Reservation.php` + migrations (exclusion constraint) + factory
- `app/Actions/Reservations/**`, `app/Policies/ReservationPolicy.php`
- `app/Http/Controllers/Staff/Reservations/**`, `resources/js/Pages/Staff/Reservations/**`, `routes/staff/reservations.php`, `lang/{el,en}/reservations.php`
- `tests/{Feature,Isolation,Unit}/Reservations/**`

Shared files it may edit (serialized by wave planning):
- `resources/js/navigation/staff.ts` (Reservations) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 2 exit — explicit: 15 §2 P2 → P3
- PRP-01 — inferred: a reservation belongs to a property
- ACC-04 — explicit: reservations are audited

## Notes from main
- The shared model of Phase 3: runs alone so RES-02/03/04 build on it (15 §10 "after a phase's shared model and contracts are merged").

## Log

