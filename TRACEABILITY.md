# TRACEABILITY

Implementation status and evidence per work package (`specs/15-implementation-plan.md`) and per critical journey (`specs/12-testing-acceptance.md` §6). Status values: `not started`, `in progress`, `done`. Status is set only from evidence that ran and passed; never from plans, file presence or stubs. `make check-docs` verifies that every package has exactly one row and that `done` rows carry evidence. The product-intent scope matrix is `specs/13-traceability.md`.

## Work packages

| Package | Phase | Outcome | Key specs | Status | Evidence |
| --- | --- | --- | --- | --- | --- |
| FND-01 | 0 | Command contract and repository scaffold | `02` §1–§2, `12` §1–§2 | done | 2026-10-09, impl/FND-01 71bff28: `make clean-start` exit 0 (fresh clone → setup, infra-up [PostgreSQL 16 + Mailpit mail trap], migrate, verify, dev, smoke, teardown); `make verify` exit 0 (lint, format-check, typecheck, test 13 passed incl. tests/Feature/DatabaseEngineTest [pgsql 16] and tests/Feature/HomePageTest [no third-party host], test-browser 2 passed with axe, build, check-docs 0 failures); `make smoke` passed against `make dev`, including a mail sent by the application landing in the mail trap (`11` §1); `make audit` 0 advisories; `make scan-secrets` no leaks; `make help` no "not implemented" |
| FND-02 | 0 | CI baseline | `12` §1 | not started | — |
| FND-03 | 0 | Design, accessibility and localization foundation | `02` §4, `09` §5–§6, `09` §9 | not started | — |
| ACC-01 | 1 | Tenancy and isolation harness | `02` §3, `12` §3 | not started | — |
| ACC-02 | 1 | Sign-up, approval and terms | `01` §4, `10` §8, `11` §4 | not started | — |
| ACC-03 | 1 | Logins, invitations, roles and second factor | `07` §1–§4, `10` §9 | not started | — |
| ACC-04 | 1 | Audit trail | `03` §6, `10` §4 | not started | — |
| PRP-01 | 2 | Owners and properties | `03` §2–§3, `03` §4 | not started | — |
| PRP-02 | 2 | Property terms | `06` §2, `07` §2 | not started | — |
| PRP-03 | 2 | Cleaners and their links | `05` §3, `10` §2 | not started | — |
| RES-01 | 3 | Reservations and overlap | `04` §1–§4 | not started | — |
| RES-02 | 3 | Money lines and climate fee rates | `04` §5, `06` §5 | not started | — |
| RES-03 | 3 | Calendar and timeline | `04` §6, `09` §1 | not started | — |
| RES-04 | 3 | Turnovers | `05` §1–§2 | not started | — |
| MON-01 | 4 | Calculation engine | `06` §1–§4, `12` §5 | not started | — |
| MON-02 | 4 | Expenses and receipts | `06` §6, `03` §2, `10` §5 | not started | — |
| MON-03 | 4 | Statement lifecycle | `06` §9 | not started | — |
| MON-04 | 4 | Adjustments and carry-forward | `06` §7–§8 | not started | — |
| MON-05 | 4 | Statement PDF and email | `06` §9, `09` §7 | not started | — |
| MON-06 | 4 | Dashboard and cleaner pay summary | `09` §2, `05` §4 | not started | — |
| OUT-01 | 5 | Owner portal | `08` §1 | not started | — |
| OUT-02 | 5 | Guest page and map | `08` §2, `02` §5, `11` §7 | not started | — |
| OUT-03 | 5 | Cleaner link | `08` §3 | not started | — |
| OPS-01 | 6 | Retention jobs | `10` §5 | not started | — |
| OPS-02 | 6 | Account lifecycle and data requests | `10` §6–§7, `11` §4 | not started | — |
| OPS-03 | 6 | Production deployment and backups | `11` §2–§3, `11` §5 | not started | — |
| OPS-04 | 6 | Release acceptance | `12` §6, `12` §7 | not started | — |

## Critical end-to-end journeys (`12` §6)

| # | Journey | Status | Evidence |
| --- | --- | --- | --- |
| 1 | Get an account (`09` §3) | not started | — |
| 2 | Onboard owners, properties and cleaners (`09` §3) | not started | — |
| 3 | Run a month (`09` §3) | not started | — |
| 4 | Close a month (`09` §3) | not started | — |
| 5 | Owner reads a finalised statement (`09` §4) | not started | — |
| 6 | Guest opens their stay (`09` §4) | not started | — |
| 7 | Cleaner marks a turnover done (`09` §4) | not started | — |

## Phase exit criteria

Phase exit criteria are in `specs/15-implementation-plan.md` §3–§9. A phase is exited only when every package in it is `done` here and its exit criteria have recorded evidence. No phase has been entered.

## Reproducing the evidence

From a clone, once FND-01 has delivered the command contract:

```bash
make setup        # dependencies from lockfiles, env examples
make infra-up     # local infrastructure (required by make test and make smoke)
make migrate
make verify       # lint, format-check, typecheck, test, test-browser, build, check-docs
make smoke
make audit        # the CI dependency-scan gate
make scan-secrets # the CI secret-scan gate
make check-docs   # runs today, before any code exists
```

`make migrate`, `make test`, `make test-browser`, `make dev` and `make smoke` need `make infra-up` first (PostgreSQL 16 and the Mailpit mail trap, inbox at `http://127.0.0.1:${MAILPIT_UI_PORT:-58025}`). Node must match `.nvmrc` (`nvm use`); `scripts/toolchain.sh` fails with the fix otherwise.

`make clean-start` runs the same sequence from a fresh environment and tears it down afterwards. Evidence recorded in this file names the command, the date and what it proved; a reviewer must be able to repeat it from this section.
