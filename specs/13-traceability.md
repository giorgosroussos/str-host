# Traceability Matrix

This matrix maps the commercial and product intent in `docs/inputs/` to the specified implementation and prevents both omissions and scope expansion. It is owner-maintained. Implementation status per work package lives in the root `TRACEABILITY.md`.

| Original intent / requirement | Implemented feature/spec | Status |
| --- | --- | --- |
| "puts every property, reservation, turnover and euro in one place" | `01` §1, §5 | MVP |
| "produces the owner's monthly statement and payout without a spreadsheet" | `06` §7–§9 | MVP |
| A management company (5–60 properties) and an individual host (1–5) with one model | `01` §2, `03` §3 | MVP |
| "A host who later takes on someone else's property simply adds an owner" | `01` §2, `03` §3 | MVP |
| "The customer is the account"; owners and guests have narrow views | `01` §3, `08` | MVP |
| Not a channel manager, booking engine, accounting software or guest messaging tool | `01` §1 | Out of Scope |
| Company staff log in and see everything of their own company | `07` §1–§2 | MVP |
| Owner portal: only their own properties, reservations, expenses and statements | `07` §3, `08` §1 | MVP |
| Guest: signed link per reservation, only their own stay | `08` §2 | MVP |
| Cleaner: signed link, revocable, own turnovers, mark done, first name only, no money | `05` §3, `08` §3 | MVP |
| Several accounts share one installation; no account sees another's data | `02` §3, `10` §1 | MVP |
| Self-owned property: the account's monthly view replaces the statement | `06` §9 | MVP |
| Staff roles admin and operations | `07` §2 | MVP |
| Properties & owners, commercial terms per property | `03` §2, `06` §2 | MVP |
| Reservations with channel, dates, guests and money lines; calendar and timeline; overlaps refused | `04` | MVP |
| Turnovers at every checkout, assigned, pending → done, cost charged per terms | `05` §1–§2 | MVP |
| Owner statements drafted, reviewed, finalised (frozen), payout recorded as paid | `06` §9 | MVP |
| Owner portal read-only | `08` §1 | MVP |
| Guest page: address, map link, check-in, Wi-Fi, house rules, contact; expires after checkout | `08` §2 | MVP |
| The calculation chain, in cents | `06` §1, §3 | MVP |
| Four management fee models, % of net by default | `06` §2–§3 | MVP |
| Negative payout carries forward | `06` §7 | MVP |
| A reservation counts in the month of its check-out date | `06` §4 | MVP |
| Who keeps the cleaning fee is a per-property setting | `06` §2–§3 | MVP |
| Climate resilience fee by season and property type | `04` §5, `06` §5 | MVP |
| Guest page never shows amounts; portal never shows another owner or internal notes | `08` §1–§2, `12` §4 | MVP |
| Guardrails: tenant isolation, owner isolation, no leaks, frozen statements, integer money, UUIDs | `10` §1–§2, `06` §1, §8, `03` §1 | MVP |
| iCal import of dates | `01` §6 | Future |
| Channel APIs, two-way sync, pricing | `01` §6 | Future |
| Guest identity collection, online check-in | `01` §6 | Future |
| Invoicing, myDATA, tax reports for owners | `01` §6 | Future |
| Online payments to owners | `01` §6 | Future |
| Messaging guests or cleaners | `01` §6 | Future |
| Maintenance tickets and inventory | `01` §6 | Future |
| Stack: Laravel 13, PostgreSQL 16, Inertia + Vue 3 + TS, Tailwind 4, PrimeVue 4, Fortify, Pest on PostgreSQL, Docker Compose | `02` §2, `12` §1 | MVP |
| UI in Greek and English; guest page and cleaner link follow the reservation's / cleaner's language | `09` §6 | MVP |
| Done: onboard, enter a month, run turnovers, finalised statement matching a hand calculation to the cent; owners see only their data; every guest gets a link | `01` §8, `12` §7 | MVP |

## Coverage rule

Any future commercial promise MUST be added here before implementation and classified as MVP, Future or Out of Scope; a code change alone does not change product scope. [D-004]
