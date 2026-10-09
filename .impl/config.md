# Orchestrator config

mode: design-pack (fallback, pre-W10 pack)

Pack generation: pre-W10. `make help` has no `brief` or `land`; `python3 scripts/check-docs.py --task all` prints only `Surfaces`, `Touches red line`, `Contract change` and live `blocked-by` (no `File surface:`, `Lane:`, `Depends on:`). File surfaces, lanes and within-phase order are orchestrator proposals that need owner approval (`.impl/roadmap-proposal.md`). Migrating the pack to W10/W11 would remove that burden.

## Documents

| What | Path |
|---|---|
| Working contract (wins over the orchestrator) | `AGENTS.md` (+ `CLAUDE.md` for commit rules) |
| Specs (frozen baseline 1.0, hard-locked) | `specs/` — plan: `specs/15-implementation-plan.md`; agent playbook `specs/16-agent-playbook.md` |
| Living documents | `PLAN.md`, `GAPS.md`, `TRACEABILITY.md` (free); `DECISIONS.md`, `QUESTIONS.md` (projections of `.log/events.jsonl`; never hand-edited) |
| Event log | `.log/events.jsonl` via `scripts/log-append.py` + `make rebuild-decisions` / `make rebuild-questions` |
| Inputs | `docs/inputs/README.md`, `docs/inputs/requirements/base-plan.md` (hard-locked) |
| Session prompts | `SESSION_BOOTSTRAP_PROMPT_SAMPLE.md` (Prompt 1 lines 9–46, Prompt 2 lines 48–64, Prompt 3 lines 66–79) |
| Locks | `.doc-locks`, `UNLOCKS.md`, `.githooks/` (`core.hooksPath` = `.githooks`, verified 2026-10-09) |

## Stack (`specs/02-architecture.md` §2, D-006)

Laravel 13 on PHP 8.3 with Fortify; PostgreSQL 16; Inertia + Vue 3 (TypeScript), Tailwind 4, PrimeVue 4; Pest on real PostgreSQL (never SQLite); Larastan level 6, Pint, vue-tsc, ESLint, Prettier; Docker Compose locally; database queue + Laravel scheduler.

## Commands

```
TEST_CMD="make verify"   # lint + format-check + typecheck + test + test-browser + build + check-docs
LINT_CMD=""
BUILD_CMD=""
```

Until FND-01 lands, every target except `check-docs`, `check-locks`, `verify-chain`, `rebuild-*`, `install-hooks`, `unlock` fails with "not implemented yet. Delivered by work package FND-01" by design. FND-01 therefore runs alone as Wave 1. `make test` / `make smoke` need `make infra-up` first.

## Git

- base branch: `main`
- delivery: `pr` (one PR per wave) — note: `gh` CLI is not installed on this machine; PR creation/edit needs it installed or the owner opens the PR by hand
- remote: `origin` = `git@github.com:giorgosroussos/str-host.git`
- wave branch `impl/wave-N`, package branches `impl/<PACKAGE>`
- commit messages follow `CLAUDE.md`: title `TASK-ID: outcome`, body grouped by area, ending with a `Verification:` line; **no AI attribution** (CLAUDE.md overrides the default co-author trailer)
- commits/pushes only within an owner-approved wave (CLAUDE.md: "Never commit or push unless asked")

## Parallelism

max parallel: 3 (PLAN.md keeps 1–3 `Now` items; `check-docs` rule `now-items` enforces it)

## Models

| Role | Model |
|---|---|
| Spec reviewer | opus |
| Worker | opus |
| Verifier | opus |
| Integrator | opus |
| Next-wave planner | opus |
| Reporter | sonnet |
| Lander (fallback, pre-W11) | sonnet |

## Worker brief (fallback)

Prompt 1 of `SESSION_BOOTSTRAP_PROMPT_SAMPLE.md` (`## 1. Default: implement the current Now item`, the fenced block at lines 11–46), with these overrides appended:
1. Your package is `<PACKAGE>` (the `Now` item on your branch); branch `impl/<PACKAGE>`, worktree `<path>`; commit on your branch.
2. Stay inside the approved file surface in `.impl/tasks/<PACKAGE>.md`; stop and report `BLOCKED` if you need any other file.
3. Do NOT write `.log/events.jsonl`, `DECISIONS.md`, `QUESTIONS.md`, `PLAN.md`, `GAPS.md`, `TRACEABILITY.md` or `AGENTS.md`, and never run `make unlock`. Instead return a `LANDING` block: events with placeholder IDs (D-NEW-1…, Q-NEW-1…), TRACEABILITY row + evidence, GAPS changes, PLAN.md change, spec amendments (exact old → new text).
4. Stop on any question that materially changes data, security, scope, external commitments or UX (Prompt 1's own rule) and return it as a decision card instead of writing QUESTIONS.md.
5. Overrides Prompt 1's "Do not commit unless asked" (commit on your branch) and its "Record as you go" list (goes to LANDING instead).

Prompt 2 (review) runs in the verifier for every package the `AGENTS.md` "Prompt selection" table selects (all except RES-03, MON-06, OPS-04). Prompt 3 runs at wave approval only if `blocked-by` is non-empty.
