# PLAN

Only `Now` and `Next`. Completed items are removed; Git is the archive. See `AGENTS.md` for rules.

## Now

### FND-01 — Command contract and repository scaffold

- **Outcome:** every target in the root `Makefile` is real, a fresh clone boots and verifies with one command, and the repository layout of the architecture spec exists.
- **Specs:** `15` §3 FND-01, `02` §1 (layout), `12` §1–2 (test layers and gates the contract must expose).
- **Dependencies:** none. This is the first package.
- **Scope:** Create the Laravel 13 application with Fortify, Inertia, Vue 3 in TypeScript, Tailwind 4 and PrimeVue 4 in the layout of `02` §1. Local infrastructure for PostgreSQL 16 (Docker Compose) behind `make infra-up`. Replace every failing placeholder body in the `Makefile` with the real command; keep `make check-docs` as it is. Record tooling choices (test runner, formatter, static analysis, generators) as `decision-added` events with alternatives, then `make rebuild-decisions`.
- **Non-goals:** CI (FND-02); any domain code; any endpoint beyond what `make smoke` needs to prove the processes start.
- **Acceptance (executable):**
  - `make help` lists every target of `AGENTS.md` "Commands" and none exits with the "not implemented" message.
  - `make setup && make infra-up && make migrate && make verify` exit 0 from a fresh clone; `make verify` runs lint, format-check, typecheck, test, test-browser, build and check-docs.
  - `make test` runs against the real database engine named in `12` §1, never a lighter substitute; a test proves which database is in use.
  - `make smoke` exit 0 against the processes `make dev` starts.
  - `make clean-start` exit 0 from removed volumes to teardown.
  - `make check-docs` exit 0; `TRACEABILITY.md` FND-01 row set to `done` with the commands and their results as evidence; G-001 narrowed accordingly.

## Next

1. **FND-02 — CI baseline.** A pipeline on the project's remote that runs one `make` target per job against PostgreSQL 16, with tripwires for gates not yet runnable (`15` §3 FND-02, `12` §1–§2).
2. **FND-03 — Design, accessibility and localization foundation.** Shared tokens and components for the four entry surfaces, the Greek/English skeleton with English fallback, and the accessibility gate (`15` §3 FND-03, `09` §5–§6, §9).
