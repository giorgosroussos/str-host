# 10 — Security, Privacy and Retention

The boundaries that must never break, and how long personal data lives.

## 1. Isolation

- No account MUST ever see another account's data, on any surface, through any action. [input]
- No owner MUST ever see another owner's data, with tests as strict as tenant isolation. [input]
- Tenant context MUST be derived on the server (`02` §3). [input]
- Every model and every action MUST have isolation tests, and they MUST always pass (`12` §3). [input]

## 2. Signed links

- Guest and cleaner links MUST carry a 256-bit random token of which only a SHA-256 hash is stored; revoking deletes the hash, reissuing creates a new token. [D-013]
- A guest link MUST expire at 23:59 Europe/Athens on the check-out day (`08` §2). [Q-014]
- A cleaner link MUST stay valid until revoked or reissued (`08` §3). [Q-015]
- Links MUST NOT leak money, owners, other reservations, or guest data beyond the first name. [input]

## 3. Logging

- Logs, exception reports and audit views MUST NOT contain IBANs, link tokens, passwords, second-factor secrets, or guest surnames, phones or emails. [D-017]

## 4. Audit trail

- Every change listed in `03` §6 MUST be recorded with user, time and before/after values, visible to admins only, and kept as long as the records it describes. [Q-007]

## 5. Retention

- Guest name, phone and email MUST be anonymised 24 months after check-out, in reservations and in audit entries alike; dates, channel and money lines stay. [Q-009]
- Phone, email and IBAN of an archived owner, and the phone of an archived cleaner, MUST be erased 24 months after archiving; names stay on finalised statements. [Q-055]
- Receipt files MUST be kept as long as their expense. [Q-048]
- Backups MUST be kept 30 days, so removed personal data leaves every copy within 30 days (`11` §5). [Q-052]
- Anonymisation and erasure MUST run daily from the scheduler. [D-025]

## 6. An account leaving

- On the operator's command an account MUST become suspended (no logins, links dead), MAY be exported for the account, and MUST be deleted with all its data 90 days later. [Q-011]

## 7. Requests about personal data

- Access and erasure requests MUST be handled by the operator with server commands on the account's request; the MVP has no self-service feature for them. [Q-039]

## 8. Terms

- Sign-up MUST require accepting the operator's terms of service, privacy policy and data processing agreement, storing the version, the login and the time. [Q-047]
- The account MUST be recorded as controller and the operator as processor of the personal data it enters. [Q-047]

## 9. Authentication hardening

- Admin logins MUST require a second factor (`07` §4). [Q-013]
- Login, reset, invitation and sign-up forms MUST be rate limited and MUST NOT reveal whether an email has a login. [D-033]
- Invitations MUST be single-use and expire after 7 days. [Q-050]
