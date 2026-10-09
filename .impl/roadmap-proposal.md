# Roadmap proposal — for owner approval

The pack is pre-W10: `specs/15` gives no `File surface:`, `Lane:` or `Depends on:`. Everything in §2–§4 is the orchestrator's **proposal**, derived from `specs/15` §10, `specs/02` §1 and the sections each package cites. Nothing here changes a product decision. Approving the roadmap does not start a wave; Wave 1 is approved separately.

## 1. What you approve

1. The lanes and file surfaces (§2, details in each `.impl/tasks/<PACKAGE>.md`).
2. The contract-root and shared-file rules (§3).
3. The within-phase orders and the 20 waves (§4, `.impl/waves.md`).
4. The open points (§6) — answer or accept the default.
5. The flow conflicts with `AGENTS.md` and how they are handled (§5).

## 2. Lanes and file surfaces

Lanes from `specs/15` §10, refined by the `02` §1 layout. A vertical package has one **primary lane**; its staff pages live in its own `resources/js/Pages/Staff/<Area>/` folder, so the "Staff app pages" lane is partitioned by area folder (proposal A).

| Package | Lane | Owns (summary; exact globs in the task file) | Shared edits |
|---|---|---|---|
| FND-01 | infra | the whole scaffold, Makefile bodies, compose, lockfiles, tool configs | creates the contract root |
| FND-02 | infra | `.github/workflows/**`, README CI section | Makefile flags (root) |
| FND-03 | staff-ui | Components, Layouts, css, navigation registry, `lang/*/common.php`, a11y test | workflows + `test-browser` (root), Inertia shared props (root) |
| ACC-01 | domain:account | Account model, tenant scope, `tests/Isolation` harness, tenant middleware | `bootstrap/app.php` (root) |
| ACC-02 | domain:account | sign-up/approval actions, terms acceptance, operator-command base + approve command, account-active mail | Fortify config/provider (root) |
| ACC-03 | domain:login | Login roles, invitations, `app/Authorization/**` = whole 07 §2 matrix, 2FA, password reset, Settings pages | Fortify, Inertia props (root) |
| ACC-04 | domain:audit | AuditEntry, `app/Audit/**` recorder, Staff/Audit pages | — |
| PRP-01 | domain:owner-property | Owner, Property, OwnershipPeriod + Staff/{Owners,Properties} | nav registry |
| PRP-02 | domain:property-terms | PropertyTerms, account VAT migration, terms form, onboarding browser test | `Account` model |
| PRP-03 | domain:cleaner | Cleaner, `app/Support/LinkTokens/**`, Staff/Cleaners | nav registry |
| RES-01 | domain:reservation | Reservation + exclusion constraint, Staff/Reservations | nav registry |
| RES-02 | domain:reservation | money lines, ClimateFeeRate + operator command | RES-01's actions/pages |
| RES-03 | staff-ui | Staff/{Timeline,Calendar} (read-only) | Fortify `home` (root), nav |
| RES-04 | domain:turnover | Turnover, Staff/Turnovers, run-a-month browser test | RES-01's actions, nav |
| MON-01 | money | `app/Money/**`, `tests/Unit/Money/**` only | — |
| MON-02 | domain:expense | Expense, Receipt, private disk, Staff/Expenses | filesystems + composer (root), nav, run-a-month test |
| MON-03 | domain:statement | Statement, Payout, Staff/Statements incl. self-owned view | nav |
| MON-04 | domain:adjustment | Adjustment | finalise action; edit hooks in Reservations/MoneyLines/Expenses/Turnovers actions |
| MON-05 | domain:statement | PDF view (dompdf), queue jobs, statement mail, close-a-month browser test | finalise action, composer (root) |
| MON-06 | staff-ui | Staff/{Dashboard,CleanerPay} + queries (read-only) | nav |
| OUT-01 | outside:owner | `Controllers/Owner/**`, `Pages/Owner/**`, `routes/owner/*`, leak tests | — |
| OUT-02 | outside:guest | guest-link hash + issue action, `Guest/**`, map + PMTiles + refresh command | composer/package (root), reservation page |
| OUT-03 | outside:cleaner | shared link-token middleware, `Pages/Shared/InactiveLink.vue`, `Cleaner/**` | `bootstrap/app.php` (root) |
| OPS-01 | domain:retention | `app/Actions/Retention/**`, jobs | `routes/console.php` (registry) |
| OPS-02 | domain:account-lifecycle | lifecycle + data-request actions and operator commands | `routes/console.php` (registry) |
| OPS-03 | infra | `deploy/**`, `docker-compose.prod.yml`, backup scripts, restore runbook | Makefile `smoke` (root) |
| OPS-04 | infra | completes `tests/Browser/**` (seven journeys) | — |

Every package also owns its `tests/{Unit,Feature,Isolation}/<Area>/**`, `routes/staff/<area>.php`, `lang/{el,en}/<area>.php`, `resources/js/types/<area>.ts` and its own migration files (never an earlier package's). Every package is forbidden `specs/**`, `docs/inputs/**`, the lock layer, `.log/**` and all living documents (they go through the LANDING block).

## 3. Contract root, central policies, registries (proposed definitions)

The pack names "contract root" and "central policies" (`15` §1, §10; `AGENTS.md`) but never lists their files. Proposal:

- **Contract root:** `bootstrap/app.php`, `routes/web.php` + the per-surface loaders, `app/Providers/**`, `config/**`, `app/Http/Middleware/HandleInertiaRequests.php`, `resources/js/app.ts`, `resources/js/types/index.d.ts`, `composer.json/lock`, `package.json/lock`, `vite.config.ts`, `tsconfig.json`, tool configs, `phpunit.xml`, `tests/Pest.php`, `Makefile`, `docker-compose*.yml`, `.env.example`, `.github/workflows/**`. **At most one package per wave edits it.**
- **Central policies / global auth middleware:** `app/Authorization/**` and the tenant/surface guard middleware, owned by ACC-01/ACC-03. ACC-03 encodes the *whole* 07 §2 matrix up front (the spec gives every cell), so later packages add only `app/Policies/<Model>Policy.php` + cell tests. A later edit to the matrix counts as a central-policy edit: one per wave.
- **Append registries** (one line per area): `resources/js/navigation/staff.ts`, `routes/console.php`, `lang/{el,en}/common.php`. Proposed: two packages in one wave may each append; the integrator resolves the append conflict. Affects waves 8, 14 (nav) and 19 (`routes/console.php`). If you refuse this, those packages serialize (+3 waves).

Checked per wave: no wave has two root editors (8: none; 11: RES-03 only; 13: MON-02 only; 14: none; 17: OUT-03 only; 19: OPS-03 only).

## 4. Within-phase orders

Dependency type: **E** = explicit in the pack, **I** = my inference from cited sections, **S** = serialization over shared files only.

- **Phase 0:** FND-01 → FND-02 (E: PLAN.md Next) → FND-03 (E: "replacing its tripwire").
- **Phase 1:** ACC-01 → ACC-02 → ACC-03 → ACC-04, all serial. ACC-02/03 share the Login aggregate and Fortify config (I + 15 §10 "never parallelize migrations for the same aggregate"); ACC-04's admin view needs roles (I). Alternative none without splitting packages.
- **Phase 2:** (PRP-01 ∥ PRP-03) → PRP-02. PRP-02 needs properties (I); cleaners are their own aggregate (I).
- **Phase 3:** RES-01 alone (the phase's shared model, 15 §10) → (RES-02 ∥ RES-03) → RES-04. RES-02 → RES-04 is **S** (both edit reservation actions). Alternative: RES-04 ∥ RES-03 first, RES-02 after — same length.
- **Phase 4:** (MON-01 ∥ MON-02) → (MON-03 ∥ MON-06) → MON-04 → MON-05. MON-04 → MON-05 is **S** (both edit finalisation; the PDF should render adjustment lines).
- **Phase 5:** (OUT-01 ∥ OUT-03) → OUT-02. OUT-03 → OUT-02 is **S**: OUT-03 owns the shared link resolver and the generic inactive page (08 §4, D-032). Requires proposal A for the "Outside views" lane (three sub-lanes).
- **Phase 6:** (OPS-01 ∥ OPS-02 ∥ OPS-03) → OPS-04.

## 5. Conflicts between `AGENTS.md`/`CLAUDE.md` and the orchestrator flow (AGENTS.md wins)

1. **Who writes the record.** Prompt 1 and `AGENTS.md` make the implementing agent append events, rebuild projections and update PLAN/GAPS/TRACEABILITY in the same change. Fallback: workers return a LANDING block; a sonnet lander applies it on the wave branch one package at a time (one linear hash chain). Same content, different hand — please confirm.
2. **Commits.** `CLAUDE.md`: never commit/push unless asked; title `TASK-ID: outcome`, body by area, `Verification:` line, **no AI attribution**. Approving a wave = standing permission to commit/push on `impl/*` branches and open the PR. Orchestrator commits (`wave N: dispatch`) will be titled `<PACKAGE…>: wave N dispatch` to fit the format. No co-author trailer.
3. **PLAN.md `Now` and `check-docs`.** `now-items` requires 1–3 `Now` items, none `done`. Landing the last package of a wave must, in the same commit, move the next wave's packages into `Now` (or `check-docs` goes red). The orchestrator writes each wave's `Now` items itself at dispatch. Pre-W10 `check-docs` has no `Branch:`/lane/dependency wave checks, so the orchestrator checks waves by hand.
4. **Spec amendments.** `specs/**` is hard-locked (frozen 1.0); any amendment needs your `make unlock` in the wave worktree, one ceremony per package. Agents never run it.
5. **Server-side enforcement does not exist yet (confirmed).** No `.github/` directory, the remote is github.com (a `pre-receive` hook cannot be installed there), and `gh` is not installed. Locks are enforced only by the local pre-commit hook (`core.hooksPath` = `.githooks` ✓), which `--no-verify` bypasses. Until FND-02 adds a lock-guard job and you make CI a required check, treat locks as advisory on the remote.
6. **Review selection.** `AGENTS.md`'s table (not the W12 one): Prompt 2 runs for every package except RES-03, MON-06, OPS-04.

## 6. Open points (none blocks Wave 1)

1. **Lane interpretation (proposal A vs strict).** A: staff pages partitioned by area folder, outside views as three sub-lanes → 20 waves. Strict single lanes → 24 waves. *Default: A.*
2. **FND-02 lock job.** FND-02's text doesn't name a lock-guard CI job; without it the remote enforces nothing. Add it under FND-02? Each CI job must run exactly one `make` target and `check-locks` only checks a staged change, so this needs `check-locks` to accept a commit range (or a new target, which per the Makefile header needs a `DECISIONS.md` entry). Also you must set branch protection (a Phase 0 exit criterion). *Default: yes.*
3. **Guest-link storage (OUT-02).** 10 §2 requires a stored hash per reservation, but D-037 marks OUT-02 `Contract change: no`. *Default: OUT-02 adds the additive migration; the flag is just wrong (review runs anyway via `security`/`data`).* Alternative: RES-01 creates the column.
4. **Unowned bits, assigned by inference:** password reset → ACC-03; operator-command logging base → ACC-02; map refresh command → OUT-02; ACC-01's "first tenant model" → `Login`; where cleaners sit in the 09 §1 navigation → PRP-03 worker asks. *Default: accept.*
5. **Owner actions needed later:** GitHub branch protection (Phase 0 exit), install `gh` or open PRs by hand (delivery `pr`), EU VPS/domain/email provider for OPS-03, a real month for OPS-04's hand calculation, PO checkpoints after Phases 2, 3, 4, 6.
6. **Housekeeping:** the root `base-plan.md` (byte-identical to `docs/inputs/requirements/base-plan.md`) is now covered by an uncommitted `.gitignore` line `base-plan.md`. That pattern has no leading slash, so it also matches the tracked input file's name (harmless while tracked); prefer `/base-plan.md`, and commit or drop the `.gitignore` change before `impl/wave-1` branches from `main`.
7. **Pack migration.** Migrating to W10/W11 (`File surface:`, `Lane:`, `Depends on:`, `make brief`, `make land`) would remove §2–§4 from the orchestrator's hands. *Default: proceed in fallback.*

## 7. Blockers check (2026-10-09)

- `make check-docs`: exit 0; event log 334 records, chain intact.
- `QUESTIONS.md`: Blocking none, Open none. All 27 packages `blocked-by: —`.
- `GAPS.md`: one row, G-001 (nothing exists beyond the pack); it is closed by the packages themselves, not a blocker.
- Pack frozen: `specs/README.md` 1.0 baseline; `.doc-locks` ends with `hard-locked: specs/**`.
