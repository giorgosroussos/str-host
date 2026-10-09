# Locked Decision Register

Each bullet below is an owner decision: stated in the requirements (`[input]`) or made by answering a question card (`[Q-NNN]`, see `QUESTIONS.md`). Nothing else appears here; `make check-docs` fails on any other provenance. Bullets are compressions of statements in the domain specifications, grouped by the surface they fix.

## 1. Data

- Every table MUST use a UUID primary key and every amount MUST be stored as integer cents (`03` §1). [input]
- A login MUST belong to exactly one account, with email unique across the installation (`03` §2). [Q-001]
- An owner MUST have exactly one login (`03` §2). [Q-002]
- A property MUST have at most one owner on any date (`03` §3). [Q-003]
- Ownership MUST be recorded as dated periods; every dated item belongs to the owner on its date (`03` §3, `06` §4). [Q-004]
- A reservation MUST be confirmed or cancelled; a paid cancellation keeps its money lines (`04` §3). [Q-005]
- An edit after finalisation MUST produce a computed adjustment on the owner's next open month, linked to its cause (`06` §8). [Q-006]
- Every money-affecting change MUST write an audit entry with user, time and before/after values (`03` §6). [Q-007]
- A reservation MUST store guest full name, count, phone and email, and nothing else about the guest (`03` §2). [Q-008]
- Guest name, phone and email MUST be anonymised 24 months after check-out (`10` §5). [Q-009]
- Owners, properties and cleaners MUST be archived, not deleted, once referenced (`03` §4). [Q-010]
- A leaving account MUST be suspended and deleted 90 days later (`10` §6). [Q-011]
- In an ownership-change month, expenses go by date and the fixed monthly fee to the owner on the last day (`06` §4). [Q-045]
- Receipt files MUST be kept as long as their expense (`10` §5). [Q-048]
- Backups MUST be kept 30 days (`11` §5). [Q-052]
- Archived owners' phone, email and IBAN and archived cleaners' phone MUST be erased 24 months after archiving (`10` §5). [Q-055]
- A finalised statement's numbers MUST NOT change (`06` §8). [input]
- Two reservations on a property MUST NOT overlap, a same-day check-out and check-in excepted, enforced by the database (`04` §4). [Q-061]

## 2. Security

- No account MUST ever see another account's data, and no owner another owner's; tenant context MUST be derived on the server (`10` §1). [input]
- Staff MUST have one of two fixed roles, admin or operations; operations MUST NOT see amounts, terms, expenses or statements (`07` §2). [input]
- Guests and cleaners MUST NOT have accounts; they use signed links (`02` §4). [input]
- There MUST be no web role that sees more than one account (`07` §6). [Q-012]
- Admins MUST use a second factor; others MAY (`07` §4). [Q-013]
- A guest link MUST work from creation until 23:59 on the check-out day in the property's timezone (`08` §2). [Q-090]
- A cleaner link MUST stay valid until revoked or reissued (`08` §3). [Q-015]
- An owner MUST see a guest's first name only (`07` §3). [Q-016]
- An owner MUST see amounts only in finalised statements (`07` §3). [Q-017]
- Operations MUST see only an owner's name and phone (`07` §2). [Q-018]
- A signed-up account MUST stay pending until the operator approves it (`01` §4). [Q-046]
- Logins MUST be delivered by single-use invitations expiring after 7 days (`07` §1). [Q-050]
- One login MUST NOT be both staff and owner (`07` §1). [Q-051]
- Guest and cleaner links MUST authorise each request by their token alone, with no session (`02` §4). [Q-066]
- Staff and owners MUST be able to reset a forgotten password by email (`09` §7). [Q-067]
- Link tokens MUST be stored only as hashes and be revocable one by one (`10` §2). [Q-072]

## 3. Scope

- The MVP MUST provide properties and owners, reservations and calendars, turnovers, owner statements, an owner portal, a guest page and a cleaner link (`01` §5). [input]
- The product MUST NOT push availability, take bookings, invoice, report to myDATA, or message guests or cleaners (`01` §1). [input]
- The phase 2 list of `01` §6 MUST NOT be built in the MVP. [input]
- Companies and hosts MUST be able to sign up publicly (`01` §4). [Q-019]
- The product MUST NOT bill accounts (`01` §4). [Q-020]
- A finalised statement MUST reach the owner in the portal, as a PDF, and by an email with a link (`01` §5). [Q-021]
- Expenses MUST be able to carry receipt files the owner sees (`01` §5). [Q-022]
- Admins MUST have a monthly cleaner pay summary, without payment recording (`05` §4). [Q-023]
- Admins MUST have a dashboard of occupancy and income (`09` §2). [Q-024]
- Nothing MUST be imported from files (`01` §7). [Q-025]
- The calendar MUST hold reservations and owner stays only, with no blocked dates (`04` §6). [Q-026]

## 4. External commitments

- A reservation MUST count, whole, in the month of its check-out date (`06` §4). [input]
- The management fee model MUST be one of % of net, % of gross, fixed per reservation, fixed monthly, per property (`06` §2). [input]
- A negative month MUST pay zero and carry the balance forward (`06` §7). [Q-027]
- The guest-paid cleaning fee MUST be a line outside gross with no management fee on it (`06` §3). [Q-028]
- % of gross MUST exclude the climate resilience fee and other taxes (`06` §3). [Q-029]
- Other taxes MUST be deducted before net rental income (`06` §3). [Q-030]
- VAT on management fees MUST be added at a per-account rate, shown as its own line (`06` §3). [Q-031]
- Amounts MUST be rounded half up per line (`06` §1). [Q-032]
- Climate resilience fee rates MUST be one installation-wide table maintained by the operator (`06` §5). [Q-033]
- Owner stays MUST carry no management fee (`04` §5). [Q-034]
- Production MUST run on an EU-based VPS in an EU region (`11` §2). [Q-035]
- Email MUST be sent by an EU-based transactional provider paid by the operator (`11` §3). [Q-036]
- The guest page MUST embed a map (`08` §2). [Q-037]
- No error-tracking service MUST receive data (`02` §5). [Q-038]
- Data requests MUST be handled by the operator (`10` §7). [Q-039]
- Sign-up MUST record acceptance of terms naming the account controller and the operator processor (`10` §8). [Q-047]
- The map MUST be a self-hosted PMTiles file of Greece (`02` §5). [Q-049]
- Commission on the cleaning fee MUST follow whoever keeps the fee (`06` §3). [Q-053]
- A fixed-per-reservation fee MUST apply to a cancellation only when it keeps income (`06` §3). [Q-054]
- Expenses MUST be either charged to the owner or absorbed by the account; only charged ones reduce the payout (`06` §6). [Q-080]
- A reservation MUST count in the month of its check-out date in the property's timezone (`06` §4). [Q-082]
- A statement MUST NOT be finalised while a counting reservation lacks money lines (`06` §9). [Q-083]

## 5. Product identity and UX

- The UI MUST be in Greek and English; guest and cleaner pages follow the reservation's and cleaner's language (`09` §6). [input]
- Staff navigation MUST be by activity with the Timeline as home (`09` §1). [Q-040]
- Outside views and emails MUST carry the account's name and logo (`09` §5). [Q-041]
- Text for guests and cleaners MUST exist in Greek and English (`03` §2). [Q-042]
- Every screen MUST meet WCAG 2.1 AA (`09` §9). [Q-043]
- Staff screens MUST be desktop-first; guest and cleaner pages phone-first (`09` §8). [Q-044]

## 6. Change control

These decisions are implementation constraints. A proposed change requires:

1. a short ADR describing the problem;
2. alternatives and security/data/scope impact;
3. migration and testing implications;
4. Product Owner approval before code changes.

The ADR is a `DECISIONS.md` entry of type `adr` carrying `Owner approval: pending` until the owner grants or rejects it. Agents MUST NOT reopen decisions merely because a different framework or pattern is familiar. Small implementation details may be decided locally if they preserve the locked behavior and are recorded in `DECISIONS.md`. [Q-079, D-002]
