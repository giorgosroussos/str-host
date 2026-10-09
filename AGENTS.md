# AGENTS.md — STR Host

This file is the entry point for every human or GenAI agent working in this repository. Read it fully before touching anything.

## Product

STR Host is a multi-tenant back-office for short-term rentals in Greece (`specs/README.md` §Product statement). Its customer is the account: a management company running 5–60 properties for their owners, or an individual host running 1–5 of their own, under one model (`01` §2). Staff enter owners, properties and commercial terms, then reservations with their money lines; every check-out schedules a turnover for a cleaner; each month the product computes, per owner, a statement and payout to the cent (`04`, `05`, `06`). Owners, guests and cleaners are outside users with deliberately narrow views: a read-only owner portal, a signed guest link per reservation and a signed link per cleaner (`01` §3, `08`). It is not a channel manager, a booking engine, accounting software or a guest messaging tool (`01` §1).

The MVP succeeds when a company can onboard its owners and properties, enter a month of reservations, run that month's turnovers and send each owner a finalised statement whose payout matches a hand calculation to the cent, while owners see only their own data and every guest gets a link that shows their stay and nothing else (`01` §8, `12` §7).

## Authority and reading order

`specs/` is the authoritative product and engineering contract; its version and status are on `specs/README.md`. Requirement language is normative: every `MUST` not labelled Future is MVP acceptance (`specs/README.md` §Requirement language), and every normative statement carries a provenance tag (`specs/README.md` §Provenance). Conflict resolution, in order (`specs/README.md` §Conflict resolution):

1. `specs/14-decision-register.md` and the product statement override inferred behaviour.
2. Security and tenant isolation requirements override convenience.
3. A feature not described as MVP is not silently added.
4. Ambiguities that materially affect data, security or scope become an ADR before implementation.

**Amendment regime (D-002).** Agents MAY amend non-locked spec text when implementation genuinely requires it, but never silently: the same change must carry a dated `DECISIONS.md` entry of type `spec-amendment` (what changed, why, alternatives, affected spec sections), and the amended statement keeps or gains a provenance tag. Sections are never renumbered. The following are **excluded from delegation** and require an ADR entry in `DECISIONS.md` marked `Owner approval: pending` plus explicit owner sign-off before any code: every bullet in `specs/14-decision-register.md`, and every red line in the next section. If specs conflict with each other, resolve via a recorded decision when the resolution is clear; otherwise record it in `QUESTIONS.md`. Never choose silently. If code contradicts specs, stop and escalate (`16` §10).

**Non-authoritative inputs (D-003).** None were received. Any mockup, competitor reference or prior draft added later gets an authority entry in `docs/inputs/README.md` and a `DECISIONS.md` entry before use.

**Session reading order:**

1. `AGENTS.md`, then `PLAN.md`.
2. `QUESTIONS.md` (Blocking and Open), `GAPS.md`, `TRACEABILITY.md`, and in `DECISIONS.md` the index plus the entries the active `PLAN.md` item cites. Read the whole of `DECISIONS.md` only when working on cross-cutting architecture.
3. `specs/README.md` and `specs/14-decision-register.md`, then the spec files cited by the active `PLAN.md` item. Read all specs before changing cross-cutting architecture, tenant isolation, authorization, the contract root or shared migrations.
4. `docs/inputs/README.md` when a task cites a raw requirement or a non-authoritative input.

## Non-negotiable constraints

- **Tenant isolation.** No account ever sees another account's data on any surface; `company_id` and the tenant context are derived on the server, never taken from the client (`02` §3, `10` §1).
- **Owner isolation.** An owner sees only the properties and dates of their own ownership periods, tested as strictly as tenant isolation; one login is never both staff and owner (`07` §1, `07` §3, `10` §1).
- **Outside views leak nothing.** The guest page and cleaner link show no amount, no owner, no other reservation and no guest data beyond the first name; the owner portal shows amounts only in finalised statements; an inactive link returns one generic page (`08` §1–§4).
- **Role boundaries.** Two fixed staff roles; operations never sees amounts, terms, expenses, statements, the dashboard, the cleaner pay summary, IBANs or owner emails; admins use a second factor (`07` §2, `07` §4).
- **No cross-account role.** There is no web role that sees more than one account; operator work is Artisan commands on the server (`07` §6, `11` §4).
- **Finalised statements are frozen.** A finalised statement's numbers never change; a later edit becomes a computed adjustment on the owner's next open month, and a statement never returns to draft (`06` §8–§9).
- **Money is integers in one place.** Cents and basis points only, no float or decimal on a money path; the calculation lives only in `app/Money`, rounded half up per line (`02` §1, `06` §1).
- **Identifiers and secrets.** UUID keys, nothing guessable in a URL; link tokens stored only as hashes; logs never hold IBANs, tokens, passwords or guest contact data (`03` §1, `10` §2–§3).
- **Third parties.** In production only the transactional email provider receives data; no runtime CDN, no error tracker, the map is served from the product's own host (`02` §5, `11` §3).
- **Scope.** Never build channel sync or pricing, bookings, invoicing or myDATA, guest or cleaner messaging, online payments, account billing, file import, blocked dates or any phase 2 item (`01` §1, `01` §6–§7).
- **Personal data has an end.** Guest data is anonymised and archived people's contact data erased on the schedules of `10` §5; backups live 30 days (`10` §5, `11` §5).
- **Testing honesty.** Tests run on real PostgreSQL, never SQLite; the isolation suite always passes and a failing isolation test blocks every merge; never weaken a test to pass (`12` §1, `12` §3, `16` §3).

## Architecture and stack

The backend is Laravel 13 on PHP 8.3 with Fortify; the database is PostgreSQL 16; the frontend is Inertia with Vue 3 in TypeScript, Tailwind 4 and PrimeVue 4; tests are Pest on real PostgreSQL (`02` §2). Tenancy is `company_id` on every tenant table with a global scope (`02` §3). The UI is in Greek and English (`09` §6). Four entry surfaces share the application: the staff app and the owner portal on Fortify sessions, the guest page and the cleaner link on link tokens (`02` §4).

Target repository layout (`02` §1):

```text
app/Actions/<Area>        one class per business operation
app/Money                 the pure money calculation (no database)
app/Models                Eloquent models with the tenant scope
app/Http/Controllers/{Staff,Owner,Guest,Cleaner}
resources/js/Pages/{Staff,Owner,Guest,Cleaner}
lang/el, lang/en          interface strings
database/migrations
tests/Unit, tests/Feature, tests/Isolation
docker-compose.yml, Makefile
```

Development runs on localhost with Docker Compose for PostgreSQL and a mail-trap account for email (`11` §1). Production is one VPS of an EU-based provider running Docker Compose: application, queue worker, scheduler and PostgreSQL behind a TLS proxy (`11` §2). Emails and PDFs run on the database queue, retention jobs on the scheduler (`02` §6). Receipts live on a private volume of the host; backups are nightly, kept 30 days with the same provider (`11` §5). Tooling the specs leave open is chosen in `DECISIONS.md`.

## Commands

Root command contract, implemented by the root `Makefile` (FND-01, D-001) with helpers in `scripts/`. Every target below exists and is real since FND-01; a target added later for an undelivered work package must fail with a message naming that package instead of passing, so a missing gate and a passing gate never look alike. `make check-docs` asserts that this list and the `Makefile` agree. `make migrate`, `make test`, `make test-browser`, `make dev` and `make smoke` need `make infra-up` first (PostgreSQL 16 and the Mailpit mail trap); Node must match `.nvmrc`.

```bash
make setup          # install dependencies from lockfiles, copy env examples
make infra-up       # start local infrastructure and wait for health
make infra-status
make infra-down
make migrate        # apply database migrations locally
make dev            # run every application process for local development
make test           # all automated tests against the real database engine
make test-browser   # browser tests of the critical journeys, with accessibility checks
make lint
make format         # apply formatting
make format-check   # verify formatting without changing files
make typecheck
make build          # production builds
make verify         # lint + format-check + typecheck + test + test-browser + build + check-docs
make smoke          # health of the running system through its public entry points
make audit          # dependency advisories
make scan-secrets   # secret scan of everything Git tracks
make check-docs     # mechanical consistency of the documentation layer (scripts/check-docs.py)
make check-locks    # lock manifest check of the staged change (scripts/lock-guard.py)
make verify-chain   # recompute every hash and link in .log/events.jsonl
make rebuild-decisions  # render DECISIONS.md from the event log
make rebuild-questions  # render QUESTIONS.md from the event log
make install-hooks  # point git at .githooks/ (once per clone)
make unlock         # ceremonial unlock of one hard-locked path: PATH=<path> REASON="why"
make clean-start    # fresh isolated environment: setup, infra-up, migrate, verify, smoke, teardown
```

`check-docs`, `check-locks`, `verify-chain`, the two `rebuild-*` targets, `install-hooks` and `unlock` are real from the first commit; the rest are real since FND-01.

CI (FND-02) runs on every merge request and every push to the default branch. Each job runs exactly one of the targets above, so a gate cannot pass in CI and fail locally; `README.md` maps job to command. Gates the testing specification requires that nothing implements yet run as failing-forward tripwires that pass only while the gate is provably absent (`15` §3).

## Working method and definition of done

Work in the smallest useful vertical slice, following the task packet of `16` §2 and §4: one task ID and outcome, exact spec sections, dependencies merged, allowed file surface and shared-file owner, executable acceptance criteria, explicit non-goals. Before coding, inspect current code and tests, restate assumptions and flag conflicts with locked decisions (`16` §3). Implement, add tests in the same change, run targeted then broader suites, regenerate contract artifacts when contracts change, and report changed behaviour, migration and rollback implications and remaining risks.

Definition of Ready and Done are `16` §5–6. Review runs as separate bounded passes after implementation, when the table in the next section selects it: correctness, security and isolation, tests, UX and accessibility (`16` §7). Critical and high findings block merge. Parallel work follows the lanes in `15` §10; never parallelize migrations for the same aggregate or concurrent edits to central policies or the contract root without explicit ownership. Product Owner checkpoints are `16` §12. The release gate is `12` §7 together with the last phase's exit criteria in `15` §9.

## Prompt selection

`SESSION_BOOTSTRAP_PROMPT_SAMPLE.md` holds three session prompts, and this table decides which of them a task needs. The mechanical gates are the floor for every task, not a prompt: the package's executable acceptance criteria and `make check-docs` run whatever the table says, and the review prompt exists only for what those gates cannot check. Each work package in `specs/15-implementation-plan.md` states `Surfaces`, `Touches red line` and `Contract change`; the first two are derived from the sections the package cites and `make check-docs` verifies them, the third is the plan author's judgement. `blocked-by` is not stored anywhere: it is the set of open cards in `QUESTIONS.md` whose `Blocks:` names the package, read when the task starts, so resolving a card needs no change to the plan. `python3 scripts/check-docs.py --task <PACKAGE>` prints all four.

| Prompt | Run when |
| --- | --- |
| 1 — Implement | Always. |
| 3 — Resolve questions | Before the package, iff an open card in QUESTIONS.md has `Blocks:` = this package. |
| 2 — Review | After implementation, iff `Surfaces` includes `security` or `data`, or `Touches red line` is `yes`, or `Contract change` is `yes`. Otherwise skip: the executable acceptance criteria and `make check-docs` already cover correctness, and there is no security, isolation or contract dimension for a review to add. |

## Living documents

All at repository root. When scope changes, update the smallest relevant document. Durable rationale goes to `DECISIONS.md`, incompleteness to `GAPS.md`, unresolved choices to `QUESTIONS.md`; `PLAN.md` never becomes an archive. `make check-docs` fails on the inconsistencies that can be detected mechanically; the rules below are the ones it cannot.

- `PLAN.md`: exactly `Now` and `Next`. Keep 1–3 narrow `Now` items and only the next few slices, each with spec refs and executable acceptance. Not history, design or backlog; remove completed items, Git is the archive. If code and plan disagree, investigate and correct the plan.
- `DECISIONS.md`: a generated projection of the `decisions` stream of `.log/events.jsonl`, which is the source of truth. Never edit it and never hand-write an entry: append an event with `scripts/log-append.py` (`decision-added`, `decision-superseded`, `adr-approval-changed`) and run `make rebuild-decisions`. A record carries decision, why, alternatives, affected specs and type (`implementation`, `spec-amendment`, `adr`); an `adr` carries its owner-approval state, changed by its own event. Retire a record by superseding it, which renders as `Status: superseded by D-MMM`; nothing is ever rewritten or deleted, because the alternatives a decision weighed are the only record of why it reads as it does. `make check-docs` verifies the chain (`chain-intact`) and that this file equals a fresh rebuild (`projection-fresh`), so an edit here fails the gate instead of becoming the record. `.log/README.md` states what the chain does and does not guarantee.
- `GAPS.md`: deliberate incompleteness, missing infrastructure, deferred scope, its consequence and the evidence needed to close it. Never mask a gap with a stub. A closed gap's row is removed and its ID retired.
- `QUESTIONS.md`: a generated projection of the `questions` stream of `.log/events.jsonl`, in the decision-card format the file documents. Never edit it: open, answer, defer, reactivate, resolve and supersede cards by appending events (`scripts/log-append.py`) and running `make rebuild-questions`, so a card moves between Blocking, Open and Resolved because an event says so. Resolve a card by writing its answer into the specs with a `[Q-NNN]` tag, or into a decision after the baseline, and appending `card-resolved`; never by deleting it. An owner who changes their mind gets a new card and a `card-superseded` event: the old card stays Resolved and readable, and the citation moves to its successor, which `check-docs` expects. Before a phase starts, resolve the Open cards whose `Blocks:` names it.
- `TRACEABILITY.md`: work packages from `specs/15-implementation-plan.md` and the critical journeys from `12` §6 mapped to status and concrete evidence (test names, commands). Status is set only from evidence that ran and passed, never from plans, file presence or stubs. The product-intent scope matrix remains the traceability file in `specs/`, owner-maintained.
- `.doc-locks`: which files are hard-locked, append-only or free, one `tier: glob` per line, last match wins. `scripts/lock-guard.py` enforces it over the diff from `.githooks/pre-commit` and from the pre-receive hook on the remote; `.githooks/README.md` says why both exist. Run `make install-hooks` once per clone. A hard-locked file changes only through `make unlock PATH=<path> REASON="..."`, which records the reason in `UNLOCKS.md` and authorizes exactly that path for exactly one commit. Tiers only ever go up: promoting a file is a line appended to `.doc-locks` through the same ceremony (the manifest is hard-locked), and the guard refuses any change that would lower a path's tier.
- `AGENTS.md` itself stays under 20 KB; when it does not fit, content moves to `specs/16-agent-playbook.md` or `docs/`, never into `CLAUDE.md`.
