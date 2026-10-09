# 11 — Infrastructure and Operations

Where the product runs, what it depends on, and what the operator does from the server.

## 1. Environments

- Development MUST run on localhost with Docker Compose providing PostgreSQL 16. [input, Q-035]
- Development email MUST go to a mail-trap account and never to real recipients. [Q-036]

## 2. Production hosting

- Production MUST run on a VPS of an EU-based provider in an EU region, paid by the operator. [Q-035]
- Production MUST run with Docker Compose on that host: application, queue worker, scheduler and PostgreSQL, behind a TLS-terminating proxy with automatically renewed certificates. [Q-085, D-034]
- Every production request MUST be served over HTTPS; local development MAY use plain HTTP (§1). [Q-075, D-034]

## 3. Email

- Production email MUST be sent through an EU-based transactional provider, paid by the operator, from the product's own domain. [Q-036]
- The provider MUST be the only third party receiving personal data (`02` §5). [Q-036, Q-038]

## 4. Operator commands

The operator MUST be able to do the following with Artisan commands on the server, each logged with command, arguments and time: [Q-012, Q-076]

| Command | Does | Provenance |
| --- | --- | --- |
| approve an account | pending → active, sends the account-active email | Q-046, Q-089 |
| suspend an account | active → suspended, logins and links stop | Q-011 |
| export an account | writes the account's data to a file for the account | Q-011 |
| delete an account | removes all data of a suspended account; runs automatically 90 days after suspension | Q-011 |
| maintain climate fee rates | adds a dated rate per property type and season | Q-033 |
| refresh the map file | replaces the PMTiles file of Greece | Q-049 |
| export or erase a person | answers an access or erasure request | Q-039 |

- None of these operations MUST be reachable from the web. [Q-012]

## 5. Backups

- PostgreSQL MUST be dumped nightly together with receipt files to storage of the same provider in an EU region, kept 30 days. [Q-052, Q-086]
- A restore MUST be rehearsed before the first external account goes live. [Q-077, D-019]

## 6. Errors and logs

- Errors MUST be written to server logs only, under the redaction rules of `10` §3. [Q-038, D-017]

## 7. Map data

- The PMTiles file MUST be served by the application from its own host with the OpenStreetMap attribution shown on the map. [Q-049]
