# OUT-03: Cleaner link

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 5 |
| Wave | 17 |
| Parallel | yes |
| Depends on | Phase 4 exit, PRP-03, RES-04 |
| Lane (proposed) | outside:cleaner |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §8 OUT-03; TRACEABILITY key specs: `08` §3 |
| Decisions | D-013, D-030, D-032, D-040 |
| Surfaces | data, security, ux |
| Touches red line | no |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/OUT-03 (on dispatch) |
| Review rounds | 0 |

## Goal
Cleaner link — `specs/15-implementation-plan.md` package OUT-03, Phase 5. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` OUT-03)
- [ ] AC1: The cleaner page of `08` §3 with marking done.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Http/Middleware/ResolveLinkToken*` (shared by guest and cleaner)
- `resources/js/Pages/Shared/InactiveLink.vue` (08 §4, D-032)
- `app/Http/Controllers/Cleaner/**`, `resources/js/Pages/Cleaner/**`, `routes/cleaner.php`, `lang/{el,en}/cleaner.php`
- `tests/Feature/{CleanerLink,Leaks/Cleaner*}/**`, `tests/Browser/Cleaner*`

Shared files it may edit (serialized by wave planning):
- `bootstrap/app.php` (middleware alias) — contract root

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- Phase 4 exit — explicit: 15 §2 P3,P4 → P5
- PRP-03 — inferred: cleaner link tokens
- RES-04 — inferred: turnovers and marking done

## Notes from main
- Proposed owner of the shared link resolver and inactive-link page, so OUT-02 follows it.

## Log

