# STR Host

A multi-tenant back-office for short-term rentals in Greece: properties, owners, reservations, turnovers and the owner's monthly statement and payout in one place. Not a channel manager, booking engine, accounting software or guest messaging tool.

Status: **documentation pack complete, Phase 0 not started.** No code exists yet. The first work package is the command contract (FND-01, `PLAN.md`). Until it lands, every `make` target except `make check-docs` fails with a message naming the package that delivers it.

```bash
make check-docs   # the only target that runs today
make help         # the full command contract
```

- Agents and contributors start at `AGENTS.md`. Ready-made session prompts: `SESSION_BOOTSTRAP_PROMPT_SAMPLE.md`.
- Specifications: `specs/README.md` (map, requirement language, conflict resolution).
- Raw requirements and their authority: `docs/inputs/README.md`.
- Current work, decisions, gaps, open questions and evidence: `PLAN.md`, `DECISIONS.md`, `GAPS.md`, `QUESTIONS.md`, `TRACEABILITY.md`.

## Continuous integration

Added by FND-02 (`specs/15-implementation-plan.md` §3). Every job will run exactly one `Makefile` target and this section will map job to command.

Stack: Laravel 13 (PHP 8.3), PostgreSQL 16, Inertia + Vue 3 (TypeScript), Tailwind 4, PrimeVue 4, Fortify, Pest, Docker Compose.
