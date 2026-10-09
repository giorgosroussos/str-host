# Implementation board

Updated: 2026-10-09 · Milestone: Phase 0 · Parallel limit: 3 · Mode: design-pack (fallback, pre-W10)

| ID | Title | Wave | Status | Depends on | Lane | Prompt 2 | Agent | Rounds |
|---|---|---|---|---|---|---|---|---|
| FND-01 | Command contract and repository scaffold | 1 | done | — | infra | yes | - | 0 |
| FND-02 | CI baseline | 2 | todo | FND-01 | infra | yes | - | 0 |
| FND-03 | Design, accessibility and localization foundation | 3 | todo | FND-01, FND-02 | staff-ui | yes | - | 0 |
| ACC-01 | Tenancy and isolation harness | 4 | todo | Phase 0 exit | domain:account | yes | - | 0 |
| ACC-02 | Sign-up, approval and terms | 5 | todo | ACC-01 | domain:account | yes | - | 0 |
| ACC-03 | Logins, invitations, roles and second factor | 6 | todo | ACC-01, ACC-02 | domain:login | yes | - | 0 |
| ACC-04 | Audit trail | 7 | todo | ACC-01, ACC-03 | domain:audit | yes | - | 0 |
| PRP-01 | Owners and properties | 8 | todo | Phase 1 exit, ACC-03, ACC-01 | domain:owner-property | yes | - | 0 |
| PRP-02 | Property terms | 9 | todo | PRP-01, ACC-04 | domain:property-terms | yes | - | 0 |
| PRP-03 | Cleaners and their links | 8 | todo | ACC-03, ACC-01 | domain:cleaner | yes | - | 0 |
| RES-01 | Reservations and overlap | 10 | todo | Phase 2 exit, PRP-01, ACC-04 | domain:reservation | yes | - | 0 |
| RES-02 | Money lines and climate fee rates | 11 | todo | RES-01, PRP-01 | domain:reservation | yes | - | 0 |
| RES-03 | Calendar and timeline | 11 | todo | RES-01 | staff-ui | no | - | 0 |
| RES-04 | Turnovers | 12 | todo | RES-01, PRP-03, PRP-01, PRP-02, RES-02 | domain:turnover | yes | - | 0 |
| MON-01 | Calculation engine | 13 | todo | Phase 3 exit | money | yes | - | 0 |
| MON-02 | Expenses and receipts | 13 | todo | PRP-01, ACC-04 | domain:expense | yes | - | 0 |
| MON-03 | Statement lifecycle | 14 | todo | MON-01, MON-02, RES-02, RES-04 | domain:statement | yes | - | 0 |
| MON-04 | Adjustments and carry-forward | 15 | todo | MON-03, MON-01 | domain:adjustment | yes | - | 0 |
| MON-05 | Statement PDF and email | 16 | todo | MON-03, MON-04 | domain:statement | yes | - | 0 |
| MON-06 | Dashboard and cleaner pay summary | 14 | todo | MON-01, RES-02, RES-04 | staff-ui | no | - | 0 |
| OUT-01 | Owner portal | 17 | todo | Phase 4 exit, MON-05, MON-02, ACC-03 | outside:owner | yes | - | 0 |
| OUT-02 | Guest page and map | 18 | todo | Phase 4 exit, RES-01, PRP-01, PRP-03, OUT-03 | outside:guest | yes | - | 0 |
| OUT-03 | Cleaner link | 17 | todo | Phase 4 exit, PRP-03, RES-04 | outside:cleaner | yes | - | 0 |
| OPS-01 | Retention jobs | 19 | todo | Phase 5 exit, RES-01, ACC-04, PRP-01, PRP-03 | domain:retention | yes | - | 0 |
| OPS-02 | Account lifecycle and data requests | 19 | todo | Phase 5 exit, ACC-02 | domain:account-lifecycle | yes | - | 0 |
| OPS-03 | Production deployment and backups | 19 | todo | Phase 5 exit, MON-02 | infra | yes | - | 0 |
| OPS-04 | Release acceptance | 20 | todo | OPS-01, OPS-02, OPS-03 | infra | no | - | 0 |

## Open questions (inbox)
- none (QUESTIONS.md: Blocking none, Open none)

## Blocked
- none (every package has blocked-by: —)
