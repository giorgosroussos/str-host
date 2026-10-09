# FND-01 landing block

Worker branch `impl/FND-01`, code commit `fd0eaca4c87b90f20a2793be6d563e6cca487ac6`. Apply on top of the merged branch: event log first, then the projections, then the living documents. Placeholder IDs: replace `D-NEW-1`…`D-NEW-4` with the next free D-numbers and `Q-NEW-1` with the next free Q-number, consistently everywhere below (including G-002).

## 1. Events (date 2026-10-09)

### Event 1: D-NEW-1

```bash
python3 scripts/log-append.py --type decision-added \
  --set id=D-NEW-1 --set date=2026-10-09 \
  --set title="Test runner plugins and the test database" \
  --set type=implementation \
  --set decision="Pest 4 with pest-plugin-laravel 4 and pest-plugin-browser 4 (Playwright Chromium headless shell, installed by make setup). Suites tests/Unit, tests/Feature, tests/Isolation run in make test; tests/Browser runs in make test-browser after a production build, each visited page checked with assertNoAccessibilityIssues at every axe impact level. Tests run on the database str_host_test of the Compose PostgreSQL 16 server, forced in phpunit.xml together with DB_CONNECTION=pgsql; Feature and Isolation use RefreshDatabase and withoutVite so make test needs no build." \
  --set why="Pest 5 requires PHP 8.4 and the stack fixes 8.3 (\`02\` §2); one server with a separate database keeps tests off development data with nothing extra to start; forcing the connection makes a SQLite run impossible (\`12\` §1, D-041)." \
  --set alternatives="Pest 5 (rejected: PHP 8.4); a second Compose service for tests (rejected: extra process for no isolation gain); Testcontainers (rejected: another dependency); axe at serious-and-above only (rejected: weaker than the WCAG target needs)." \
  --set affected_specs="\`12\` §1."
```

### Event 2: D-NEW-2

```bash
python3 scripts/log-append.py --type decision-added \
  --set id=D-NEW-2 --set date=2026-10-09 \
  --set title="Secret scan and dependency audit" \
  --set type=implementation \
  --set decision="make scan-secrets runs gitleaks v8.30.1 from its container image pinned by digest over a copy of the working-tree version of every path git ls-files lists. make audit runs composer audit --locked and npm audit at the default level, so any advisory fails. ESLint is configured with typescript-eslint, eslint-plugin-vue and eslint-config-prettier rather than @vue/eslint-config-typescript." \
  --set why="Docker is already a prerequisite, the digest makes the scanner reproducible and the scope is the contract's 'everything Git tracks'; neither tool sends data to a third party (\`02\` §5); @vue/eslint-config-typescript pulls braces, which has an unfixed high advisory and would fail the audit gate." \
  --set alternatives="trufflehog (rejected: heavier, same coverage); a downloaded gitleaks binary (rejected: install and checksum handling); gitleaks git history scan (rejected: fails inside git worktrees, and history is fixed by then); audit only high and critical (rejected: weaker gate); Snyk or OSV services (rejected: third party)." \
  --set affected_specs="\`12\` §2."
```

### Event 3: D-NEW-3

```bash
python3 scripts/log-append.py --type decision-added \
  --set id=D-NEW-3 --set date=2026-10-09 \
  --set title="Local runtime and the clean-start proof" \
  --set type=implementation \
  --set decision="docker-compose.yml runs postgres:16-alpine on 127.0.0.1:\${DB_PORT:-54316} under a Compose project named after the directory; ports and credentials come from the shell, then .env. Node 22 is pinned in .nvmrc and package.json engines and checked by scripts/toolchain.sh. make dev runs artisan serve, the Vite dev server and schedule:work through concurrently. make clean-start clones the committed HEAD into a temporary directory and runs setup, infra-up, migrate, verify, dev and smoke under a unique Compose project on free ports, then removes the volume and the clone." \
  --set why="Several clones or worktrees can run side by side; a clean-start that reuses the developer's database or ports would not prove a fresh clone (\`15\` §3, \`11\` §1)." \
  --set alternatives="Fixed port 5432 (rejected: commonly taken); php artisan dev (rejected: less explicit process list); clean-start in place with down --volumes (rejected: destroys the developer's data and tests uncommitted state)." \
  --set affected_specs="\`11\` §1, \`15\` §3."
```

### Event 4: D-NEW-4

```bash
python3 scripts/log-append.py --type decision-added \
  --set id=D-NEW-4 --set date=2026-10-09 \
  --set title="Health probe and closed framework endpoints" \
  --set type=implementation \
  --set decision="The application's own GET /up (outside the web middleware group, JSON, checks PostgreSQL, 503 without error detail when down) replaces the framework health route. Fortify is installed with views off, no features and Fortify::ignoreRoutes until ACC-03. The local disk's storage/{path} serve route and Inertia DevTools recording are off. A test pins the route list." \
  --set why="The framework health page loads fonts.bunny.net and cdn.jsdelivr.net (\`02\` §5, D-018) and does not check the database; FND-01 exposes no endpoint beyond what make smoke needs; DevTools would write page props to disk (D-017)." \
  --set alternatives="Framework /up (rejected: third-party assets); enable Fortify's default features now (rejected: ACC-03 owns logins and the second factor, \`07\` §1); framework defaults for serve and DevTools (rejected: unauthenticated endpoints, props on disk)." \
  --set affected_specs="\`02\` §4, \`02\` §5."
```

### Event 5: Q-NEW-1 (card-opened)

Save the payload as `q-new-1.json` (a JSON array, as `--payload-file` expects for the questions stream), then append:

```json
[
  {
    "id": "Q-NEW-1",
    "title": "UUID keys on framework infrastructure tables",
    "surface": "data",
    "source": "FND-01 implementation: `03` §1: \"Every table MUST use a UUID primary key\"; Laravel's migrations table (integer id) and database-queue tables jobs and failed_jobs (bigint ids) cannot follow it without a custom queue driver",
    "question": "Do framework infrastructure tables (migrations, jobs, failed_jobs, job_batches, cache, sessions, password reset tokens) fall under the UUID primary-key rule of `03` §1?",
    "blocks": "ACC-02",
    "options": [
      "A) Yes, every table → effect on data: a custom database queue driver or database-generated keys (UUIDv4, against D-009) and a patched migration repository; more code to maintain",
      "B) No, the rule covers product tables; framework tables keep their keys because none is ever exposed in a URL → effect on data: `03` §1 gains an explicit exemption by spec amendment, and the queue tables ship with their stock schema"
    ],
    "recommendation": "B, because those keys never leave the server and the rule's purpose (nothing guessable in a URL) is met. Needed before the first queued email (ACC-02, `02` §6)."
  }
]
```

```bash
python3 scripts/log-append.py --stream questions --type card-opened --payload-file q-new-1.json
```

### Event 6: rebuild the projections

```bash
make rebuild-decisions && make rebuild-questions
```

## 2. TRACEABILITY.md

FND-01 row (replaces the current `not started` row):

```
| FND-01 | 0 | Command contract and repository scaffold | `02` §1–§2, `12` §1–§2 | done | 2026-10-09, impl/FND-01 fd0eaca: `make clean-start` exit 0 (fresh clone → setup, infra-up, migrate, verify, dev, smoke, teardown); `make verify` exit 0 (lint, format-check, typecheck, test 12 passed incl. tests/Feature/DatabaseEngineTest [pgsql 16], test-browser 2 passed with axe, build, check-docs 0 failures); `make smoke` passed against `make dev`; `make audit` 0 advisories; `make scan-secrets` no leaks; `make help` no "not implemented" |
```

"Reproducing the evidence": add after the code block:

> `make migrate`, `make test`, `make test-browser` and `make dev` need `make infra-up` first. Node must match `.nvmrc` (`nvm use`); `scripts/toolchain.sh` fails with the fix otherwise.

## 3. GAPS.md

G-001, narrowed (replaces the current row):

```
| G-001 | The command contract and scaffold exist (FND-01), but there is no CI and no domain code. Every work package after FND-01 in `specs/15-implementation-plan.md` is unstarted. | No gate runs on the remote, and no product requirement is verifiable yet. | Per-package rows in `TRACEABILITY.md` moving to `done` with command and test evidence. | FND-02, then Phase 0 onward |
```

G-002, new:

```
| G-002 | The database queue tables (jobs, failed_jobs, job_batches) are not migrated, and `make dev` runs no queue worker, pending Q-NEW-1. | Nothing can be queued yet; a dispatch on the `database` connection fails loudly. | Queue migration and a `queue:work` process in `make dev`, plus a test that dispatches a job on PostgreSQL. | ACC-02 |
```

## 4. PLAN.md

Remove the `### FND-01 — Command contract and repository scaffold` section from `Now`. New content:

```markdown
## Now

### FND-02 — CI baseline

- **Outcome:** a pipeline on the project's remote runs every gate as one `make` target per job, so "CI is green" and "`make verify` is green" are the same statement.
- **Specs:** `15` §3 FND-02, `12` §1–§2.
- **Dependencies:** FND-01 (done).
- **Acceptance (executable):**
  - A pipeline on the remote runs on every merge request and every push to main, against a PostgreSQL 16 service.
  - Each job runs exactly one `make` target, and `make check-docs` has its own job.
  - `README.md` maps each job to its command.
  - Gates not yet runnable are failing-forward tripwires.
  - `make audit` and `make scan-secrets` run as jobs.
  - No job retries.
  - A red pipeline blocks the merge.
  - `make check-docs` exit 0.

## Next

1. **FND-03 — Design, accessibility and localization foundation.** Shared tokens and components for the four entry surfaces, the Greek/English skeleton with English fallback, and the accessibility gate (`15` §3 FND-03, `09` §5–§6, §9).
2. **ACC-01 — Tenancy and isolation harness.** `company_id` and the global scope on a first tenant model; the isolation suite as a reusable harness (`15` §4, `02` §3, `12` §3).
```

## 5. Spec amendments

None.

## 6. AGENTS.md, optional ("Commands" wording is stale since FND-01)

Old:

> `check-docs`, `check-locks`, `verify-chain`, the two `rebuild-*` targets, `install-hooks` and `unlock` are real from the first commit; the rest arrive with FND-01.

New:

> `check-docs`, `check-locks`, `verify-chain`, the two `rebuild-*` targets, `install-hooks` and `unlock` are real from the first commit; the rest are real since FND-01. `make test`, `make test-browser`, `make migrate` and `make dev` need `make infra-up` first; Node must match `.nvmrc`.
