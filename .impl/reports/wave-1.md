# Wave 1: The project scaffold and command contract

> **This report is the pull request description.** `gh` is not installed, so paste it into the PR yourself. Open the PR from <https://github.com/giorgosroussos/str-host/compare/main...impl/wave-1>.

**Status:** Ready for review · **PR:** not opened yet (see link above) · **Tag:** [wave-1](https://github.com/giorgosroussos/str-host/releases/tag/wave-1) · **Commit:** [66fd395](https://github.com/giorgosroussos/str-host/commit/66fd395) · **Date:** 2026-10-09

## Summary

The repository is no longer documentation only. It now has a working Laravel 13 application (Fortify, Inertia, Vue 3 in TypeScript, Tailwind 4, PrimeVue 4) with a placeholder home page, a local PostgreSQL 16 database and a local mail inbox (Mailpit). Every `make` target is real, and `make clean-start` proves a fresh clone boots, passes every gate and tears down cleanly. There are no product features yet: no login, no pages beyond the placeholder. Review found no critical or high problems. Two medium findings (generated cache files tracked in Git, development mail not going to a mail trap) were fixed and re-verified.

| | |
|---|---|
| Delivered | 1 of 1 planned task ([FND-01](../.impl/tasks/FND-01.md)) |
| Tests | all passing (13 feature/unit tests, 2 browser tests with accessibility checks) · build passing · lint, formatting and type checks passing · `make check-docs` 0 failures · dependency audit and secret scan clean |
| Needs your decision | **0 open questions**; 1 action for you (open and merge the PR) |
| Deviations from approved design | None. One spec gap was found and answered (Q-098, below) |
| Owner interventions | **7** across 1 package (7.0 per package) · surfaces: data x1 (Q-098); the rest are approvals and ceremonies, no design surface (see Changes to note) |

## Needs your decision

No open question blocks wave 2. One thing needs you:

**1. Open and merge the PR**
- Affects: everything in this wave. Wave 2 ([FND-02](../.impl/tasks/FND-02.md)) starts from the merged result.
- Do: open <https://github.com/giorgosroussos/str-host/compare/main...impl/wave-1>, paste this report as the description, then merge.
- Note: nothing on the server enforces the document locks until FND-02 adds the CI check, so this merge is not protected by CI yet.

## How to test

### Setup (once)
1. `git fetch && git checkout impl/wave-1`
2. The machine's default Node is v12; the project needs Node 22: `nvm use` (reads [.nvmrc](https://github.com/giorgosroussos/str-host/blob/wave-1/.nvmrc)). Docker must be running.
3. `make setup && make infra-up && make migrate`
4. Ports (changeable in `.env`): app http://127.0.0.1:8000, Mailpit inbox http://127.0.0.1:58025, database 127.0.0.1:54316.
5. There are no accounts yet; nothing to log in to.

### Scenarios

**S1. A fresh clone proves itself** · **Must test** · [specs/15 FND-01](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/15-implementation-plan.md) · [specs/12](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/12-testing-acceptance.md)
- Steps: 1. `nvm use`. 2. `make clean-start`.
- Expected: it clones the project into a temporary folder on free ports, runs setup, database, migrations, all gates, the app and the smoke check, then removes everything. Exit code 0 (`echo $?`), and `docker ps` shows no leftover containers.

**S2. All quality gates pass** · **Must test** · [specs/12 §2](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/12-testing-acceptance.md)
- Given: setup steps above done.
- Steps: `make verify`
- Expected: lint, format check, type check, 13 tests, 2 browser tests, build and `check-docs` all pass; ends with exit 0. (It builds the front end twice; known and harmless.)

**S3. The app runs and shows the placeholder page** · **Must test** · [specs/02 §1, §4](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/02-architecture.md)
- Steps: 1. `make dev`. 2. Open http://127.0.0.1:8000. 3. Open http://127.0.0.1:8000/up.
- Expected: the home page shows the application name, a tagline and an "FND-01" tag. `/up` shows `{"status":"up","database":"up"}`.

**S4. Smoke check, including the mail trap** · **Must test** · [specs/11 §1](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/11-infrastructure-operations.md)
- Given: `make dev` running in another terminal.
- Steps: 1. `make smoke`. 2. Open the Mailpit inbox http://127.0.0.1:58025.
- Expected: smoke reports each check ok, including "mail sent by the application landed in the mail trap", and the inbox shows that test message. Nothing is sent to real recipients.

**S5. Unhappy path: database down** · [specs/02 §4](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/02-architecture.md)
- Steps: with `make dev` running, `docker compose stop postgres`, then open /up.
- Expected: a 503 with no error detail. Restart with `make infra-up`.

**S6. Unhappy path: mail trap down is detected** · [specs/11 §1](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/11-infrastructure-operations.md)
- Steps: `docker compose stop mailpit`, then `make smoke`.
- Expected: smoke fails with "could not send through 127.0.0.1:51025" and a non-zero exit.

**S7. Nothing else is exposed** · [specs/02 §5](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/02-architecture.md)
- Steps: open /login, /register, /forgot-password, /app, /owner, /storage/x, /telescope and /.env.
- Expected: every one is a 404 (logins arrive with ACC-03). The page loads nothing from outside your machine (no external fonts or scripts).

**S8. Safety checks** · [specs/12 §2](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/12-testing-acceptance.md)
- Steps: `make audit` then `make scan-secrets`.
- Expected: no known advisories in dependencies; no secrets found in tracked files.

### Report a problem
Reply with the scenario number and what you saw, e.g. "S4: smoke fails at the mail step". It goes back to the right task.

## What shipped

| Feature | What you can do now | Spec | Task |
|---|---|---|---|
| Command contract | Every `make` target works (setup, infra, migrate, dev, test, lint, format, typecheck, build, verify, smoke, audit, scan-secrets, clean-start) | [specs/15 §3](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/15-implementation-plan.md) | [FND-01](../.impl/tasks/FND-01.md) |
| Application scaffold | Laravel 13 app with the folder layout of the architecture spec and a placeholder home page | [specs/02 §1-§2](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/02-architecture.md) | [FND-01](../.impl/tasks/FND-01.md) |
| Local infrastructure | PostgreSQL 16 and a Mailpit mail inbox via Docker, on loopback only | [specs/11 §1](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/11-infrastructure-operations.md) | [FND-01](../.impl/tasks/FND-01.md) |
| Health probe | `/up` checks the database and reports 503 without detail when it is down | [specs/02 §4](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/02-architecture.md) | [FND-01](../.impl/tasks/FND-01.md) |
| Fresh-clone proof | `make clean-start` builds a clean copy and tears it down | [specs/15 §3](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/15-implementation-plan.md) | [FND-01](../.impl/tasks/FND-01.md) |

## Changes to note

- **Decisions you made during the wave** (see [decisions-log.md](../.impl/decisions-log.md)):
  - Roadmap approved; lanes split by area (staff pages by area folder; guest, cleaner and owner views separate); 20 waves.
  - OUT-02 adds the migration for the per-reservation guest-link hash.
  - FND-02 adds a CI job that checks the locks over a commit range, through a new make target. This changes the target list, so FND-02 must land a [DECISIONS.md](https://github.com/giorgosroussos/str-host/blob/wave-1/DECISIONS.md) entry for it.
  - Wave 1 approved; agents may commit and push on `impl/*` branches, one PR per wave.
  - [Q-098](https://github.com/giorgosroussos/str-host/blob/wave-1/QUESTIONS.md) (framework tables vs the UUID key rule): answered B. Approved ADR [D-046](https://github.com/giorgosroussos/str-host/blob/wave-1/DECISIONS.md), which amends [specs/03 §1](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/03-domain-model.md) and [specs/14 §1](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/14-decision-register.md). Two `make unlock` ceremonies were recorded in [UNLOCKS.md](https://github.com/giorgosroussos/str-host/blob/wave-1/UNLOCKS.md). Tip for future runs: the first unlock attempt failed because a `!` prefix in a plain bash shell negated `cd`, so `&&` skipped `make`; run it without the prefix.
- **Technical choices logged by workers** (for code review): [D-042](https://github.com/giorgosroussos/str-host/blob/wave-1/DECISIONS.md) Pest 4 plugins, separate test database; [D-043](https://github.com/giorgosroussos/str-host/blob/wave-1/DECISIONS.md) gitleaks pinned by digest and strict audit; [D-044](https://github.com/giorgosroussos/str-host/blob/wave-1/DECISIONS.md) Compose project, ports and the Mailpit trap; [D-045](https://github.com/giorgosroussos/str-host/blob/wave-1/DECISIONS.md) own `/up` probe, Fortify inert, storage route and Inertia DevTools off.
- **Integration:** 0 fast path · 1 integrator (slow path; only conflict was the task file's Log). Verification: [round 1](../.impl/tasks/FND-01.md) PASS with 2 medium notes, fixed; [round 2](../.impl/tasks/FND-01.md) PASS.
- **File surfaces, declared vs actual:** FND-01: all 97 changed paths inside the approved surface (verifier check, both rounds); `Touches sensitive code`/red line declared yes, deep review run. `surface-check.py` itself crashed on this pack (`check_docs` has no `file_surfaces`; the pack is on an older layout), so the check was done by hand.
- **Pack gaps found:** one. [Q-098](https://github.com/giorgosroussos/str-host/blob/wave-1/QUESTIONS.md), surface data: [specs/03 §1](https://github.com/giorgosroussos/str-host/blob/wave-1/specs/03-domain-model.md) was silent on whether framework tables (migrations, queue, cache, sessions) follow the UUID rule. Now resolved.
- **Contract changes:** none outside the pack's own D-037 scheme (schema and page props begin here).
- **Integration fixes:** none.
- **New follow-up tasks (all low, none scheduled yet):** Mailpit hardening (`MP_DISABLE_VERSION_CHECK=1`, `MP_BLOCK_REMOTE_CSS_AND_FONTS=1`); rate-limit `/up`; set `SESSION_SECURE_COOKIE` for production; `make verify` builds twice; add a Greek and English-fallback test ([FND-03](../.impl/tasks/FND-03.md) owns i18n); fix imprecise Makefile help text for lint and typecheck; Home and health controllers sit at the controllers root (move at FND-03 or OUT-*). Known gap [G-002](https://github.com/giorgosroussos/str-host/blob/wave-1/GAPS.md): queue tables and worker arrive with the first queued work.

## Next wave (2): proposal

| Task | Delivers | Runs in parallel | Changed since roadmap? |
|---|---|---|---|
| [FND-02](../.impl/tasks/FND-02.md) | CI pipeline running the gates on the remote, plus the commit-range lock check | alone | adds the lock-check make target and a DECISIONS.md entry (your ruling above) |

## What to do now

1. Run at least the **Must test** scenarios (S1 to S4).
2. Open and merge the PR.
3. Clear the session and say **"continue implementation"**.

<details>
<summary>Reference: verification details, commits, files changed</summary>

- Verification: [FND-01 round 1](../.impl/tasks/FND-01.md) · [round 2](../.impl/tasks/FND-01.md)
- Commits: [66fd395](https://github.com/giorgosroussos/str-host/commit/66fd395) FND-01: land · [8f25c55](https://github.com/giorgosroussos/str-host/commit/8f25c55) integrated · [5880b77](https://github.com/giorgosroussos/str-host/commit/5880b77) integrate into wave 1 · [26587e5](https://github.com/giorgosroussos/str-host/commit/26587e5) wave 1 record · [c777e10](https://github.com/giorgosroussos/str-host/commit/c777e10) landing block · [71bff28](https://github.com/giorgosroussos/str-host/commit/71bff28) mail trap, cache ignored, real asset tests · [9b8e124](https://github.com/giorgosroussos/str-host/commit/9b8e124) · [afd3e3a](https://github.com/giorgosroussos/str-host/commit/afd3e3a) · [fd0eaca](https://github.com/giorgosroussos/str-host/commit/fd0eaca) scaffold
- Files changed: see [PR files](https://github.com/giorgosroussos/str-host/compare/main...impl/wave-1)

</details>
