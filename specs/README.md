# STR Host — MVP Specifications

Version: 0.1-draft  
Status: Draft, not yet an implementation baseline  
Audience: Product owner, architects, developers, QA, DevOps and GenAI SWE agents

## Product statement

> STR Host is a multi-tenant back-office for short-term rentals in Greece that puts every property, reservation, turnover and euro of a management company or individual host in one place and produces each owner's monthly statement and payout without a spreadsheet; it is not a channel manager, a booking engine, accounting software or a guest messaging tool. [input]

The customer is the account: a management company running 5–60 properties for their owners, or an individual host running 1–5 of their own, under one model. Staff enter reservations with their money lines, the product schedules a turnover at every check-out, and each month it computes, per owner, what the owner is owed, to the cent. Owners, guests and cleaners are outside users with deliberately narrow views. The property that must hold above all others: no account ever sees another account's data, and no owner ever sees another owner's.

## Technology baseline

- Backend: Laravel 13 on PHP 8.3, with Laravel Fortify for authentication. [input]
- Database: PostgreSQL 16; tests run on real PostgreSQL with Pest. [input]
- Frontend: Inertia with Vue 3 in TypeScript, Tailwind 4 and PrimeVue 4. [input]
- Tenancy: `company_id` on every tenant table with a global scope. [input]
- Local environment: Docker Compose for the database; development runs on localhost. [input, Q-035]
- Interface languages: Greek and English. [input]
- Primary keys: UUIDv7. [D-009]
- Quality tooling: Larastan, Pint, vue-tsc, ESLint and Prettier. [D-006]
- Statement PDFs: dompdf. [D-007]
- Guest-page map: MapLibre GL JS over a self-hosted PMTiles file of Greece. [Q-049]
- Production hosting: an EU-based VPS provider in an EU region. [Q-035]
- Transactional email: an EU-based provider in production, a mail-trap account in development. [Q-036]

## Specification map

| File | Purpose |
| --- | --- |
| `01-product-scope-actors.md` | Product, account kinds, actors, MVP / Future / Out of Scope, sign-up |
| `02-architecture.md` | Repository layout, stack, tenancy mechanism, components, third parties |
| `03-domain-model.md` | Entities, relationships, identifiers, ownership history, archived states |
| `04-reservations-calendar.md` | Reservation lifecycle, overlap, owner stays, money lines entry, calendar and timeline |
| `05-turnovers-cleaners.md` | Turnovers, cleaners, cleaner pay summary |
| `06-money-statements.md` | Calculation chain, fee models, VAT, rounding, climate fee, month rules, adjustments, statement lifecycle |
| `07-users-authorization.md` | Logins, roles, permission matrix, second factor, sign-up approval |
| `08-outside-views.md` | Owner portal, guest page, cleaner link |
| `09-ux-journeys-emails.md` | Navigation, dashboard, critical journeys, branding, languages, accessibility, devices, emails |
| `10-security-privacy-retention.md` | Isolation, signed links, logging, audit, retention, account exit, data requests, terms |
| `11-infrastructure-operations.md` | Environments, hosting, backups, operator commands, error logging |
| `12-testing-acceptance.md` | Test gates, isolation and money golden tests, MVP definition of done |
| `13-traceability.md` | Product-intent scope matrix |
| `14-decision-register.md` | Locked owner decisions |
| `15-implementation-plan.md` | Phases and work packages |
| `16-agent-playbook.md` | How implementation agents work from this pack |

## Requirement language

`MUST`, `SHOULD` and `MAY` are normative. Unless explicitly labeled Future, every `MUST` requirement is part of MVP acceptance. Every `MUST` is testable: the testing specification or the work package that delivers it names the check that verifies it.

Sections are numbered and never renumbered. New content is appended as a new section or a new bullet; other documents cite `specs/NN-name.md §M` and those citations must keep resolving. `make check-docs` verifies every citation.

## Provenance

Every normative statement ends with a provenance tag:

| Tag | Meaning |
| --- | --- |
| `[input]` | stated by the owner in the raw requirements (`docs/inputs/`) |
| `[Q-NNN]` | decided by the owner by answering question card Q-NNN in `QUESTIONS.md`; `[Q-NNN, recommendation accepted]` when the owner accepted the proposed option |
| `[D-NNN]` | implementation default recorded in `DECISIONS.md` with alternatives; touches no data, security, scope, external or UX decision |
| `[inferred]` | inference not yet ratified; none remain at an implementation baseline |

`14-decision-register.md` contains only `[input]` and `[Q-NNN]` statements. `make check-docs` enforces it.

## Scope labels

- **MVP:** required for the first production release.
- **Future:** anticipated in architecture, but not implemented in MVP.
- **Out of Scope:** intentionally excluded; implementation agents must not add it.

## Conflict resolution

1. `14-decision-register.md` and the product statement override inferred behavior.
2. Security and tenant isolation requirements override convenience.
3. A feature not described as MVP is not silently added.
4. Ambiguities that materially affect data, security or scope become an Architecture Decision Record before implementation.
