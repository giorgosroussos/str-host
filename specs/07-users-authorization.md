# 07 — Users and Authorization

Who logs in, how, and what each role may do. Links for guests and cleaners are in `08` and `10` §2.

## 1. Logins

- Staff and owners MUST log in with email and password through Fortify sessions. [input]
- A login MUST belong to exactly one account; a person working with two accounts uses two email addresses. [Q-001]
- An owner MUST have exactly one login, and the owner portal MUST be read-only. [Q-002, input]
- Staff and owner logins MUST be created by an admin of the account and delivered as an invitation email with a single-use link that sets the password and expires after 7 days. [Q-050]
- One login MUST NOT be both a staff login and an owner login. [Q-051]

## 2. Staff roles

- Staff MUST have exactly one of two fixed roles, admin or operations; roles are not configurable. [input]
- Admin MUST be able to do everything within the account. [input]
- Operations MUST be able to manage properties, reservations, turnovers and cleaners, and MUST NOT see amounts, commercial terms, expenses, statements, the dashboard or the cleaner pay summary. [input]
- Operations MUST see only an owner's name and phone, never the IBAN, email or the owner list. [Q-018]

The permission matrix (✓ = full, R = read, — = none):

| Area | Admin | Operations | Owner |
| --- | --- | --- | --- |
| Account settings, staff logins | ✓ | — | — |
| Owners (records, IBAN) | ✓ | name and phone only | own record, R |
| Properties (non-money fields) | ✓ | ✓ | own, R |
| Property terms | ✓ | — | — |
| Reservations (dates, guests) | ✓ | ✓ | own, R, first name only |
| Reservation money lines | ✓ | — | via finalised statements only |
| Turnovers (without cost) | ✓ | ✓ | — |
| Turnover cost, cleaner pay summary | ✓ | — | — |
| Cleaners and their links | ✓ | ✓ | — |
| Expenses and receipts | ✓ | — | own, on finalised statements |
| Statements, adjustments, payouts | ✓ | — | own finalised, R |
| Dashboard, audit trail | ✓ | — | — |

- Every action MUST be authorised by a policy that encodes this matrix, and the isolation suite MUST test each cell (`12` §3). [input]

## 3. Owners

- An owner MUST see only properties they hold or held under an ownership period, and only data of those periods. [input, Q-004]
- An owner MUST see a guest's first name only. [Q-016]
- An owner MUST see amounts only in finalised statements; reservations in the portal show no amounts. [Q-017]
- An owner MUST NOT see internal notes, other owners, or any record of another owner. [input]

## 4. Second factor

- Admins MUST use an authenticator-app second factor; operations staff and owners MAY enable one. [Q-013]

## 5. Sign-up and approval

- A login of a pending or suspended account MUST be refused. [Q-046, Q-011]

## 6. Operator

- There MUST be no web role that sees more than one account; the operator works through server commands only (`11` §4). [Q-012]
