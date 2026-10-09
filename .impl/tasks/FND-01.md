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

- 2026-10-09 worker: branch impl/FND-01 from origin/impl/wave-1, relocked, hooks active. Read AGENTS/PLAN/GAPS/TRACEABILITY, D-001/006/009/026/036/037/041, specs 02, 03 §1, 11 §1, 12, 15 §3. Host node is v12 (nvm has 22/24): pinning Node 22 via .nvmrc and a toolchain check.
- 2026-10-09 worker: scaffold in place (Laravel 13.35, Fortify inert, Inertia 3 + Vue 3 TS, Tailwind 4, PrimeVue 4.5, Pest 4 + browser, Larastan L6). Every Makefile placeholder replaced; make verify green locally; make smoke green against make dev. Choices in .impl/inbox/FND-01.md. Next: commit, then make clean-start from the commit.
- 2026-10-09 worker: make clean-start exit 0 from the commit (fresh clone, own Compose project on free ports: setup, infra-up, migrate, verify [12+2 tests, check-docs 0 failures], dev, smoke), teardown left no container, volume, process or temp dir. infra-down keeps data (migrate after re-up: nothing to migrate). Done; LANDING in the worker report.
- 2026-10-09 worker: verification round 1 fixes: Mailpit mail trap (compose, .env.example, smoke round trip, clean-start ports), bootstrap/cache ignored and generated files untracked, real third-party asset tests. make verify exit 0 (13+2 tests); make dev + smoke passed incl. mail trap; make clean-start exit 0 on 71bff28; landing block updated and dry-run green.
