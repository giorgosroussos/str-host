# 02 — Architecture

How the system is built: layout, stack, the tenant boundary and the components.

## 1. Repository layout

| Path | Holds |
| --- | --- |
| `app/Actions/<Area>` | one class per business operation (create reservation, finalise statement, …) |
| `app/Money` | the pure calculation of `06`; no database, no framework calls |
| `app/Models` | Eloquent models with the tenant scope |
| `app/Http/Controllers/{Staff,Owner,Guest,Cleaner}` | one group per entry surface (§4) |
| `resources/js/Pages/{Staff,Owner,Guest,Cleaner}` | Inertia pages mirroring the controllers |
| `lang/el`, `lang/en` | interface strings (`09` §6) |
| `database/migrations` | schema |
| `tests/Unit`, `tests/Feature`, `tests/Isolation` | money and units; flows; tenant and owner isolation (`12`) |
| `docker-compose.yml`, `Makefile` | local services and the command contract |

- Code MUST follow this layout. [D-026]
- The money calculation MUST live only in `app/Money` and MUST be callable without a database. [D-026]

## 2. Stack

- The backend MUST be Laravel 13 on PHP 8.3 with Fortify, the database PostgreSQL 16, and the frontend Inertia, Vue 3 with TypeScript, Tailwind 4 and PrimeVue 4. [input]
- Tests MUST run with Pest against a real PostgreSQL database, never SQLite. [input]
- Static checks and formatting MUST use the tools of D-006, each behind a `make` target. [D-006]

## 3. Tenant boundary

- Every tenant table MUST carry `company_id`, and every query on it MUST pass through a global scope that filters by the current account. [input]
- The current account MUST be derived on the server, never from a value the client sends. [input]
- Staff and owners MUST get it from their login, guests and cleaners from their link. [Q-094, D-038]
- Inside an account, every owner-portal query MUST additionally be scoped to the logged-in owner's properties. [input]
- Installation-wide tables (accounts, climate resilience fee rates, terms versions) carry no `company_id` and MUST NOT hold any account's data. [Q-033, Q-047]

## 4. Entry surfaces

| Surface | Credential | Route group |
| --- | --- | --- |
| Staff app | Fortify session | `/app` |
| Owner portal | Fortify session | `/owner` |
| Guest page | token in the link | `/g/{token}` |
| Cleaner link | token in the link | `/c/{token}` |

- Guests and cleaners MUST NOT receive a session or an account; each request is authorised by its link token alone. [Q-066]
- A staff login MUST NOT open owner-portal routes and an owner login MUST NOT open staff routes. [Q-051]

## 5. Third parties

- The only third party receiving data in production MUST be the transactional email provider (`11` §3). [Q-036]
- Errors MUST be logged on the server only; no error-tracking service is used. [Q-038]
- The guest-page map MUST be served from the product's own server as a PMTiles file and rendered with MapLibre GL JS. [Q-049, D-008]
- No page MAY load fonts, scripts, styles or tiles from a third-party host at runtime. [Q-068, D-018]

## 6. Background work

- Scheduled tasks MUST run from the Laravel scheduler, and emails and PDFs MUST be produced on the database queue. [D-025]
