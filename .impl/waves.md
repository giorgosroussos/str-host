# Waves

Proposed; pending owner approval (`.impl/roadmap-proposal.md`). Phases run in plan order (`specs/15` §2); a phase's first wave waits for the previous phase's exit criteria (copied word for word below) and, where `specs/16` §12 requires it, the Product Owner checkpoint. Width ≤ 3. One package per lane per wave. `serial` marks an order forced by shared files, not by the domain.

| Wave | Packages | Width | Phase | Gate before this wave |
|---|---|---|---|---|
| 1 | FND-01 | 1 | 0 | roadmap approval; `make check-docs` green (it is, 2026-10-09) |
| 2 | FND-02 | 1 | 0 | FND-01 done |
| 3 | FND-03 | 1 | 0 | FND-02 done (FND-03 promotes FND-02's accessibility tripwire) |
| 4 | ACC-01 | 1 | 1 | **Phase 0 exit** |
| 5 | ACC-02 | 1 | 1 | ACC-01 done |
| 6 | ACC-03 | 1 | 1 | ACC-02 done (same Login aggregate + Fortify config) |
| 7 | ACC-04 | 1 | 1 | ACC-03 done (admin view needs roles) |
| 8 | PRP-01 \| PRP-03 | 2 | 2 | **Phase 1 exit** |
| 9 | PRP-02 | 1 | 2 | PRP-01 done |
| 10 | RES-01 | 1 | 3 | **Phase 2 exit + PO checkpoint (16 §12)** |
| 11 | RES-02 \| RES-03 | 2 | 3 | RES-01 done (the phase's shared model) |
| 12 | RES-04 | 1 | 3 | RES-02 done (serial: both edit `app/Actions/Reservations/**`) |
| 13 | MON-01 \| MON-02 | 2 | 4 | **Phase 3 exit + PO checkpoint** |
| 14 | MON-03 \| MON-06 | 2 | 4 | MON-01, MON-02 done |
| 15 | MON-04 | 1 | 4 | MON-03 done |
| 16 | MON-05 | 1 | 4 | MON-04 done (serial: both edit the finalise action) |
| 17 | OUT-01 \| OUT-03 | 2 | 5 | **Phase 4 exit + PO checkpoint** |
| 18 | OUT-02 | 1 | 5 | OUT-03 done (serial: shared link resolver + inactive page) |
| 19 | OPS-01 \| OPS-02 \| OPS-03 | 3 | 6 | **Phase 5 exit** |
| 20 | OPS-04 | 1 | 6 | OPS-01..03 done; owner-provided production host and real month |

After wave 20: **Phase 6 exit** (release gate `12` §7 on the production host) + PO checkpoint before launch.

```
Wave 1 (alone): FND-01
Wave 2: FND-02
Wave 3: FND-03
Wave 4: ACC-01
Wave 5: ACC-02
Wave 6: ACC-03
Wave 7: ACC-04
Wave 8 (2 parallel): PRP-01 | PRP-03
Wave 9: PRP-02
Wave 10: RES-01
Wave 11 (2 parallel): RES-02 | RES-03
Wave 12: RES-04
Wave 13 (2 parallel): MON-01 | MON-02
Wave 14 (2 parallel): MON-03 | MON-06
Wave 15: MON-04
Wave 16: MON-05
Wave 17 (2 parallel): OUT-01 | OUT-03
Wave 18: OUT-02
Wave 19 (3 parallel): OPS-01 | OPS-02 | OPS-03
Wave 20: OPS-04
Critical path: FND-01 → FND-02 → FND-03 → ACC-01 → ACC-02 → ACC-03 → ACC-04 → PRP-01 → PRP-02 → RES-01 → RES-02 → RES-04 → MON-01 → MON-03 → MON-04 → MON-05 → OUT-03 → OUT-02 → OPS-01 → OPS-04
Peak parallelism: 3 (wave 19); 20 waves for 27 packages
```

Because phases are gated, every wave is on the critical path. Two links are serialization, not domain dependency (RES-02 → RES-04, OUT-03 → OUT-02); the owner can collapse each by approving an alternative seam (roadmap-proposal.md §4). Under the strict lane reading (a single "Staff app pages" lane and a single "Outside views" lane) waves 8, 11, 14 and 17 split: 24 waves, peak parallelism 3 only in wave 19.

## Phase exit criteria (word for word, `specs/15`)

- **Phase 0 (gates wave 4):** A fresh clone boots locally through `make clean-start`; CI is green on the remote and a red pipeline blocks a merge; `make check-docs` passes; every tripwire is either promoted or still provably absent.
- **Phase 1 (gates wave 8):** A browser test signs up, is approved by command, logs in as admin and invites an operations user and an owner; the isolation suite passes for every model and route that exists.
- **Phase 2 (gates wave 10):** The onboarding journey of `09` §3 runs end to end; operations sees no IBAN, terms or amount; isolation tests cover every new model and route.
- **Phase 3 (gates wave 13):** The "run a month" journey of `09` §3 runs end to end up to turnovers done; overlapping reservations are refused by the database; operations never sees a money line.
- **Phase 4 (gates wave 17):** Every golden test of `12` §5 passes; the "close a month" journey of `09` §3 runs end to end; a finalised statement does not change when a counted reservation is edited, and the adjustment appears on the next month.
- **Phase 5 (gates wave 19):** The outside journeys of `09` §4 run end to end; the leak tests of `12` §4 pass.
- **Phase 6 (release):** The release gate of `12` §7 holds on the production host.

A phase is exited only when every package in it is `done` in `TRACEABILITY.md` and its exit criteria have recorded evidence (`TRACEABILITY.md` "Phase exit criteria"). Product Owner checkpoints after Phases 2, 3, 4 and 6 (`specs/16` §12).
