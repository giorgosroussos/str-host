# FND-01: Command contract and repository scaffold

| Field | Value |
|---|---|
| Status | ready |
| Milestone | Phase 0 |
| Wave | 1 |
| Parallel | no (runs alone) |
| Depends on | — |
| Lane (proposed) | infra |
| Owns | see "Proposed file surface" |
| Contracts | Contract change: yes (D-037: schema and Inertia page props); `.impl/contracts/` not used in pack mode |
| Specs | `specs/15-implementation-plan.md` §3 FND-01; TRACEABILITY key specs: `02` §1–§2, `12` §1–§2 |
| Decisions | D-001, D-006, D-009, D-026, D-036, D-041 |
| Surfaces | — |
| Touches red line | yes |
| Contract change | yes |
| blocked-by (live) | — |
| Prompt 2 review (AGENTS.md table) | yes |
| Risk | high |
| Agent ID |  |
| Branch / worktree | impl/FND-01 (on dispatch) |
| Review rounds | 0 |

## Goal
Command contract and repository scaffold — `specs/15-implementation-plan.md` package FND-01, Phase 0. Acceptance below is copied word for word from the plan; the cited spec sections are the contract.

## Acceptance criteria (word for word, `specs/15` FND-01)
- [ ] AC1: Make every target of the root `Makefile` real, replacing the failing placeholder bodies the documentation pack ships with: `setup`, `infra-up`, `infra-status`, `infra-down`, `migrate`, `dev`, `test`, `test-browser`, `lint`, `format`, `format-check`, `typecheck`, `build`, `verify`, `smoke`, `audit`, `scan-secrets`, `clean-start`. `check-docs` is already real and stays green.
- [ ] AC2: Create the Laravel 13 application with Fortify, Inertia, Vue 3 in TypeScript, Tailwind 4 and PrimeVue 4 in the layout of `02` §1, with the stack of `02` §2.
- [ ] AC3: Local Compose (or equivalent) for PostgreSQL 16; environment examples; lockfiles committed.
- [ ] AC4: `make verify` runs every gate the testing specification requires that exists at this point; `make clean-start` proves a fresh clone boots, verifies and tears down.

### PLAN.md `Now` acceptance (executable), word for word
- `make help` lists every target of `AGENTS.md` "Commands" and none exits with the "not implemented" message.
- `make setup && make infra-up && make migrate && make verify` exit 0 from a fresh clone; `make verify` runs lint, format-check, typecheck, test, test-browser, build and check-docs.
- `make test` runs against the real database engine named in `12` §1, never a lighter substitute; a test proves which database is in use.
- `make smoke` exit 0 against the processes `make dev` starts.
- `make clean-start` exit 0 from removed volumes to teardown.
- `make check-docs` exit 0; `TRACEABILITY.md` FND-01 row set to `done` with the commands and their results as evidence; G-001 narrowed accordingly.

## File surface (approved by the owner 2026-10-09)
Owns (exclusive while in flight):
- everything outside the frozen pack: the Laravel 13 scaffold (`app/**`, `bootstrap/**`, `config/**`, `routes/**`, `resources/**`, `database/**`, `public/**`, `storage/**`, `lang/**`, `tests/**`)
- `composer.json`, `composer.lock`, `package.json`, `package-lock.json`, `vite.config.ts`, `tsconfig.json`, tool configs (Pint, Larastan `phpstan.neon`, ESLint, Prettier, Pest/`phpunit.xml`)
- `docker-compose.yml`, `.env.example`, `.gitignore` (append only)
- `Makefile` (placeholder bodies only; target list unchanged, D-001), `scripts/` new helpers only (never `lock-guard.py`, `unlock.sh`)
- proposed per-area wiring later packages rely on: `routes/staff/` `routes/owner/` loaders that `require` every file in the folder; `lang/{el,en}/` per-area files

Shared files it may edit (serialized by wave planning):
- Creates the contract root; first owner of every file in it.

Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md` (living-document and log changes go in the LANDING block).

## Proposed dependencies
- none (explicit: PLAN.md "This is the first package")

## Notes from main
- Runs alone (design-pack-mode: FND-01 runs alone first). `make verify` cannot pass before it.
- Tooling choices (test runner plugins, browser test runner, secret scanner, audit tool) go to the LANDING block as `decision-added` events with alternatives; D-006 already fixes Pest, Larastan level 6, Pint, vue-tsc, ESLint, Prettier.
- Never edit `AGENTS.md` "Commands" list or remove a Makefile target; the list is the contract (D-001).

## Log

- 2026-10-09: worker dispatched (opus, worktree isolation), branch impl/FND-01 off impl/wave-1.
- 2026-10-09 worker: branch impl/FND-01 from origin/impl/wave-1, relocked, hooks active. Read AGENTS/PLAN/GAPS/TRACEABILITY, D-001/006/009/026/036/037/041, specs 02, 03 §1, 11 §1, 12, 15 §3. Host node is v12 (nvm has 22/24): pinning Node 22 via .nvmrc and a toolchain check.
- 2026-10-09 worker: scaffold in place (Laravel 13.35, Fortify inert, Inertia 3 + Vue 3 TS, Tailwind 4, PrimeVue 4.5, Pest 4 + browser, Larastan L6). Every Makefile placeholder replaced; make verify green locally; make smoke green against make dev. Choices in .impl/inbox/FND-01.md. Next: commit, then make clean-start from the commit.
- 2026-10-09 worker: make clean-start exit 0 from the commit (fresh clone, own Compose project on free ports: setup, infra-up, migrate, verify [12+2 tests, check-docs 0 failures], dev, smoke), teardown left no container, volume, process or temp dir. infra-down keeps data (migrate after re-up: nothing to migrate). Done; LANDING in the worker report.
- 2026-10-09: worker reported done at fd0eaca (worktree .claude/worktrees/agent-a3198ea01ae0f42eb). Opened card Q-NEW-1 (UUID keys on framework tables, blocks ACC-02). LANDING block requested to .impl/landing/FND-01.md.
- 2026-10-09: owner answered Q-NEW-1 = B. Worker asked to add card-answered/card-resolved events and the `03` §1 spec amendment to the LANDING file.
- 2026-10-09: LANDING updated at 9b8e124. The UUID rule is a locked register bullet and an AGENTS.md red line, so the exemption is an ADR (D-NEW-5), which needs the owner's adr-approval-changed event. It edits both `03` §1 and `14` §1. Owner unlock is needed for both files.
- 2026-10-09: owner approved ADR D-NEW-5 in session; record adr-approval-changed --actor owner at landing.


## Verification (round 1)

Independent verifier, fresh context, isolated worktree `.claude/worktrees/agent-a21dc6bc0b4b482c4`. Checked out `impl/FND-01` detached at afd3e3a (code commit fd0eaca); `lock-guard --relock` set 26 files read-only. The branch moved to 9b8e124 during the run. 9b8e124 changes only `.impl/landing/FND-01.md`, so every code result below holds for it, and the LANDING check covers both versions. Toolchain: PHP 8.3.30, Composer 2.8.12, Node v22.23.2 (put first on PATH), Docker. Shell overrides so this run could not collide with another worktree: `DB_PORT=54391 APP_PORT=8391 VITE_PORT=5391 APP_URL=http://127.0.0.1:8391`.

### Commands run

| Command | Exit | Counts / observations |
|---|---|---|
| `make setup` | 0 | composer install, `npm ci` (210 packages), `.env` created, APP_KEY generated, Playwright chromium. Afterwards `git status` was clean: the regenerated `bootstrap/cache/*.php` matched the committed copies. |
| `make infra-up` | 0 | `postgres:16-alpine` healthy, published on `127.0.0.1:54391` only |
| `make infra-status` | 0 | 1 container, healthy |
| `make migrate` | 0 | 2 migrations (users/password_reset_tokens/sessions, cache/cache_locks) |
| `make verify` | 0 | phpstan L6: no errors. eslint: clean. pint and prettier: pass. vue-tsc: clean. `make test`: 12 passed (36 assertions), Unit 2, Feature 10. `make test-browser`: 2 passed (9 assertions). build: 676 modules. check-docs: 0 failures, 334 records, chain intact. |
| `make dev` + `make smoke` | smoke 0 | `/up` → `{"status":"up","database":"up"}`; `/` renders Inertia `Home`; the Vite client is served. `make dev` was stopped by killing it (exit 2 from the kill, as expected). |
| `make audit` | 0 | composer: no advisories. npm: 0 vulnerabilities. |
| `make scan-secrets` | 0 | gitleaks v8.30.1 (digest-pinned) over 179 tracked files: no leaks |
| `make help` | 0 | 25 targets plus help. They match the AGENTS.md "Commands" list. The Makefile contains no `not implemented` or `not_yet` text. |
| `make clean-start` | 0 | It cloned afd3e3a into `/tmp/str-host-clean-start.*` under its own Compose project on random free ports and ran setup → infra-up → migrate → verify (12 + 2 tests, check-docs 0 failures) → dev → smoke (3 ok) → teardown. Afterwards no container, volume, process or temp directory was left behind. |
| `make infra-down` + `docker volume rm` | 0 | Own stack and volume removed |

Endpoint probe against `make dev`: `/` 200 and `/up` 200. These all return 404: `/login`, `/register`, `/forgot-password`, `/user/two-factor-authentication`, `/storage/x`, `/app`, `/owner`, `/g/abc`, `/c/abc`, `/_ignition/health-check`, `/telescope`, `/horizon`, `/passkeys`, `/.env` and `/sanctum/csrf-cookie`. `POST /up` returns 405. Neither the 404 page nor the debug error page loads any third-party font, script or style.

### Acceptance criteria

- AC1, Makefile targets real: **met.** All 18 listed bodies are replaced (diff against impl/wave-1), and the target list and `.PHONY` are unchanged. `check-docs` is unchanged and green. The header comment was reworded, which is harmless.
- AC2, Laravel 13 with Fortify, Inertia, Vue 3 TS, Tailwind 4, PrimeVue 4, in the `02` §1 layout and `02` §2 stack: **met.** composer pins `laravel/framework ^13.17` with platform PHP 8.3.0, `laravel/fortify ^1.41` and `inertiajs/inertia-laravel ^3.5`. npm pins `vue ^3.5`, `primevue ^4.5.5`, `tailwindcss ^4.3` and TypeScript 6. The `02` §1 layout exists: `app/Actions`, `app/Money`, `app/Http/Controllers/{Staff,Owner,Guest,Cleaner}`, `resources/js/Pages/{...}`, `lang/{el,en}`, `tests/{Unit,Feature,Isolation}`, `docker-compose.yml` and `Makefile`. D-006 tools are all present: Pest, Larastan L6 (`phpstan.neon`), Pint, vue-tsc, ESLint (Vue and TypeScript configs) and Prettier.
- AC3, Compose PostgreSQL 16, environment examples, lockfiles: **met.** `docker-compose.yml` runs postgres:16-alpine on loopback only, and Compose creates the test database. `.env.example` exists. `composer.lock` and `package-lock.json` are committed.
- AC4, `make verify` runs every gate that exists, and `make clean-start` proves a fresh clone: **met.** `verify` = lint, format-check, typecheck, test, test-browser, build and check-docs, which covers every `12` §2 gate. clean-start exited 0 as described above.
- PLAN `Now` acceptance: `make help` has no `not implemented` (met). setup + infra-up + migrate + verify from a fresh clone (met, via clean-start). `make test` runs on PostgreSQL 16: `tests/Feature/DatabaseEngineTest.php` asserts driver `pgsql`, server major version 16 and database `str_host_test`, and `phpunit.xml` forces `DB_CONNECTION=pgsql` and `DB_DATABASE` (met, `12` §1, D-041). Smoke against dev (met). clean-start (met). The check-docs, TRACEABILITY and G-001 bullet is delivered through the LANDING block, which was dry-run green (see below).

### Surface check

`git diff --name-only impl/wave-1...impl/FND-01` lists 97 paths, all inside the approved surface. They are the scaffold directories, root tool configs (`.editorconfig`, `.gitattributes`, `.npmrc`, `.nvmrc`, `.prettierrc.json`, `eslint.config.js`, `pint.json`, `phpstan.neon`, `phpunit.xml`), `docker-compose.yml`, `.env.example` and `Makefile`. The `scripts/` changes are all new files (`clean-start.sh`, `dev.sh`, `env-value.sh`, `scan-secrets.sh`, `smoke.sh`, `toolchain.sh`), and `.gitignore` was only appended to. The `.impl/` files changed are inbox and landing (added) and tasks (log lines only). The diff writes none of `.log/**`, DECISIONS.md, QUESTIONS.md, PLAN.md, GAPS.md, TRACEABILITY.md, AGENTS.md, `specs/**`, `lock-guard.py` or `unlock.sh`. **Pass.**

### LANDING check

- **afd3e3a version:** applied with real IDs (D-042…D-045, Q-098) through `log-append.py --root <scratch copy>`. Events 1–4 were accepted, with no dead citations. Event 5 (`card-opened` with `"blocks": "ACC-02"`) was **refused, exit 2**, because `eventlog._validate_card` requires `blocks=specification` on open. With that corrected, plus a `card-deferred blocks=ACC-02`, check-docs reported 0 failures.
- **9b8e124 version (current):** the worker has already fixed this. Applied end to end on a fresh scratch copy: events 1–9 were all accepted (seq 335–343), the two spec edits of §5 matched their "Old" text exactly, both projections were rebuilt, and the TRACEABILITY, GAPS and PLAN edits were applied. `check-docs`: **0 failures**, 343 records, chain intact, Q-098 resolved, D-046 rendered `Type: adr` with `Owner approval: granted`. **Pass.**
- TRACEABILITY evidence matches what I observed: 12 tests, DatabaseEngineTest on pgsql 16, 2 browser tests with axe, check-docs 0 failures, audit 0, scan-secrets no leaks, no `not implemented` in help, and clean-start exit 0.
- Q-NEW-1 is a fair card. The source quote is accurate: the stock `migrations` table uses an integer id and the jobs tables use bigint ids. Both options state their effect on data. The recommendation gives its reason and names the package it blocks. Caveat for the lander: Event 8 (`adr-approval-changed ... granted`, actor owner) must be appended only on the owner's explicit ADR approval. The owner's answer B to the card is not by itself an approval of the D-NEW-5 ADR text and its `14` §1 edit.

### Deep review (Prompt 2, `16` §7)

**Pass 1, correctness against spec**
- MEDIUM, `.env.example:50` (`MAIL_MAILER=log`) and `config/mail.php:17` (default `log`): `11` §1 says "Development email MUST go to a mail-trap account" [Q-036]. Logging to `storage/logs` meets "never to real recipients" but not the mail-trap part, and the choice appears in neither the inbox nor the LANDING decisions. Carry it to the package that first sends mail (ACC-02), or log it as a decision.
- LOW, `app/Http/Controllers/HomeController.php` and `HealthController.php` sit at the controllers root rather than in a surface folder (`02` §1, D-026). This is reasonable for a non-surface probe and a placeholder page, but FND-03 or OUT-* should move or replace `Home`.
- LOW, AGENTS.md:68 ("A target whose work package has not been delivered yet fails ...") is also stale after FND-01. LANDING §6 updates only line 98.
- Everything else matches: `03` §1 / D-009 (users uuid key, `HasUuids` UUIDv7, both tested in `tests/Feature/PrimaryKeyTest.php`), `02` §4 (route groups `/app` and `/owner` wired, empty), and `02` §6 (scheduler in `make dev`; queue deferred to G-002).

**Pass 2, security and isolation (scaffold scope)**
- MEDIUM, `bootstrap/cache/packages.php` and `bootstrap/cache/services.php` are committed, and the skeleton's `bootstrap/cache/.gitignore` is gone. `git check-ignore bootstrap/cache/config.php` matches nothing (exit 1). So `php artisan config:cache` or `optimize` would write a file holding APP_KEY and DB credentials into a path Git would happily stage. Generated manifests also should not be versioned. Fix: restore `bootstrap/cache/.gitignore` (`*`, `!.gitignore`) and untrack both files.
- LOW, `bootstrap/app.php:21` (`/up`): unauthenticated, unthrottled, one `select 1` per request. Acceptable now; add a throttle or proxy restriction when HOST packages land.
- LOW, `config/session.php:172`: `SESSION_SECURE_COOKIE` is unset, so the cookie is not Secure by default. `SESSION_ENCRYPT=false`. Both are fine locally and must be set by the production config package.
- Good: Postgres, `artisan serve` and Vite are bound to 127.0.0.1. Fortify has `features=[]` and `ignoreRoutes`, and `/login` returns 404 (tested). Local disk `serve=false`. Inertia DevTools are off. The route list is pinned by `tests/Feature/RoutesTest.php`. `/up` gives no error detail on 503 and starts no session (tested). `.npmrc` has `ignore-scripts=true`. gitleaks is digest-pinned. The framework health page and bunny fonts were removed (D-018). The browser test asserts every loaded resource is same-origin. The guest, cleaner and owner surfaces do not exist yet, so there are no cross-account, link or receipt cases to attack.

**Pass 3, tests**
- LOW, `tests/Feature/HomePageTest.php` "loads nothing from a third-party host" is close to vacuous: `withoutVite()` strips the asset tags, so the HTML it scans has nearly no `src`/`href`. The real guard is `tests/Browser/HomePageTest.php` (performance resource entries). Keep the browser test and consider dropping or strengthening the feature one.
- LOW: the `el` translation of `common.php` is never exercised, and there is no test of the English fallback (FND-03 owns i18n).
- LOW: `make verify` runs `npm run build` twice (test-browser and build). This wastes time but is not incorrect.
- Good: the negative cases present are a DB-down 503, Fortify closed, and no session on the probe. Concurrency and idempotency do not apply at this stage.

**Pass 4, UX and accessibility (one page)**
- `resources/js/Pages/Home.vue` and `resources/views/app.blade.php`: `<html lang>` follows the locale, the viewport meta is present, and there is a `<main>` and an `h1`. axe at every impact level (`assertNoAccessibilityIssues(3)`, where 3 is the most inclusive) found no issues in Chromium. No fonts or icons come from third parties. There are no loading, empty or error states to judge, and there is no Greek switch yet (FND-03). No findings.

**Critical / high findings: none.**
- 2026-10-09: verifier round 1 PASS with 2 medium notes (bootstrap/cache tracked, dev mail not a mail trap per `11` §1). Worker resumed to fix both before integration.
- 2026-10-09 worker: verification round 1 fixes: Mailpit mail trap (compose, .env.example, smoke round trip, clean-start ports), bootstrap/cache ignored and generated files untracked, real third-party asset tests. make verify exit 0 (13+2 tests); make dev + smoke passed incl. mail trap; make clean-start exit 0 on 71bff28; landing block updated and dry-run green.
- 2026-10-09: worker fixes at 71bff28 (bootstrap/cache ignored, Mailpit mail trap, stronger asset tests), landing updated at c777e10. Verifier round 2 started.

## Verification (round 2)

Checked out `impl/FND-01` detached at c777e10 (code 71bff28); relock set 26 files read-only. Deleted the round-1 `.env` so `make setup` copied the new `.env.example`. Overrides: `DB_PORT=54391 MAIL_PORT=51391 MAILPIT_UI_PORT=58391 APP_PORT=8391 VITE_PORT=5391 APP_URL=http://127.0.0.1:8391`.

### Commands
| Command | Exit | Observations |
|---|---|---|
| `make setup` | 0 | regenerates `bootstrap/cache/{packages,services}.php`; `git status` clean afterwards (they are ignored) |
| `make infra-up` / `infra-status` | 0 / 0 | postgres:16-alpine and mailpit v1.31.1 (digest-pinned) both healthy; ports 54391, 51391 (SMTP), 58391 (UI/API) all on 127.0.0.1 only |
| `make migrate` | 0 | 2 migrations |
| `make verify` | 0 | phpstan, eslint, pint, prettier, vue-tsc all clean; `make test`: 13 passed (47 assertions); `make test-browser`: 2 passed (9); build ok; check-docs: 0 failures |
| `make dev` + `make smoke` | 0 | /up, /, Vite client, and "mail sent by the application landed in the mail trap" |
| Negative: `docker compose stop mailpit` then `make smoke` | 2 | `smoke: FAIL the application could not send through 127.0.0.1:51391`, so the mail step is a real check |
| `make infra-down` + volume rm | 0 | stops both services and removes the network; nothing of mine left |
| `make clean-start` | 0 | clones c777e10; free ports, including MAIL_PORT and MAILPIT_UI_PORT; verify 13+2 tests, check-docs 0; smoke 4 ok including the mail trap; torn down. Afterwards there is no clean-start container, volume or /tmp dir. |

### The four fixes
1. **bootstrap/cache: fixed.** `bootstrap/cache/.gitignore` (`*`, `!.gitignore`) is restored. `git ls-files bootstrap` now lists only app.php, providers.php and cache/.gitignore. `git check-ignore -v bootstrap/cache/config.php` matches `bootstrap/cache/.gitignore:1:*`.
2. **Mail trap: fixed, meets `11` §1 [Q-036].**
   - `.env.example`: `MAIL_MAILER=smtp` to 127.0.0.1:51025, which is Mailpit in `docker-compose.yml`, loopback-bound and digest-pinned. No third party is involved and no credentials are needed.
   - Wiring: infra-up waits on Mailpit's healthcheck, infra-status shows it, and infra-down removes it. smoke does a real round trip (tinker `Mail::raw`, then the Mailpit search API). clean-start allocates both ports.
   - The choice and its alternatives are logged as inbox #18 and in D-NEW-3.
   - LOW: Mailpit's web UI can check GitHub for new releases, and messages with remote images or CSS could load them in the inbox viewer. This affects the developer's own browser in development only, not a product page under `02` §5. `MP_DISABLE_VERSION_CHECK=1` and `MP_BLOCK_REMOTE_CSS_AND_FONTS=1` would close it. This is optional.
3. **Third-party asset tests: fixed, and they guard.** Mutation test: I added `<link href="https://fonts.bunny.net/...">` and `<script src="https://cdn.jsdelivr.net/...">` to `resources/views/app.blade.php`. Both new feature tests then failed: the rendered-tag test reported "third-party asset: https://fonts.bunny.net/css?family=inter", and the source scan reported "views/app.blade.php references fonts.bunny.net, cdn.jsdelivr.net". I reverted the mutation and `git status` is clean. The browser same-origin test is still in place.
4. **LANDING: well-formed.**
   - I dry-ran c777e10's landing on a scratch copy with D-042…D-046 and Q-098. Events 1–9 were all accepted by `log-append.py --root <scratch>` (seq 335–343). The `03` §1 and `14` §1 Old texts matched once each. I rebuilt both projections and applied the TRACEABILITY, GAPS and PLAN edits. check-docs: **0 failures**, 343 records, chain intact.
   - The AGENTS.md line-68 Old text in §6 matches the file exactly.
   - The TRACEABILITY evidence (71bff28: 13 tests, 2 browser tests, smoke including the mail trap, clean-start) matches what I observed.
   - Event 8 states that the owner explicitly approved ADR D-NEW-5, relayed by the coordinator. I cannot verify that approval; the lander should append Event 8 only on that basis.

### Surface
`git diff --name-status impl/wave-1...impl/FND-01` stays within the approved surface:
- the scaffold directories
- root tool configs, `docker-compose.yml`, `.env.example` and `.gitignore` (append only)
- `Makefile` bodies
- new `scripts/*.sh` files only
- `.impl/{inbox,landing,tasks}/FND-01.md`

It writes none of `.log/**`, DECISIONS.md, QUESTIONS.md, PLAN.md, GAPS.md, TRACEABILITY.md, AGENTS.md, `specs/**`, `lock-guard.py` or `unlock.sh`. **Pass.**

### Remaining from round 1 (low, not blocking)
- `/up` is unthrottled.
- `SESSION_SECURE_COOKIE` is unset; the production config must set it.
- `make verify` builds twice.
- HomeController and HealthController sit at the controllers root.
- There is no el/fallback test (FND-03).

**Critical / high findings: none.**
- 2026-10-09: verifier round 2 PASS at c777e10. Low notes carried as follow-ups. Event 8 owner approval is genuine (owner said 'approve the ADR' in session).
- 2026-10-09: integrated via slow path (integrator agent), impl/wave-1 fast-forwarded to 5880b77. Only conflict: this task file's Log. Gates green on merged result.
- 2026-10-09: landed, events 335–343, IDs assigned: D-NEW-1..D-NEW-5 -> D-042..D-046, Q-NEW-1 -> Q-098.
