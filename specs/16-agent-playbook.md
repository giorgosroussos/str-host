# GenAI SWE Agent Playbook

## 1. Purpose

This playbook turns the specs into bounded coding tasks while controlling hallucinated scope, inconsistent abstractions and unsafe migrations. The operating rules that can be checked mechanically are not repeated here; `make check-docs` enforces them.

## 2. Required task packet

Every agent receives:

- one task ID and one concrete outcome;
- exact relevant spec files and sections;
- repository conventions and current architecture notes;
- dependencies already merged;
- files or modules it may change and the known shared-file owner;
- executable acceptance criteria;
- explicit non-goals;
- commands for lint, tests and build (always `make` targets).

Do not give every agent the whole project unless the task is architectural review. Retrieve only the relevant specs plus `specs/README.md` and `14-decision-register.md`. From `DECISIONS.md`, read the index and the entries the current `PLAN.md` item cites.

## 3. Agent execution contract

The agent MUST: [D-005]

1. inspect current code and tests before editing;
2. restate assumptions and flag conflicts with locked decisions;
3. implement the smallest coherent slice;
4. add or update tests in the same change;
5. run targeted tests, then the relevant broader suite;
6. update shared type definitions and docs when contracts change;
7. report changed behavior, migration and rollback implications and remaining risks.

The agent MUST NOT: [D-005]

- change product scope or locked decisions;
- introduce channel sync or pricing, bookings, invoicing or myDATA, guest or cleaner messaging, online payments, account billing, file import, blocked dates or any other excluded capability;
- trust client-supplied tenant/owner identifiers;
- weaken a test merely to make CI pass;
- edit unrelated user code or reformat the repository broadly;
- create speculative abstractions without an MVP consumer;
- commit secrets, sample personal data or raw access tokens;
- perform destructive migrations without an approved migration plan.

## 4. Standard task template

```markdown
# TASK <ID>: <Outcome>

## Context
- Specs: `<file>` §<section>
- Dependencies: <merged tasks>
- Locked decisions: <relevant bullets of the register>
- Decisions to read: <D-NNN entries this task relies on>

## Deliverable
<One observable result>

## Allowed scope
- <modules/files or bounded area>

## Acceptance criteria
- [ ] <executable behavior/test>
- [ ] tenant/owner isolation cases added
- [ ] Authorization and validation enforced server-side
- [ ] shared type definitions updated if applicable
- [ ] Targeted and regression commands pass

## Explicit non-goals
- <features not to implement>

## Handoff
- Behavior changed
- Tests/commands run
- Migrations and rollback notes
- Security/privacy considerations
- Follow-up items, without implementing them
```

## 5. Definition of Ready

A task is ready only when dependencies are merged, domain and contract behavior is unambiguous, acceptance can be tested, fixtures and roles are identified, and no unresolved card in `QUESTIONS.md` with a `Blocks:` field naming this task or its phase is still open.

## 6. Definition of Done

- Acceptance criteria and the relevant spec behavior implemented.
- Tests include happy path, validation, authorization, tenant/owner isolation and the important state or concurrency failure.
- Static analysis, lint and build pass.
- Migration works on existing data and rollback or forward recovery is documented.
- shared type definitions synchronized.
- Audit, logging and redaction considered.
- Accessibility and localization states covered for UI.
- No unrelated diff and no hidden TODO replacing required work.
- A human reviewer can reproduce verification from the handoff.
- Files, schemas, routes, components, migrations, mocks or stubs merely existing is never completion; a non-functional stub is a gap and belongs in `GAPS.md`.

## 7. Review agents

Use review as separate bounded passes after implementation:

1. **Correctness reviewer:** checks spec acceptance and state invariants.
2. **Security/isolation reviewer:** attempts cross-tenant/owner, credential and upload abuse.
3. **Test reviewer:** finds missing negative, concurrency and idempotency cases.
4. **UX/accessibility reviewer:** reviews relevant UI only.

Reviewers propose findings with file evidence and severity; they do not redesign unrelated code. Critical and high findings block merge.

## 8. Database-change rules

- One owner per migration sequence or aggregate during active work.
- Prefer additive nullable columns and tables, backfill, enforce, then later cleanup (expand, migrate, contract).
- Index tenant/owner foreign keys and primary query paths.
- Use database constraints for key invariants where practical.
- Never expose sequential IDs because internal keys exist.
- Test migrations on a realistic anonymized dataset before production.

## 9. Contract-change rules

Contract-first for shared work across components. The owning agent publishes shared type definitions plus fixtures early; consuming agents use the generated artifacts. Do not hand-write duplicate request or response types.

## 10. Context and handoff discipline

Keep a short task log or merge description with decisions and commands. New agents inspect the merged repository and the task handoff rather than trusting stale prose. If code contradicts specs, stop and escalate; do not silently choose one. Before ending a session, leave `PLAN.md`, `GAPS.md` and `TRACEABILITY.md` truthful about what actually runs and passes.

## 11. Example prompt for an implementation agent

```text
You are implementing TASK PRP-01: Owners and properties.

Read AGENTS.md, then only: specs/README.md, specs/14-decision-register.md,
specs/03-domain-model.md §2–§4, specs/07-users-authorization.md §2,
specs/10-security-privacy-retention.md §1, specs/12-testing-acceptance.md §3,
and the DECISIONS.md entries D-009, D-012, D-016, D-026, D-027.

Dependencies merged: FND-01..03, ACC-01..04.

Deliverable: admins and operations staff can create, edit and archive owners
and properties; a property's owner is recorded as dated ownership periods,
and a period with no owner means the account owns it.

Allowed scope: app/Models (Owner, Property, OwnershipPeriod), their
migrations, app/Actions/Properties, app/Http/Controllers/Staff,
resources/js/Pages/Staff/{Owners,Properties}, lang/, tests.

Acceptance:
- an owner change from a date keeps earlier periods unchanged;
- operations sees an owner's name and phone only, never the IBAN or email;
- archiving revokes the owner's login and keeps their history;
- guest-facing text fields exist in Greek and English;
- tenant and owner isolation cases added for every new model and route;
- make test, make lint, make typecheck pass.

Non-goals: property terms (PRP-02), cleaners (PRP-03), reservations,
any import from files.

Report: behaviour changed, commands run, migration and rollback notes,
privacy considerations, follow-ups.
```

## 12. Product-owner checkpoints

Require explicit Product Owner review after Phase 2 (onboarding, the first user-visible composition), Phase 3 (running a month, the first end-to-end journey), Phase 4 (closing a month, the core operational loop) and Phase 6 (before launch). These checkpoints validate product behavior without reopening locked architecture absent a real contradiction. Open cards in `QUESTIONS.md` whose `Blocks:` names the next phase are resolved at the checkpoint that precedes it.
