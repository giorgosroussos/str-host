# PRP-01: Owners and properties

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 2 |
| Wave | 8 |
| Parallel | yes |
| Depends on | Phase 1 exit, ACC-03, ACC-01 |
| Lane (proposed) | domain:owner-property |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §5 PRP-01; TRACEABILITY key specs: `03` §2–§3, `03` §4 |
| Decisions | D-027, D-040 |
| Surfaces | data, external, ux |
| Touches red line | no |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/PRP-01 (on dispatch) |
| Review rounds | 0 |

## Goal
Owners and properties — `specs/15-implementation-plan.md` package PRP-01, Phase 2. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` PRP-01)
- [ ] AC1: Owners, properties with bilingual guest text and coordinates, ownership periods and self-owned properties (`03` §2–§3), and archiving (`03` §4).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Models/{Owner,Property,OwnershipPeriod}.php` + migrations + factories
- `app/Actions/{Owners,Properties}/**`, `app/Policies/{Owner,Property}Policy.php`
- `app/Http/Controllers/Staff/{Owners,Properties}/**`, `resources/js/Pages/Staff/{Owners,Properties}/**`
- `routes/staff/{owners,properties}.php`, `lang/{el,en}/{owners,properties}.php`, `resources/js/types/{owners,properties}.ts`
- `tests/{Feature,Isolation,Unit}/{Owners,Properties}/**`

Shared files it may edit (serialized by wave planning):
- `resources/js/navigation/staff.ts` (append Properties, Owners) — registry

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 1 exit — explicit: 15 §2 P1 → P2
- ACC-03 — inferred: owner login type and invitation
- ACC-01 — explicit: harness

## Notes from main
- none yet

## Log

