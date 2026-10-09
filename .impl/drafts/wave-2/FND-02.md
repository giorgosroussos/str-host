# FND-02 worker prompt (wave 2, draft)

Status: draft. It is sent only after the owner approves wave 2 and answers (or accepts the recommendations of) the open questions in `summary.md`. The placeholders in `<angle brackets>` are filled in at dispatch: worktree path, and the outcome of Q1–Q5.

Shape: Prompt 1 of `SESSION_BOOTSTRAP_PROMPT_SAMPLE.md` (lines 11–46, verbatim below), followed by the fallback overrides of `.impl/config.md` "Worker brief (fallback)" and the wave-1 additions. Model: opus. Isolation: worktree.

---

```text
Implement the current `Now` item in PLAN.md using AGENTS.md as the working contract.

Before changing anything, read AGENTS.md, PLAN.md, QUESTIONS.md, GAPS.md and TRACEABILITY.md,
then the DECISIONS.md index and the D-entries the `Now` item cites, then specs/README.md,
specs/14-decision-register.md and every spec section the `Now` item references.
Inspect existing code and tests before editing. Restate your assumptions and flag any conflict
with a locked decision before you start.

Work in the smallest vertical slice that produces the item's observable outcome. Add or update
tests in the same change, including tenant/owner isolation cases where a resource is owned.
Update the shared type definitions whenever a contract changes.

Record as you go, in the smallest relevant document:
- judgement calls and tooling choices as a `decision-added` event (`scripts/log-append.py`,
  dated, with alternatives) followed by `make rebuild-decisions`; never by editing DECISIONS.md;
- deliberate incompleteness in GAPS.md, never hidden behind a stub;
- anything the specs cannot answer in QUESTIONS.md as a decision card, with spec reference,
  options and their consequences;
- verification evidence (commands run, test names) in TRACEABILITY.md.

Spec text may be amended only where AGENTS.md allows it and only with a `spec-amendment`
event appended to the log, and DECISIONS.md rebuilt, in the same change. Never touch a locked decision or a red line without
an approved ADR. Never invent requirements, weaken tests, or mark work done from file presence.

Continue until every acceptance condition of the `Now` item is demonstrably satisfied,
`make verify` passes from a documented starting state, `make check-docs` passes, PLAN.md
accurately describes the remaining work with the completed item removed, and no blocker is
concealed. If a specification ambiguity materially changes data, security, scope, external
commitments or UX, write it as a card in QUESTIONS.md and pause only if proceeding would make
a costly or irreversible assumption. Otherwise state the assumption, tag it, and continue.

Finish with a handoff: behaviour changed, commands run and their results, migration and
rollback notes, security and privacy considerations, follow-ups not implemented.
Do not commit unless asked. Commit messages carry no AI attribution.
```

## Overrides for this session (they win over the prompt above where they conflict)

1. **Package and branch.** Your package is `FND-02 — CI baseline`, the `Now` item of PLAN.md. Worktree `<worktree path>`. Start with:
   ```bash
   git fetch origin
   git checkout -b impl/FND-02 origin/impl/wave-2
   python3 scripts/lock-guard.py --relock
   git config core.hooksPath   # must print .githooks; if not, run `make install-hooks`
   ```
   Commit on `impl/FND-02` and push it to `origin`. Never push to `main` or `impl/wave-2`, and never force-push.
2. **File surface** (approved 2026-10-09 in `.impl/tasks/FND-02.md`, extended by the owner rulings recorded in `.impl/decisions-log.md`). You own:
   - `.github/workflows/**` and any other `.github/**` file the pipeline needs (no `CODEOWNERS`, no Dependabot config unless Q3 says so);
   - `scripts/ci/**` (new helpers);
   - `README.md`, the "Continuous integration" section only<, plus the stale "Status" paragraph if Q5 = yes>;
   - `Makefile`: (a) the new lock-range target (owner ruling 2026-10-09); <(b) the tripwire target if Q1 = A>; <(c) the `test-browser`/`build` double build if Q5 = yes>; (d) a CI-friendly flag on an existing target if a job needs one. No other target body changes, no target removed or renamed (D-001).
   - `.impl/tasks/FND-02.md` (Log lines only), `.impl/inbox/FND-02.md`, `.impl/landing/FND-02.md`.

   Never: `specs/**`, `docs/inputs/**`, `.doc-locks`, `.githooks/**`, `scripts/lock-guard.py`, `scripts/unlock.sh`, `.log/**`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md`, `AGENTS.md`, `docker-compose.yml`, `.env.example`, `phpunit.xml`, application code and tests. If you need any other file, stop and report `BLOCKED: <file> — <why>`.
3. **Records go to LANDING, not to the documents.** Do NOT write `.log/events.jsonl`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md` or `AGENTS.md`, and never run `make unlock`. Write a `LANDING` block to `.impl/landing/FND-02.md` and commit it on your branch. It holds, in this order: events with placeholder IDs (`D-NEW-1…`, `Q-NEW-1…`) as ready-to-run `scripts/log-append.py` commands (follow the shape of the FND-01 landing, `git show c777e10:.impl/landing/FND-01.md`); the TRACEABILITY FND-02 row with evidence; GAPS changes; the PLAN.md change; the AGENTS.md change (exact old → new text); spec amendments, if any (exact old → new; there should be none). Dry-run it: apply it with real next-free IDs to a scratch copy of your branch (`log-append.py --root <scratch>`, both rebuilds, the document edits) and show `python3 scripts/check-docs.py` at 0 failures there. Say in the block which IDs you dry-ran with.
4. **Stop on material questions.** A question that materially changes data, security, scope, external commitments or UX goes back as a decision card (spec reference, options with consequences, recommendation, what it blocks) in your report and in `.impl/inbox/FND-02.md`, never into QUESTIONS.md.
5. These overrides replace Prompt 1's "Do not commit unless asked" (commit on your branch) and its "Record as you go" list (it goes to LANDING). Commit messages follow `CLAUDE.md`: title `FND-02: outcome`, body grouped by area, a closing `Verification:` line, **no AI attribution and no co-author trailer**.
6. **Toolchain.** The host's default Node is v12. Run `nvm use` (the repository pins Node 22 in `.nvmrc`) or put Node 22 first on `PATH` before any `make` target that runs Node. PHP 8.3, Composer, Docker and Python 3 are on the host. `gh` is NOT installed: don't install it and don't try to open PRs.
7. **Ports.** Other worktrees may be running their own stacks. Before `make infra-up` export free ports for this worktree, e.g. `DB_PORT=54392 MAIL_PORT=51392 MAILPIT_UI_PORT=58392 APP_PORT=8392 VITE_PORT=5392 APP_URL=http://127.0.0.1:8392`, and tear your stack down (`make infra-down`, remove your volume) before you finish. `make clean-start` picks its own free ports.

## What FND-02 must deliver

Acceptance, word for word from `specs/15-implementation-plan.md` §3 FND-02 (the contract), with the PLAN.md `Now` acceptance and the owner ruling:

- AC1: A pipeline on the project's remote, running on every merge request and every push to the default branch, against PostgreSQL 16 as a service, never a lighter substitute (`12` §1).
- AC2: Every job runs exactly one `Makefile` target, so "CI is green" and "`make verify` is green" are the same statement; `README.md` maps job to command.
- AC3: `make check-docs` runs as its own job.
- AC4: Every gate the testing specification requires but nothing implements yet is a failing-forward tripwire: a job that passes only while the gate is provably absent and fails with promotion instructions the moment it becomes runnable. A missing gate and a silently passing gate must never look alike.
- AC5: Dependency and secret scanning; artifact and cache strategy; no job retries.
- AC6 (owner ruling 2026-10-09): a CI job runs the lock check over the commit range of the merge request or push, through a new `make` target. The target list changes, so the LANDING carries a `decision-added` event for it and the AGENTS.md "Commands" edit.
- AC7 (FND-01 follow-ups, PLAN.md): Node 22 pinned on the runner from `.nvmrc`; Playwright system dependencies installed on the runner so `make test-browser` runs there.
- `make verify` and `make check-docs` exit 0 on your branch.

Read before you design: `AGENTS.md` "Commands" (line 68: `check-docs` asserts every listed target exists in the Makefile) and the CI paragraph (line 100); `specs/12-testing-acceptance.md` §1–§7 (the gates and what they cover); `specs/15-implementation-plan.md` §3 (Phase 0 exit criteria); `specs/09-ux-journeys-emails.md` §9 (accessibility gate); D-001, D-006, D-036, D-041, D-042, D-043, D-044 in DECISIONS.md; `.githooks/pre-receive` and `.githooks/README.md`; the header of `scripts/lock-guard.py`; `Makefile`; `scripts/toolchain.sh`, `scripts/clean-start.sh`; `docker-compose.yml` and `phpunit.xml` (database name, credentials).

### Design points to settle (record each choice with alternatives as a `decision-added` event in LANDING)

1. **Remote.** `origin` is github.com (`giorgosroussos/str-host`, public): GitHub Actions under `.github/workflows/`. Triggers: `pull_request` (every base branch) and `push` to `main`<; plus `push` to `impl/**` if Q2 = B>. Never `pull_request_target`. Top-level `permissions: contents: read`. Pin every third-party action by full commit SHA with the version in a comment. `concurrency` that cancels superseded PR runs is fine; cancelling is not a retry.
2. **One target per job.** Each job's gate step is exactly one `make <target>`. Preparation (checkout, PHP 8.3 with `pdo_pgsql`, Node from `.nvmrc` via `node-version-file`, caches, `make setup` or the parts of it the job needs) precedes it. If preparation itself needs a `make` call other than `make setup`, or `make setup` needs a CI flag (for example to install Playwright with `--with-deps`, or to skip browsers in jobs that don't use them), that is the "CI-friendly flag" the surface allows. State this reading of AC2 in a decision and in the README map. Proposed jobs: `check-docs`, the lock-range job, `lint`, `format-check`, `typecheck`, `test`, `test-browser`, `build`, `audit`, `scan-secrets`, and the tripwire job(s). `make verify` is not a job (it is the sum of the others). Whether `make clean-start` runs in CI (it repeats every gate and needs Docker Compose) is your call: record it.
3. **PostgreSQL 16 as a service** for `test` and `test-browser` (and any job that touches the database): `postgres:16` (pin by digest, as D-043/D-044 do for images), a health check, a database matching what `phpunit.xml` forces (`str_host_test`) and the `.env.example` credentials, `DB_PORT` passed through the job environment. `tests/Feature/DatabaseEngineTest.php` must pass on the runner, proving pgsql 16 there too. No SQLite anywhere.
4. **Mailpit.** Only if a job needs it. `make test` and `make test-browser` should not; `make smoke` (inside `clean-start`) does. Don't add it otherwise.
5. **Lock check over a range (AC6).** New target, proposed `check-locks-range` with `FROM=<rev>` and `TO=<rev>` (default `TO=HEAD`; never name a make variable `PATH` or `HEAD`). It must judge the change exactly as the remote hook would: the manifest and the guard come from the base revision, not from the change, and the pushed manifest is passed as `--new-manifest`. The cheapest way to guarantee that is to feed `"<FROM> <TO> refs/ci"` to `.githooks/pre-receive` (you may run it; you may not edit it). In CI: for `pull_request`, FROM = merge base of the PR head with the base branch; for `push`, FROM = `github.event.before`, with an explicit rule for a new ref (all zeros) and for a `before` that is no longer in history (force push). Checkout with `fetch-depth: 0`. Evidence: exit 0 over the wave-1 range (`origin/main..origin/impl/wave-1`, which contains `make unlock` records for `specs/03` and `specs/14`); a non-zero exit with the guard's message over a throwaway commit in a scratch clone that edits a hard-locked file without an unlock record (commit there with `--no-verify`; never push it). State in the LANDING decision the honest limit: on `pull_request`, GitHub runs the workflow file from the PR head, so a PR can edit its own CI; the base-revision guard and branch protection are what hold (see Q3).
6. **Tripwires (AC4).** List every gate of `12` §1–§6 and `09` §9 and decide for each: real now, or a tripwire. Expected tripwires at least: the accessibility gate FND-03 promotes (`09` §9, `15` §3 FND-03)<, with the absence predicate chosen in Q4>; the isolation suite (`12` §3, ACC-01); the money golden tests (`12` §5, MON-01); the outside-view leak tests (`12` §4, OUT-*); the critical journeys (`12` §6). Each tripwire: (a) a predicate that proves absence mechanically (e.g. no test in the named directory or group), not a comment; (b) passes while absent; (c) fails the moment the gate becomes runnable, printing what to do: which job to add or turn real, which file to edit, which package owns it; (d) a test or a demonstration that it flips (create the artifact in a scratch copy, show the failure text, remove it). Runs through one make target per job<; target name per Q1>. Logic lives in `scripts/ci/`.
7. **Dependency and secret scanning (AC5).** `make audit` and `make scan-secrets` as their own jobs (D-043: gitleaks by digest under Docker, which the runner has). No third-party scanning service (D-043, `02` §5). GitHub's own repository settings are owner actions, not your work.
8. **Artifacts and caches (AC5).** Composer cache keyed on `composer.lock`, npm via `setup-node` keyed on `package-lock.json`, Playwright browsers keyed on the installed Playwright version; on failure only, upload what a human needs to diagnose (`storage/logs`, browser screenshots), with short retention, never `.env` or `vendor/`. Record the strategy.
9. **No retries.** No retry action, no `continue-on-error`, no test-runner rerun flags, no `|| true` around a gate. Add a check (for example in `scripts/ci/`, run by the tripwire or a lint step) that fails if a workflow gains any of these, or state why a review rule is enough.
10. **README.** Replace the placeholder "Continuous integration" section with a job → command table (job name exactly as GitHub shows it, the one `make` target, trigger, services), the tripwires and their promotion owners, and how to reproduce each job locally.

### Out of scope (don't do)

Branch protection, required checks, repository settings, secrets, Dependabot or GitHub secret scanning switches (owner actions); `.githooks/**` or its README; Mailpit hardening flags and `docker-compose.yml`; `/up` throttling and session cookie settings (OPS-03); moving `HomeController`/`HealthController` and the `el` fallback test (FND-03); any product code.

### Evidence you must bring back

- `make verify` and `make check-docs` exit 0 on your final commit (counts as in the FND-01 row).
- `make check-locks-range` over the wave-1 range: exit 0; over the scratch violation: non-zero with the guard's message.
- Each tripwire: green while absent, and its failing output when the artifact is planted in a scratch copy.
- Workflow syntax: `actionlint` via its container image pinned by digest (or equivalent), clean.
- The remote run: push `impl/FND-02`; <per Q2: the owner opens a draft PR `impl/FND-02 → impl/wave-2` / the `impl/**` push trigger fires>. Read run and job conclusions from the public API (`curl -s https://api.github.com/repos/giorgosroussos/str-host/actions/runs?branch=impl/FND-02`), quote the run ID and each job's conclusion. If no run is visible, say so and leave AC1 as "unverified on the remote" in TRACEABILITY: never mark it done from file presence.
- Your stack torn down; `git status` clean.

### LANDING contents expected

- `decision-added` events: the new lock-range target (target list change, D-001; alternatives: a script run directly by the job, a pre-receive hook, which github.com can't host); <the tripwire target if Q1 = A>; the CI platform and trigger design; the one-target-per-job reading and job list; the PostgreSQL service; caches and artifacts; the tripwire set and absence predicates; the no-retry rule.
- AGENTS.md: "Commands" block gains the new target(s) with a one-line comment; the CI paragraph (line 100) names the lock-range job and the tripwire job. Exact old → new.
- TRACEABILITY: FND-02 row with evidence (only what ran and passed; remote run ID if seen).
- GAPS: G-001 narrowed (CI exists); a new gap for "a red pipeline blocks a merge" until the owner turns on branch protection (closed by owner evidence, plan item FND-02 / Phase 0 exit); one row per tripwire is not needed if README lists them, but say which.
- PLAN.md: FND-02 out of `Now`; `Now` = FND-03 with its acceptance including the promotion of the accessibility tripwire; `Next` = ACC-01, ACC-02.
- Owner steps (not events): branch protection on `main` with the exact job names to require; Actions settings.

Finish with the handoff Prompt 1 asks for, the commit SHAs, and `LANDING: .impl/landing/FND-02.md @ <sha>`.
