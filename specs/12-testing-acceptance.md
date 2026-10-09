# 12 — Testing and Acceptance

What must be proven, by which test layer, before anything counts as done.

## 1. Test layers

- Tests MUST be written with Pest and MUST run against PostgreSQL 16, never SQLite; a test MUST prove the engine in use. [input, D-041]
- There MUST be three layers: unit (every money rule, no database), feature (HTTP flows and the isolation suite, on PostgreSQL), and browser (the journeys of §6, each running an axe WCAG 2.1 AA check on every page it visits). [D-036, Q-043]

## 2. Gates

Every gate MUST run through one `make` target, locally and in CI: [D-006]

| Gate | Target |
| --- | --- |
| backend tests | `make test` |
| browser tests | `make test-browser` |
| static analysis | `make lint` |
| formatting | `make format-check` |
| frontend types | `make typecheck` |
| specification consistency | `make check-docs` |

## 3. Isolation suite

- For every tenant model and every route, a test MUST prove that a login of account A cannot read, list, create against or change a record of account B. [input]
- For every owner-portal route, a test MUST prove that owner X cannot see any record of owner Y in the same account. [input]
- For every cell of the permission matrix of `07` §2, a test MUST prove the allowed and the refused case. [D-039]
- The suite MUST always pass; a failing isolation test blocks every merge. [input, D-039]

## 4. Outside-view leak tests

- Guest page, cleaner link and owner portal responses MUST be tested to contain no amount (owner portal: outside finalised statements), no other owner, no other reservation, and no guest data beyond the first name. [D-036, Q-016, Q-017]
- Link expiry, revocation and cancellation MUST each be tested to return the inactive-link page (`08` §4). [Q-014, Q-015, D-032]

## 5. Money golden tests

- Every rule of `06` MUST have unit tests, and a set of worked examples computed by hand MUST be reproduced to the cent: each fee model, VAT, kept and passed-on cleaning fees, commission on cleaning, cancellation with and without money, an owner stay, a month with only a fixed fee (negative carry-forward), an ownership change mid-month, and an edit after finalisation. [input, Q-027, Q-031, Q-053, Q-054, Q-045, Q-006, D-036]
- Rounding MUST be tested on amounts whose half-cent falls exactly on .5. [Q-032]

## 6. Critical journeys

- The journeys of `09` §3 and §4 MUST each have one browser test that runs end to end. [D-036]

## 7. Release gate

The MVP is accepted when all of these hold: [input, D-006, D-036]

- every gate of §2 passes on the default branch;
- the journeys of §6 pass;
- a statement prepared from a month of real reservations matches the owner's hand calculation to the cent;
- a restore from backup has been rehearsed (`11` §5). [Q-077]
