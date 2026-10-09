# PLAN

Only `Now` and `Next`. Completed items are removed; Git is the archive. See `AGENTS.md` for rules.

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
  - A CI job runs the lock check over the commit range of the merge request or push through a new `make` target (owner ruling 2026-10-09, `.impl/decisions-log.md`); the new target changes the command list, so FND-02 lands a `DECISIONS.md` entry for it through the event log (`scripts/log-append.py`).
  - Node 22 is pinned on the runner (`.nvmrc`), and the Playwright system dependencies are installed on the runner so `make test-browser` runs there (FND-01 worker follow-ups).
  - `make check-docs` exit 0.

## Next

1. **FND-03 — Design, accessibility and localization foundation.** Shared tokens and components for the four entry surfaces, the Greek/English skeleton with English fallback, and the accessibility gate (`15` §3 FND-03, `09` §5–§6, §9).
2. **ACC-01 — Tenancy and isolation harness.** `company_id` and the global scope on a first tenant model; the isolation suite as a reusable harness (`15` §4, `02` §3, `12` §3).
