# Decisions log

Rulings made during implementation by the owner or the orchestrator (pack decisions live in `DECISIONS.md`, never here). Newest last.

| Date | Wave | Ruling | By | Affects |
|---|---|---|---|---|
| 2026-10-09 | roadmap | Roadmap approved as proposed in `.impl/roadmap-proposal.md`, including the proposed file surfaces and within-phase orders. | owner | all |
| 2026-10-09 | roadmap | Lanes split by area: staff pages by area folder; guest, cleaner and owner views are three separate lanes (20 waves). | owner | waves.md |
| 2026-10-09 | roadmap | OUT-02 adds the migration for the per-reservation guest-link hash (`10` §2), even though the plan marks it "Contract change: no". | owner | OUT-02 |
| 2026-10-09 | roadmap | FND-02 adds a CI job that checks the locks over a commit range, through a new make target. The target list changes, so FND-02 must land a DECISIONS.md entry via the event log. | owner | FND-02 |
| 2026-10-09 | wave 1 | Wave 1 (FND-01 alone) approved. Agents may commit and push on `impl/*` branches; one PR per wave into main. | owner | FND-01 |
