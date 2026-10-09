# OUT-02: Guest page and map

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 5 |
| Wave | 18 |
| Parallel | no (runs alone) |
| Depends on | Phase 4 exit, RES-01, PRP-01, PRP-03, OUT-03 |
| Lane (proposed) | outside:guest |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §8 OUT-02; TRACEABILITY key specs: `08` §2, `02` §5, `11` §7 |
| Decisions | D-008, D-013, D-016, D-018, D-032, D-040 |
| Surfaces | data, security, external, ux |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/OUT-02 (on dispatch) |
| Review rounds | 0 |

## Goal
Guest page and map — `specs/15-implementation-plan.md` package OUT-02, Phase 5. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` OUT-02)
- [ ] AC1: The guest page of `08` §2 with the self-hosted map (`02` §5, `11` §7).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- guest-link token hash migration on reservations + issue/reissue action `app/Actions/GuestLinks/**`
- `app/Http/Controllers/Guest/**`, `resources/js/Pages/Guest/**`, `routes/guest.php`
- self-hosted MapLibre + PMTiles serving, `app/Console/Commands/Operator/*Map*` (11 §4 refresh)
- `tests/Feature/{GuestPage,Leaks/Guest*}/**`, `tests/Browser/Guest*`

Shared files it may edit (serialized by wave planning):
- `composer.json`/`package.json` (MapLibre GL JS, PMTiles) — contract root
- reservation staff page (show/copy guest link)

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 4 exit — explicit: 15 §2 P3,P4 → P5
- RES-01 — inferred: one guest link per reservation
- PRP-01 — inferred: address, coordinates, bilingual house text
- PRP-03 — inferred: link-token service
- OUT-03 — serialization: reuses the link-token middleware and the generic inactive-link page OUT-03 creates (08 §4, D-032)

## Notes from main
- Plan says Contract change: no (D-037), but 10 §2 needs a stored hash per reservation: see roadmap-proposal.md §6.

## Log


## Owner ruling (2026-10-09)
OUT-02 adds the migration for the per-reservation guest-link hash required by `10` §2, despite "Contract change: no" in the plan. See `.impl/decisions-log.md`.
