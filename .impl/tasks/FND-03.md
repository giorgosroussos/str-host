# FND-03: Design, accessibility and localization foundation

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 0 |
| Wave | 3 |
| Parallel | no (runs alone) |
| Depends on | FND-01, FND-02 |
| Lane (proposed) | staff-ui |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §3 FND-03; TRACEABILITY key specs: `02` §4, `09` §5–§6, `09` §9 |
| Decisions | D-018, D-024, D-036 |
| Surfaces | security, scope, ux |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/FND-03 (on dispatch) |
| Review rounds | 0 |

## Goal
Design, accessibility and localization foundation — `specs/15-implementation-plan.md` package FND-03, Phase 0. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` FND-03)
- [ ] AC1: Shared tokens and base components, focus and error patterns, responsive shell for the four entry surfaces of `02` §4, branded per `09` §5.
- [ ] AC2: Localization skeleton with the fallback rule of `09` §6; no hard-coded UI strings.
- [ ] AC3: Automated accessibility smoke test wired as a real gate, replacing its tripwire (`09` §9, `12` §1).

## Proposed file surface (PENDING OWNER APPROVAL — the pre-W10 plan states none)
Owns (exclusive while in flight):
- `resources/js/Components/**`, `resources/js/Layouts/**`, `resources/css/**`
- `resources/js/navigation/**` (staff navigation registry)
- `resources/js/Pages/Shared/**` (error pages; not the inactive-link page)
- `lang/{el,en}/common.php` and the key-parity test
- `tests/Browser/Accessibility/**`
- self-hosted fonts/assets under `public/` (no runtime CDN, D-018)

Shared files it may edit (serialized by wave planning):
- `.github/workflows/**` and `Makefile` `test-browser` (promote the accessibility tripwire)
- `app/Http/Middleware/HandleInertiaRequests.php` (locale, branding props) — contract root

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- FND-01 — inferred: needs the Inertia/Vue scaffold
- FND-02 — explicit: "replacing its tripwire": the accessibility tripwire is an FND-02 job

## Notes from main
- none yet

## Log

