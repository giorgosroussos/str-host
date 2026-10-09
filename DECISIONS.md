# DECISIONS

Generated file. The source of truth is the append-only, hash-chained event log at `.log/events.jsonl`; this file is its projection. Do not edit it by hand: an edit here does not change what was decided, and `make check-docs` fails until the file equals a fresh rebuild (`projection-fresh`). To record a decision, append an event with `scripts/log-append.py` and run `make rebuild-decisions`.

Nothing in the log is ever rewritten or deleted. A record is retired by appending a `decision-superseded` event, which renders as a `Status: superseded by D-MMM` line on the superseded entry; its text stays readable, because the alternatives it weighed are the only record of why the decision reads as it does. Types: `implementation` (latitude the specs allow), `spec-amendment` (a non-locked spec text change made in the same commit), `adr` (a change to a locked decision or red line; carries `Owner approval: pending | granted YYYY-MM-DD | rejected`). An implementation session reads the index below and the entries its `PLAN.md` item cites, not the whole file. `make check-docs` verifies the IDs, the fields, the index, the chain and this projection.

Entry format:

```
## D-NNN (YYYY-MM-DD) — Title
Type: …
Decision: …
Why: …
Alternatives: …
Affected specs: …
```

## Index

- D-001 — Repository documentation regime — implementation
- D-002 — Spec amendment regime — implementation
- D-003 — Authority of non-authoritative inputs — implementation
- D-004 — Division of labour between spec documents and living documents — implementation
- D-005 — Agent execution contract — implementation
- D-006 — Quality tooling — implementation
- D-007 — Statement PDF rendering — implementation
- D-008 — Map rendering library — implementation
- D-009 — UUID version — implementation
- D-010 — Stay interval and overlap — implementation
- D-011 — Business timezone — implementation — superseded by D-040
- D-012 — Money representation — implementation
- D-013 — Signed link tokens — implementation
- D-014 — Turnover cost source — implementation
- D-015 — Where owner-paid cleaning appears on a statement — implementation
- D-016 — Guest-page contact number — implementation
- D-017 — What logs never contain — implementation
- D-018 — No runtime CDN — implementation
- D-019 — Backups — implementation
- D-020 — Turnover follows its reservation — implementation
- D-021 — Receipt file storage — implementation
- D-022 — Dashboard figures — implementation
- D-023 — Operator tooling surface — implementation
- D-024 — Internationalisation mechanics — implementation
- D-025 — Background jobs — implementation
- D-026 — Repository layout — implementation
- D-027 — Modelling a self-owned property — implementation
- D-028 — Finalisation needs complete money lines — implementation
- D-029 — Turnover assignment and completion — implementation
- D-030 — Cleaner link window — implementation
- D-031 — Drafts are computed, not stored — implementation
- D-032 — Inactive link page — implementation
- D-033 — Login hardening — implementation
- D-034 — Production runtime shape — implementation
- D-035 — Account-approved email — implementation
- D-036 — Test layers — implementation
- D-037 — Packages that change a contract — implementation
- D-038 — Record-keeping details from the input audit — implementation
- D-039 — Authorization policies and their tests — implementation
- D-040 — Business dates in the property's timezone — implementation
- D-041 — A test proves the database engine — implementation
- D-042 — Test runner plugins and the test database — implementation
- D-043 — Secret scan and dependency audit — implementation
- D-044 — Local runtime, mail trap and the clean-start proof — implementation
- D-045 — Health probe and closed framework endpoints — implementation
- D-046 — Framework infrastructure tables keep their own keys — adr

## D-001 (2026-10-09) — Repository documentation regime
Type: implementation
Decision: `AGENTS.md` at repository root is the single entry point for agents; `CLAUDE.md` and any per-directory agent file are thin pointers to it with tool- or directory-specific notes only, never a second source of rules. Living documents (`PLAN.md`, `DECISIONS.md`, `GAPS.md`, `QUESTIONS.md`, `TRACEABILITY.md`) live at the root. Raw requirements live under `docs/inputs/` with their authority declared in `docs/inputs/README.md`. Agent decisions are recorded as events in the append-only, hash-chained log `.log/events.jsonl`, and `DECISIONS.md` is its projection: rebuilt by `scripts/rebuild-decisions.py`, never authored, and compared against the log on every run of the gate. The root `Makefile` is the command contract from the first commit: `make check-docs` (`scripts/check-docs.py`) is real and enforces the mechanical consistency of these documents; every other target fails with a message naming its work package until that package delivers it. `docs/` is otherwise reserved for runbooks and long-form ADRs once code exists.
Why: a fresh agent session must find one file and be unable to miss the current state. A rule that is checked mechanically does not need to be remembered, so every rule that can be a `check-docs` assertion is one and is not repeated in prose. A placeholder target that fails loudly keeps "the contract exists" and "the contract works" distinguishable. A record whose integrity is checked mechanically does not depend on anyone remembering not to edit it, which is why the decision stream is a log with a projection rather than a file that everyone promises to append to.
Alternatives: living documents under `docs/` (rejected: discoverability); a single combined status document (rejected: mixes history with current state); no `Makefile` until FND-01 (rejected: `check-docs` must run from day one and the contract's target list must be visible to the first implementation session); silently passing placeholder targets (rejected: indistinguishable from a working contract). `DECISIONS.md` itself as the source of truth (rejected: a changed body under an unchanged ID is invisible to any check that reads only the current state).
Affected specs: none.

## D-002 (2026-10-09) — Spec amendment regime
Type: implementation
Decision: agents may amend non-locked text in `specs/` when implementation requires it, provided the same change adds a dated `spec-amendment` entry here and the amended statement carries a provenance tag. Spec sections are never renumbered; new content is appended. Every bullet in `specs/14-decision-register.md` and every red line listed in `AGENTS.md` is excluded from delegation and requires an `adr` entry with owner approval before code changes.
Why: keeps the spec pack accurate as implementation reveals defects, without weakening the change control that `14` §6 requires for locked decisions. Stable numbering keeps every citation in the living documents resolving, which `make check-docs` verifies.
Alternatives: no agent spec edits at all (rejected: specs drift from code); full delegation including locked decisions (rejected: contradicts the register's change control).
Affected specs: operationalizes `specs/README.md` §Conflict resolution and `14` §6; no text changed.

## D-003 (2026-10-09) — Authority of non-authoritative inputs
Type: implementation
Decision: No non-authoritative input was received. Any mockup, competitor reference or prior draft added later receives an authority row in docs/inputs/README.md and a superseding entry before an agent may use it.
Why: an input without a declared authority level becomes a requirements source by default, silently.
Alternatives: treat all inputs as authoritative (rejected: direction and requirements would blend).
Affected specs: none.

## D-004 (2026-10-09) — Division of labour between spec documents and living documents
Type: implementation
Decision: `specs/13-traceability.md` remains the owner-maintained product-intent scope matrix; root `TRACEABILITY.md` records implementation status and evidence per work package and critical journey, with status set only from evidence that ran and passed. `specs/14-decision-register.md` remains the locked register of owner decisions with their provenance; the event log records implementation decisions, spec amendments and ADR proposals as events, and root `DECISIONS.md` is the projection an agent reads. `specs/15-implementation-plan.md` remains the phase plan; root `PLAN.md` holds only the current slice and the next few. `QUESTIONS.md` holds the decision cards, open and resolved; a resolved card is cited by the spec statement it produced.
Why: avoids duplicating or silently editing spec documents while still giving agents a truthful, frequently updated status surface. Keeping the cards in one place with their answers preserves the alternatives the owner saw when deciding.
Alternatives: editing status into the spec files (rejected: churns the contract); no implementation traceability (rejected: the playbook's Definition of Done requires reproducible verification); deleting answered cards (rejected: the alternatives considered are the only record of why the locked decision reads as it does).
Affected specs: none.

## D-005 (2026-10-09) — Agent execution contract
Type: implementation
Decision: Every implementation agent works under the execution contract of `specs/16-agent-playbook.md` §3: inspect before editing, restate assumptions and flag conflicts with locked decisions, implement the smallest coherent slice, add or update tests in the same change, run targeted then broader suites, keep contract artifacts and docs in step, and report changed behaviour, migration and rollback implications and remaining risks; and never changes scope or a locked decision, introduces an excluded capability, trusts a client-supplied ownership identifier, weakens a test to pass CI, edits or reformats unrelated code, builds speculative abstractions, commits secrets or sample personal data, or runs a destructive migration without an approved plan. The contract binds the agent's method, not the product: it touches no data, security, scope, external or UX decision, which is why it is a recorded default and not a card.
Why: an agent without a stated method fills the gaps with habit, and the habits that cost most (widening scope, weakening a test, trusting the client) are the ones no spec statement names because they are not about the product. Stating the method once, in the playbook, with a provenance tag, keeps it out of `AGENTS.md` prose and lets `make check-docs` hold the playbook to the same rule as every other spec: no normative statement without a home.
Alternatives: no explicit contract (rejected: the method drifts per session); the contract as red lines in `AGENTS.md` (rejected: red lines are product constraints with spec citations, and the file has a size ceiling); tagging the contract `[input]` (rejected: the owner never said it; it is the pack's default and must read as one).
Affected specs: `16` §3 carries the tag; no text changed.

## D-006 (2026-10-09) — Quality tooling
Type: implementation
Decision: Backend: Pest (fixed by the constraints) with Larastan at level 6 and Laravel Pint for formatting. Frontend: vue-tsc for type checking, ESLint with the Vue and TypeScript configs, Prettier for formatting. Each runs through a `make` target.
Why: one checker per concern, all standard for the fixed stack, all runnable headless in CI.
Alternatives: PHPStan without the Laravel extension (rejected: false positives on facades and Eloquent); Psalm (rejected: weaker Laravel support); Biome instead of ESLint+Prettier (rejected: less mature Vue SFC support).
Affected specs: `02` and `12`.

## D-007 (2026-10-09) — Statement PDF rendering
Type: implementation
Decision: Statement PDFs are rendered server-side from a Blade view with dompdf (barryvdh/laravel-dompdf), using an embedded DejaVu Sans font for Greek glyphs.
Why: pure PHP, no headless browser in the container, and the statement is a simple tabular document.
Alternatives: Browsershot / headless Chromium (rejected: a browser in the production image for one document); Gotenberg as a sidecar service (rejected: another container to operate); client-side print-to-PDF (rejected: output differs per browser).
Affected specs: `06` and `08`.

## D-008 (2026-10-09) — Map rendering library
Type: implementation
Decision: The guest page renders the self-hosted PMTiles map (Q-049) with MapLibre GL JS and the pmtiles protocol plugin, using a Protomaps basemap style; both libraries are bundled, not loaded from a CDN.
Why: MapLibre reads PMTiles natively through the plugin and is open source with no API key.
Alternatives: Leaflet with protomaps-leaflet (rejected: raster-like rendering of vector tiles, weaker label handling for Greek); OpenLayers (rejected: larger bundle for one map).
Affected specs: `02` and `08`.

## D-009 (2026-10-09) — UUID version
Type: implementation
Decision: Primary keys are UUIDv7 generated by the application (Laravel `HasUuids`), stored as PostgreSQL `uuid`.
Why: the constraint fixes UUID keys; v7 is time-ordered and keeps B-tree indexes compact.
Alternatives: UUIDv4 (rejected: random insert order fragments indexes); database-generated `gen_random_uuid()` (rejected: v4 and the model has no key before insert).
Affected specs: `03`.

## D-010 (2026-10-09) — Stay interval and overlap
Type: implementation
Decision: A stay occupies the half-open date interval [check-in date, check-out date). Two reservations on the same property overlap when their intervals intersect; a check-out and a check-in on the same day do not overlap. Cancelled reservations are ignored by the check. Enforced by a PostgreSQL exclusion constraint on a `daterange` as well as by validation.
Why: the turnover pillar assumes a same-day check-out and check-in; the database constraint holds even if two requests race.
Alternatives: closed intervals (rejected: forbids same-day turnover); validation only (rejected: races).
Affected specs: `04`.

## D-011 (2026-10-09) — Business timezone
Status: superseded by D-040
Type: implementation
Decision: Every business date (check-in, check-out, turnover day, statement month, link expiry, retention deadline) is a calendar date in Europe/Athens. Timestamps are stored in UTC.
Why: all properties are in Greece; a UTC day would move late-evening events into the wrong day or month.
Alternatives: UTC dates (rejected: misattribution near midnight); a timezone per property (rejected: one market).
Affected specs: `04`, `06` and `10`.

## D-012 (2026-10-09) — Money representation
Type: implementation
Decision: Every amount is an integer number of euro cents in a PostgreSQL `bigint` column and a PHP `int`; percentages are stored as integer basis points (1% = 100). EUR is the only currency. No float or decimal type appears on any money path.
Why: the constraints forbid floats; one integer representation everywhere makes the rounding rule the only place a fraction exists.
Alternatives: `numeric(12,2)` with a decimal library (rejected: two representations in PHP and TypeScript); a money library with currency objects (rejected: one currency).
Affected specs: `03` and `06`.

## D-013 (2026-10-09) — Signed link tokens
Type: implementation
Decision: Guest and cleaner links carry a 256-bit random token; only its SHA-256 hash is stored. Revoking deletes the hash; reissuing creates a new token. Tokens never appear in logs.
Why: a stored hash cannot be replayed from a database leak, and each link can be revoked on its own.
Alternatives: Laravel signed URLs with an HMAC over the ID (rejected: cannot revoke one link without rotating the app key); storing the token in clear (rejected: a database read becomes access).
Affected specs: `08` and `10`.

## D-014 (2026-10-09) — Turnover cost source
Type: implementation
Decision: Each property has a default turnover cost; a new turnover takes it and staff may edit it per turnover.
Why: cleaning usually costs the same per property, and exceptions still need a per-turnover amount.
Alternatives: entered on every turnover (rejected: repetitive and error-prone); a per-cleaner rate (rejected: cost depends on the property).
Affected specs: `05`.

## D-015 (2026-10-09) — Where owner-paid cleaning appears on a statement
Type: implementation
Decision: An owner-paid turnover cost is deducted on the line of the reservation whose check-out created it, as in the calculation chain; it is not repeated in the expenses section. The payout is identical either way.
Why: the base plan's formula places it per reservation and its pillar list mentions it under expenses; both give the same payout, and one home avoids double counting.
Alternatives: list it under expenses (rejected: separates the cost from the stay it belongs to).
Affected specs: `06`.

## D-016 (2026-10-09) — Guest-page contact number
Type: implementation
Decision: A property may carry its own contact number; when it does not, the guest page shows the account's contact number.
Why: most companies use one number, some have a local contact per area.
Alternatives: account-only number (rejected: no local contact); property-only (rejected: repetitive).
Affected specs: `08`.

## D-017 (2026-10-09) — What logs never contain
Type: implementation
Decision: Application logs, exception reports and audit rendering never contain IBANs, signed-link tokens, passwords, second-factor secrets, or guest surnames, phones or emails; request logging redacts these fields by name.
Why: logs are kept and copied more freely than the database.
Alternatives: no redaction (rejected: leaks personal data into backups of logs).
Affected specs: `10`.

## D-018 (2026-10-09) — No runtime CDN
Type: implementation
Decision: Fonts, icons, scripts and styles are bundled by Vite and served by the application; no page loads anything from a third-party host at runtime.
Why: keeps guest and owner IPs from third parties, consistent with Q-037/Q-049 and Q-038.
Alternatives: Google Fonts and CDN libraries (rejected: third parties receive visitor IPs).
Affected specs: `02`.

## D-019 (2026-10-09) — Backups
Type: implementation
Decision: A nightly PostgreSQL dump and a copy of uploaded receipts go to storage of the hosting provider chosen in Q-035, in an EU region, kept 30 days; a restore is rehearsed before launch.
Why: keeps backups in the same jurisdiction and under the same provider terms as the data.
Alternatives: a different provider for off-site copies (rejected: adds a third party not chosen by the owner); no backups (rejected).
Affected specs: `11`.

## D-020 (2026-10-09) — Turnover follows its reservation
Type: implementation
Decision: Changing a reservation's check-out date or property moves its pending turnover; cancelling the reservation deletes a pending turnover. A turnover already done is never moved or deleted automatically; staff resolve it by hand.
Why: keeps the cleaning schedule in step with reservations without erasing work already recorded.
Alternatives: never sync (rejected: stale schedule); sync done turnovers too (rejected: erases a recorded cost).
Affected specs: `05`.

## D-021 (2026-10-09) — Receipt file storage
Type: implementation
Decision: Receipt files are stored on a private volume of the application host (Laravel local disk outside the public root) and served only through an authorised controller; accepted types are JPEG, PNG, HEIC converted to JPEG, and PDF, up to 10 MB each.
Why: no further third party; access always passes through authorisation.
Alternatives: object storage at another provider (rejected: a further third party); public URLs (rejected: guessable or shareable).
Affected specs: `03` and `10`.

## D-022 (2026-10-09) — Dashboard figures
Type: implementation
Decision: The admin dashboard shows per property per month: occupancy = nights of confirmed non-owner-stay reservations whose nights fall in the month ÷ nights in the month; and net rental income of the reservations counting in that month (check-out rule).
Why: occupancy is about nights sold; income follows the same month rule as statements so the two never disagree.
Alternatives: count owner stays in occupancy (rejected: overstates sold nights); income by night (rejected: disagrees with statements).
Affected specs: `09`.

## D-023 (2026-10-09) — Operator tooling surface
Type: implementation
Decision: Operator tasks (approve a pending account, maintain climate resilience fee rates, export, suspend or delete an account, refresh the map file, handle a data request) are Artisan commands run on the server; they are logged with the command, arguments and time.
Why: Q-012 excludes any cross-account web role; commands keep the operator off the web surface.
Alternatives: a web admin panel (rejected by Q-012); direct SQL (rejected: no validation, no log).
Affected specs: `11`.

## D-024 (2026-10-09) — Internationalisation mechanics
Type: implementation
Decision: Interface strings live in Laravel `lang/el` and `lang/en` JSON files shared with the frontend through laravel-vue-i18n; a missing key falls back to English and is reported by a test that compares the two files. Dates and amounts are formatted with `Intl` for the active locale.
Why: one source of strings for Blade (emails, PDF) and Vue.
Alternatives: separate vue-i18n message files (rejected: two sources); database-stored translations (rejected: no need to edit at runtime).
Affected specs: `09`.

## D-025 (2026-10-09) — Background jobs
Type: implementation
Decision: Scheduled work (anonymisation, account deletion deadlines, link expiry clean-up) runs from the Laravel scheduler; emails and PDF generation run on the database queue driver.
Why: no extra service; volumes are small.
Alternatives: Redis queues (rejected: another service); synchronous email (rejected: request latency and lost mail on provider errors).
Affected specs: `02` and `11`.

## D-026 (2026-10-09) — Repository layout
Type: implementation
Decision: Standard Laravel layout. Business operations live in single-purpose action classes under `app/Actions/<Area>`; the money calculation is a pure module under `app/Money` with no database or framework access; controllers are grouped per entry surface under `app/Http/Controllers/{Staff,Owner,Guest,Cleaner}` and Vue pages mirror them under `resources/js/Pages/{Staff,Owner,Guest,Cleaner}`. Tests: `tests/Unit` (including money), `tests/Feature`, and `tests/Isolation` for tenant and owner isolation.
Why: one place per concern an agent must find: the calculation, the surface a request enters through, and the isolation suite.
Alternatives: domain modules/packages per area (rejected: overhead for a small product); fat models (rejected: money logic scattered across models).
Affected specs: `02` §1.

## D-027 (2026-10-09) — Modelling a self-owned property
Type: implementation
Decision: A self-owned property is a property whose current ownership period names no owner; the account itself is the owner. Adding an owner later is a new ownership period under Q-004.
Why: keeps one property model and one ownership history for both account kinds, as the base plan's single model asks.
Alternatives: a synthetic owner record representing the account (rejected: an owner with no login and no statement is a special case everywhere); a separate self-owned property type (rejected: two models).
Affected specs: `03`.

## D-028 (2026-10-09) — Finalisation needs complete money lines
Type: implementation
Decision: A statement cannot be finalised while any reservation counting in it (confirmed, or cancelled with retained money, non-owner-stay) has no money lines entered; the draft lists those reservations.
Why: operations staff enter reservations without amounts, so a reservation without money lines is normal before review and must not be frozen as zero.
Alternatives: treat missing lines as zero (rejected: a silent wrong payout); warn only (rejected: a frozen statement cannot be corrected except by adjustment).
Affected specs: `06` §9.

## D-029 (2026-10-09) — Turnover assignment and completion
Type: implementation
Decision: A turnover is created unassigned and staff assign a cleaner; it may be reassigned while pending. The assigned cleaner marks it done through their link, and staff may also mark it done.
Why: the cleaner is often chosen after the reservation is entered, and a cleaner without a phone at hand must not block the record.
Alternatives: require a cleaner at creation (rejected: blocks reservation entry); only the cleaner may complete (rejected: records stall).
Affected specs: `05` §1.

## D-030 (2026-10-09) — Cleaner link window
Type: implementation
Decision: The cleaner link lists the cleaner's turnovers from today to 60 days ahead, plus pending ones from the previous 7 days, ordered by date.
Why: covers the planning horizon of a season week by week and lets a late completion still be recorded.
Alternatives: all future turnovers (rejected: long lists in high season); today only (rejected: no planning).
Affected specs: `08` §3.

## D-031 (2026-10-09) — Drafts are computed, not stored
Type: implementation
Decision: A draft statement is computed from current records each time it is opened; only finalisation stores lines and totals.
Why: a stored draft goes stale with every reservation edit, and only the finalised snapshot needs to be frozen.
Alternatives: store drafts and refresh on demand (rejected: two copies of the truth before review).
Affected specs: `06` §9.

## D-032 (2026-10-09) — Inactive link page
Type: implementation
Decision: An unknown, expired, revoked or cancelled guest or cleaner link returns one generic page, in both languages, saying the link is not active and to contact the host, with HTTP 404; the page is identical in every case.
Why: one response for every inactive case reveals nothing about whether a token existed, and still tells a real guest what to do.
Alternatives: distinct messages per case (rejected: confirms which tokens exist); a bare 404 (rejected: a guest is left without guidance).
Affected specs: `08` §4.

## D-033 (2026-10-09) — Login hardening
Type: implementation
Decision: Login, password reset, invitation acceptance and sign-up are rate limited per email and per IP (5 attempts per minute, Fortify's limiter); failed logins and reset requests return the same message whether or not the email exists.
Why: blocks password guessing and stops the forms from confirming which emails have logins.
Alternatives: no throttling (rejected); distinct 'unknown email' messages (rejected: account enumeration).
Affected specs: `10` §9.

## D-034 (2026-10-09) — Production runtime shape
Type: implementation
Decision: Production runs on one VPS with Docker Compose: the PHP application (nginx + PHP-FPM), a queue worker, the scheduler and PostgreSQL 16, behind Caddy terminating TLS with automatically renewed Let's Encrypt certificates. Deployment builds an image, runs migrations, then swaps containers.
Why: the smallest setup that runs every component the specs need on the single host chosen in Q-035, using the same Compose tooling as development.
Alternatives: managed PostgreSQL (rejected: a further provider and cost); Kubernetes (rejected: operational weight for one host); bare-metal PHP install (rejected: drifts from development).
Affected specs: `11`.

## D-035 (2026-10-09) — Account-approved email
Type: implementation
Decision: When the operator approves a pending account, its first admin receives an email saying the account is active, with a login link.
Why: without it the applicant does not know when to come back; it reuses the transactional email of Q-036.
Alternatives: no email (rejected: applicants are left waiting with no signal).
Affected specs: `09` §7.

## D-036 (2026-10-09) — Test layers
Type: implementation
Decision: Three Pest layers: unit tests (including every money rule, no database), feature tests over HTTP against PostgreSQL (including the isolation suite), and browser tests with the Pest browser plugin for the critical journeys, each running an axe accessibility check of every page it visits.
Why: one runner for all layers; browser tests prove the journeys and the accessibility target on real pages.
Alternatives: Dusk (rejected: slower, no built-in accessibility check); a separate Playwright project in TypeScript (rejected: second runner and fixtures).
Affected specs: `12` §1.

## D-037 (2026-10-09) — Packages that change a contract
Type: implementation
Decision: `Contract change: yes` for the packages that create or alter the database schema or the shape of data shared across surfaces: FND-01 (scaffold, first migrations), ACC-01, ACC-02, ACC-03, ACC-04, PRP-01, PRP-02, PRP-03, RES-01, RES-02, RES-04, MON-02, MON-03, MON-04. Every other package is `no`: it reads existing models or adds pages, jobs, commands or pure code.
Why: the product has no public API, so its contracts are the schema and the Inertia page props; a package that migrates tables is the one whose change ripples into others.
Alternatives: mark every package `yes` (rejected: the flag would select nothing); mark only FND-01 (rejected: hides the schema work of every domain phase); count MON-01 as a contract (rejected: a pure module with no schema).
Affected specs: `15` §3–§9.

## D-038 (2026-10-09) — Record-keeping details from the input audit
Type: implementation
Decision: The server derives the current account from the login for staff and owners and from the link for guests and cleaners. Recording a payout stores the date it was paid.
Why: the input audit found these stated as owner input; each has one plausible form once the input's rule is accepted (tenant context derived on the server; a payout recorded as paid), so they are recorded here instead.
Alternatives: leave them tagged as input (rejected: the inputs do not say them); store only a paid flag (rejected: a payout without a date cannot be reconciled with a bank statement).
Affected specs: `02` §3, `06` §9.

## D-039 (2026-10-09) — Authorization policies and their tests
Type: implementation
Decision: Every action is authorised by a Laravel policy that encodes the permission matrix of `07` §2, and the isolation suite tests the allowed and the refused case of each cell. A failing isolation test fails `make test`, which blocks merging.
Why: the base plan requires isolation tests on every model and action, always green; one policy per matrix makes each cell testable in one place.
Alternatives: inline checks in controllers (rejected: untestable as a matrix); test only refused cases (rejected: a policy that refuses everything would pass).
Affected specs: `07` §2, `12` §3.

## D-040 (2026-10-09) — Business dates in the property's timezone
Type: implementation
Decision: Each property carries an IANA timezone, chosen by staff when the property is set up and defaulting to Europe/Athens. Every date tied to a property (check-in, check-out, turnover day, the statement month a reservation counts in, the cleaner link's 'today') is a calendar date in that property's timezone. Dates not tied to a property (retention and deletion deadlines, the fixed monthly fee's last day of the month) use Europe/Athens. Timestamps are stored in UTC.
Why: the owner answered Q-082 that the property's timezone decides the statement month; applying the same rule to every property-bound date keeps a stay, its turnover and its month in one calendar.
Alternatives: property timezone for the statement month only (rejected: a turnover could fall on a different day than its check-out); keep Europe/Athens everywhere (rejected by Q-082).
Affected specs: `03` §2, `06` §4.

## D-041 (2026-10-09) — A test proves the database engine
Type: implementation
Decision: The suite includes one test that asserts the connection driver is `pgsql` and the server version is 16, so a run against SQLite or another engine fails instead of passing.
Why: the constraint 'Pest tests on real PostgreSQL' is only enforced if a misconfigured run cannot pass silently.
Alternatives: rely on the CI service definition (rejected: a local run on SQLite would still pass).
Affected specs: `12` §1.

## D-042 (2026-10-09) — Test runner plugins and the test database
Type: implementation
Decision: Pest 4 with pest-plugin-laravel 4 and pest-plugin-browser 4 (Playwright Chromium headless shell, installed by make setup). Suites tests/Unit, tests/Feature, tests/Isolation run in make test; tests/Browser runs in make test-browser after a production build, each visited page checked with assertNoAccessibilityIssues at every axe impact level. Tests run on the database str_host_test of the Compose PostgreSQL 16 server, forced in phpunit.xml together with DB_CONNECTION=pgsql; Feature and Isolation use RefreshDatabase and withoutVite so make test needs no build.
Why: Pest 5 requires PHP 8.4 and the stack fixes 8.3 (`02` §2); one server with a separate database keeps tests off development data with nothing extra to start; forcing the connection makes a SQLite run impossible (`12` §1, D-041).
Alternatives: Pest 5 (rejected: PHP 8.4); a second Compose service for tests (rejected: extra process for no isolation gain); Testcontainers (rejected: another dependency); axe at serious-and-above only (rejected: weaker than the WCAG target needs).
Affected specs: `12` §1.

## D-043 (2026-10-09) — Secret scan and dependency audit
Type: implementation
Decision: make scan-secrets runs gitleaks v8.30.1 from its container image pinned by digest over a copy of the working-tree version of every path git ls-files lists. make audit runs composer audit --locked and npm audit at the default level, so any advisory fails. ESLint is configured with typescript-eslint, eslint-plugin-vue and eslint-config-prettier rather than @vue/eslint-config-typescript.
Why: Docker is already a prerequisite, the digest makes the scanner reproducible and the scope is the contract's 'everything Git tracks'; neither tool sends data to a third party (`02` §5); @vue/eslint-config-typescript pulls braces, which has an unfixed high advisory and would fail the audit gate.
Alternatives: trufflehog (rejected: heavier, same coverage); a downloaded gitleaks binary (rejected: install and checksum handling); gitleaks git history scan (rejected: fails inside git worktrees, and history is fixed by then); audit only high and critical (rejected: weaker gate); Snyk or OSV services (rejected: third party).
Affected specs: `12` §2.

## D-044 (2026-10-09) — Local runtime, mail trap and the clean-start proof
Type: implementation
Decision: docker-compose.yml runs postgres:16-alpine on 127.0.0.1:${DB_PORT:-54316} under a Compose project named after the directory, together with the development mail trap Mailpit (axllent/mailpit v1.31.1, digest-pinned; SMTP on 127.0.0.1:${MAIL_PORT:-51025}, inbox and API on 127.0.0.1:${MAILPIT_UI_PORT:-58025}) that .env.example sends all development mail to; make smoke proves locally that a message sent by the application lands in it. Ports and credentials come from the shell, then .env. Node 22 is pinned in .nvmrc and package.json engines and checked by scripts/toolchain.sh. make dev runs artisan serve, the Vite dev server and schedule:work through concurrently. make clean-start clones the committed HEAD into a temporary directory and runs setup, infra-up, migrate, verify, dev and smoke under a unique Compose project on free ports, then removes the volumes and the clone.
Why: Several clones or worktrees can run side by side; a clean-start that reuses the developer's database or ports would not prove a fresh clone (`15` §3). Development mail must go to a mail trap and never to real recipients (`11` §1); a local trap needs no account, credentials or third party.
Alternatives: Fixed port 5432 (rejected: commonly taken); php artisan dev (rejected: less explicit process list); clean-start in place with down --volumes (rejected: destroys the developer's data and tests uncommitted state); the log mailer (rejected: not a mail trap); a hosted sandbox account such as Mailtrap.io (rejected: a third party receives development mail and credentials are needed; still configurable through the SMTP variables); MailHog (rejected: unmaintained).
Affected specs: `11` §1, `15` §3.

## D-045 (2026-10-09) — Health probe and closed framework endpoints
Type: implementation
Decision: The application's own GET /up (outside the web middleware group, JSON, checks PostgreSQL, 503 without error detail when down) replaces the framework health route. Fortify is installed with views off, no features and Fortify::ignoreRoutes until ACC-03. The local disk's storage/{path} serve route and Inertia DevTools recording are off. A test pins the route list.
Why: The framework health page loads fonts.bunny.net and cdn.jsdelivr.net (`02` §5, D-018) and does not check the database; FND-01 exposes no endpoint beyond what make smoke needs; DevTools would write page props to disk (D-017).
Alternatives: Framework /up (rejected: third-party assets); enable Fortify's default features now (rejected: ACC-03 owns logins and the second factor, `07` §1); framework defaults for serve and DevTools (rejected: unauthenticated endpoints, props on disk).
Affected specs: `02` §4, `02` §5.

## D-046 (2026-10-09) — Framework infrastructure tables keep their own keys
Type: adr
Decision: The UUID primary-key rule covers the product's tables. The framework's own infrastructure tables (migrations, the database-queue tables jobs, failed_jobs and job_batches, cache, sessions, password reset tokens) keep their stock keys; none of those keys is ever exposed in a URL. `03` §1 and the locked register bullet in `14` §1 state the exemption, tagged Q-098. The queue tables ship with their stock schema when the first package queues work.
Why: Owner answer B to Q-098: Laravel's migrations table and database queue (D-025) depend on integer keys, and the rule's purpose, nothing guessable in a URL (`03` §1), is met because those keys never leave the server. Option A needed a custom queue driver or database-generated UUIDv4 keys against D-009.
Alternatives: A) UUID keys on every table including framework tables (rejected by the owner: custom queue driver or database-generated UUIDv4 against D-009, patched migration repository, more code to maintain).
Affected specs: `03` §1, `14` §1.
Owner approval: granted 2026-10-09
