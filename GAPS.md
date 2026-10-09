# GAPS

Deliberate incompleteness and missing infrastructure. A gap is closed only by evidence, never by a stub. Each row names the evidence that closes it and the plan item that produces it. IDs are never reused: a closed gap's row is removed and its ID retired. `make check-docs` verifies that every cited work package and phase exists.

| ID | Gap | Consequence | Evidence to close | Plan item |
| --- | --- | --- | --- | --- |
| G-001 | The command contract and scaffold exist (FND-01), but there is no CI and no domain code. Every work package after FND-01 in `specs/15-implementation-plan.md` is unstarted. | No gate runs on the remote, and no product requirement is verifiable yet. | Per-package rows in `TRACEABILITY.md` moving to `done` with command and test evidence. | FND-02, then Phase 0 onward |
| G-002 | The database queue tables (jobs, failed_jobs, job_batches) are not migrated, and `make dev` runs no queue worker. Q-098 is answered (B, D-046): the tables ship with their stock schema when the first package queues work. | Nothing can be queued yet; a dispatch on the `database` connection fails loudly. | Queue migration and a `queue:work` process in `make dev`, plus a test that dispatches a job on PostgreSQL. | ACC-02 |
