# PRP-02: Property terms

| Field | Value |
|---|---|
| Status | todo |
| Milestone | Phase 2 |
| Wave | 9 |
| Parallel | no (runs alone) |
| Depends on | PRP-01, ACC-04 |
| Lane (proposed) | domain:property-terms |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §5 PRP-02; TRACEABILITY key specs: `06` §2, `07` §2 |
| Decisions | D-027 |
| Surfaces | security, scope, external |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/PRP-02 (on dispatch) |
| Review rounds | 0 |

## Goal
Property terms — `specs/15-implementation-plan.md` package PRP-02, Phase 2. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` PRP-02)
- [ ] AC1: Fee model, cleaning-fee keeper, turnover-cost payer and the account VAT rate (`06` §2), admin only (`07` §2).

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- `app/Models/PropertyTerms.php` + migration; migration adding the account VAT rate
- `app/Actions/PropertyTerms/**`, `app/Policies/PropertyTermsPolicy.php`
- terms form under `resources/js/Pages/Staff/Properties/Terms/**`, VAT field on Settings page
- `tests/{Feature,Isolation}/PropertyTerms/**`, `tests/Browser/Onboard*` (Phase 2 exit journey)

Shared files it may edit (serialized by wave planning):
- `app/Models/Account.php` (VAT rate attribute)

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- PRP-01 — inferred: terms belong to a property (03 §7 PROPERTY ||--|| PROPERTY_TERMS)
- ACC-04 — explicit: property terms are audited (03 §6; ACC-04 "ready for every later money-affecting model")

## Notes from main
- Closes Phase 2: proposed owner of the onboarding browser journey (09 §3 #2), then Product Owner checkpoint (16 §12).

## Log

