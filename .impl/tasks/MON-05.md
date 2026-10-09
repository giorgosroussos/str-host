# MON-05: Statement PDF and email

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 4 |
| Wave | 16 |
| Parallel | no (runs alone) |
| Depends on | MON-03, MON-04 |
| Lane (proposed) | domain:statement |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: no (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §7 MON-05; TRACEABILITY key specs: `06` §9, `09` §7 |
| Decisions | D-007, D-024, D-025 |
| Surfaces | data, security, scope, external, ux |
| Touches red line | yes |
| Contract change | no |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/MON-05 (on dispatch) |
| Review rounds | 0 |

## Goal
Statement PDF and email — `specs/15-implementation-plan.md` package MON-05, Phase 4. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` MON-05)
- [ ] AC1: The PDF in both languages and the finalisation email (`06` §9, `09` §7).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Pdf/**` or `resources/views/pdf/statement*.blade.php` (dompdf, DejaVu Sans, D-007)
- `app/Jobs/{RenderStatementPdf,SendStatementEmail}*`, `app/Mail/StatementFinalised*`
- `tests/Feature/StatementPdf/**`, `tests/Browser/CloseAMonth*` (Phase 4 exit)

Shared files it may edit (serialized by wave planning):
- `app/Actions/Statements/Finalise*` (dispatch jobs)
- `composer.json` (dompdf) — contract root

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- MON-03 — inferred: finalising produces the PDF and email (06 §9)
- MON-04 — serialization: both edit the finalise action; the PDF renders adjustment lines

## Notes from main
- Closes Phase 4, then Product Owner checkpoint (16 §12).

## Log

