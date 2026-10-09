# QUESTIONS

Generated file. The source of truth is the append-only, hash-chained event log at `.log/events.jsonl`; this file is the projection of its `questions` stream. Do not edit it by hand: an edit here does not change what was asked or answered, and `make check-docs` fails until the file equals a fresh rebuild (`projection-fresh`). Cards are opened, answered, deferred, resolved and superseded by appending events with `scripts/log-append.py`, then `make rebuild-questions`.

Only matters the specs cannot answer, each as a decision card. A card belongs here if and only if its plausible answers change data, security, scope, external commitments or product identity/UX; anything else is decided in `DECISIONS.md` with alternatives and is never asked. A card is resolved by answering it, writing the answer into the specs with a `[Q-NNN]` tag (or, after the baseline, into a decision), and appending `card-resolved`. Nothing is ever removed: an owner who changes their mind gets a new card and a `card-superseded` event, and both cards stay readable, because the options the owner saw are the only record of why the decision reads as it does.

Card format:

```
### Q-NNN — <title>
- Surface: data | security | scope | external | ux
- Source: <requirement text, input file, mockup artboard, or the gap that raised it>
- Question: <one sentence>
- Options:
  - A) <option> → effect on <surface>: <concrete consequence>
  - B) <option> → effect on <surface>: <concrete consequence>
- Recommendation: <A|B|C>, because <one or two sentences>
- Blocks: <specification | Phase N | WORK-PACKAGE-ID>
- Answer: <A|B|C|text> (<date>[; recommendation accepted])
```

Every card opens `Blocking` and is answered before the specification proceeds. `Open` cards are the ones the owner deferred, by a `card-deferred` event that names the phase or work package before which they are answered; the spec text that depends on them states the recommendation and carries the `[Q-NNN]` tag, so the provisional status is visible where the statement is read. `make check-docs` verifies the card fields, the Surface value, and that every Resolved card that has not been superseded is cited by a statement.

## Index

- Q-001 — Login identity across accounts — data — Resolved
- Q-002 — Logins per owner — data — Resolved
- Q-003 — Owners per property — data — Resolved
- Q-004 — Change of a property's owner — data — Resolved
- Q-005 — Cancelled reservations — data — Resolved
- Q-006 — Edits after a statement is finalised — data — Resolved
- Q-007 — Audit trail of money-affecting changes — data — Resolved
- Q-008 — Guest personal data stored — data — Resolved
- Q-009 — Retention of guest personal data — data — Resolved
- Q-010 — Removing owners, properties and cleaners — data — Resolved
- Q-011 — An account leaves the installation — data — Resolved
- Q-012 — Installation operator's access to accounts — security — Resolved
- Q-013 — Two-factor authentication — security — Resolved
- Q-014 — Guest link validity window — security — Resolved — superseded by Q-090
- Q-015 — Cleaner link lifetime — security — Resolved
- Q-016 — Guest names in the owner portal — security — Resolved
- Q-017 — Money the owner sees before finalisation — security — Resolved
- Q-018 — Operations role and owner details — security — Resolved
- Q-019 — How an account is created — scope — Resolved
- Q-020 — Charging accounts for the product — scope — Resolved
- Q-021 — How a finalised statement reaches the owner — scope — Resolved
- Q-022 — Receipts on expenses — scope — Resolved
- Q-023 — Cleaner pay summary — scope — Resolved
- Q-024 — Account-level reporting — scope — Resolved
- Q-025 — Importing existing data — scope — Resolved
- Q-026 — Blocked dates on the calendar — scope — Resolved
- Q-027 — Negative monthly payout — external — Resolved
- Q-028 — Guest-paid cleaning fee in the calculation — external — Resolved
- Q-029 — Base of a percentage-of-gross fee — external — Resolved
- Q-030 — The "other taxes" money line — external — Resolved
- Q-031 — VAT on the management fee — external — Resolved
- Q-032 — Rounding of computed amounts — external — Resolved
- Q-033 — Source of climate resilience fee rates — external — Resolved
- Q-034 — Owner stays and fees — external — Resolved
- Q-035 — Hosting jurisdiction and provider — external — Resolved
- Q-036 — Transactional email provider — external — Resolved
- Q-037 — Map on the guest page — external — Resolved
- Q-038 — Error tracking service — external — Resolved
- Q-039 — Requests from owners and guests about their data — external — Resolved
- Q-040 — Staff navigation model — ux — Resolved
- Q-041 — Branding seen by owners, guests and cleaners — ux — Resolved
- Q-042 — Bilingual house information — ux — Resolved
- Q-043 — Accessibility target — ux — Resolved
- Q-044 — Devices per actor — ux — Resolved
- Q-045 — Money items in the month a property changes owner — data — Resolved
- Q-046 — Who may complete a public sign-up — security — Resolved
- Q-047 — Terms accepted at sign-up — external — Resolved
- Q-048 — Retention of expense receipts — data — Resolved
- Q-049 — Map tile source for the embedded guest map — external — Resolved
- Q-050 — How staff and owners receive their login — security — Resolved
- Q-051 — One person as staff and owner — security — Resolved
- Q-052 — Backup retention — data — Resolved
- Q-053 — Channel commission on the guest-paid cleaning fee — external — Resolved
- Q-054 — Fixed-per-reservation fee on a paid cancellation — external — Resolved
- Q-055 — Retention of archived owners' and cleaners' personal data — data — Resolved
- Q-056 — UUID version — data — Resolved
- Q-057 — Precision of stored percentages — data — Resolved
- Q-058 — Default turnover cost per property — data — Resolved
- Q-059 — How a self-owned property is recorded — data — Resolved
- Q-060 — Turnovers follow reservation edits — data — Resolved
- Q-061 — Same-day check-out and check-in, enforced in the database — data — Resolved
- Q-062 — Climate fee rates keep their history — data — Resolved
- Q-063 — Draft statements computed, not stored — data — Resolved
- Q-064 — Guest-page contact number — data — Resolved
- Q-065 — How often retention runs — data — Resolved
- Q-066 — Guest and cleaner links never open a session — security — Resolved
- Q-067 — Password reset by email — security — Resolved
- Q-068 — No third-party host at runtime — security — Resolved
- Q-069 — Staff may mark a turnover done — security — Resolved
- Q-070 — How far ahead the cleaner link shows — security — Resolved
- Q-071 — One page for every inactive link — security — Resolved
- Q-072 — Link tokens stored only as hashes — security — Resolved
- Q-073 — What logs never contain — security — Resolved
- Q-074 — Rate limiting and no email enumeration — security — Resolved
- Q-075 — HTTPS for every request — security — Resolved
- Q-076 — Operator commands are logged — security — Resolved
- Q-077 — Restore rehearsal before launch — scope — Resolved
- Q-078 — New commercial promises go through the scope matrix — scope — Resolved
- Q-079 — Change control and agent latitude — scope — Resolved
- Q-080 — Expenses absorbed by the account — external — Resolved
- Q-081 — Where owner-paid cleaning appears on a statement — external — Resolved
- Q-082 — Timezone of the statement month — external — Resolved
- Q-083 — Finalising with missing money lines — external — Resolved
- Q-084 — Dashboard figures — external — Resolved
- Q-085 — Database on the same host — external — Resolved
- Q-086 — Where backups are stored — external — Resolved
- Q-087 — Operations enter reservations without amounts — ux — Resolved
- Q-088 — Turnovers created without a cleaner — ux — Resolved
- Q-089 — Account-active email — ux — Resolved
- Q-090 — Guest link expiry in the property's timezone — security — Resolved
- Q-091 — What recording a payout stores — data — Resolved
- Q-092 — Default timezone for a new property — data — Resolved
- Q-093 — A finalised statement never returns to draft — data — Resolved
- Q-094 — Where the server gets the current account from — security — Resolved
- Q-095 — Staff roles are fixed — security — Resolved
- Q-096 — Timezone of other dates — external — Resolved
- Q-097 — Guest link on a cancelled reservation — security — Resolved

## Blocking

None. Phase 0 can proceed.

## Open

None.

## Resolved

### Q-001 — Login identity across accounts
- Surface: data
- Source: base-plan.md §2: "Several accounts share one installation; each is a tenant"; silent on a person who belongs to two accounts
- Question: Is a login (staff or owner) bound to exactly one account, or is it one person who can belong to several accounts?
- Options:
  - A) One login belongs to exactly one account; the same email cannot exist in two accounts → effect on data: no cross-account person entity; an owner whose properties sit with two companies needs two email addresses
  - B) One global person identity with a membership per account and an account switcher after login → effect on data: a person entity shared across tenants, the only record that crosses the tenant boundary; effect on security: tenant context comes from the chosen membership, not the user
  - C) One login per account, same email allowed in several accounts, account chosen by a per-account login URL → effect on data: duplicated person records per tenant; effect on ux: each account has its own login address
- Recommendation: A, because it keeps every record inside one tenant with no exception, which makes guardrail 1 absolute; B can be added later without migrating data out of tenants.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-002 — Logins per owner
- Surface: data
- Source: base-plan.md §2: "Property owner | Login (owner portal)"; silent on co-owners, spouses or the owner's accountant
- Question: Does an owner have exactly one portal login, or can several people log in to the same owner's portal?
- Options:
  - A) Exactly one login per owner → effect on data: the owner record is the login; a spouse or accountant shares it or has none
  - B) Several logins per owner, all seeing the same owner's data → effect on data: a separate portal-user entity linked to the owner, each with its own credentials and lifecycle
- Recommendation: A, because the portal is read-only and the base plan names one owner login; B can be added without changing the owner entity. Can be deferred to the owner-portal phase.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-003 — Owners per property
- Surface: data
- Source: base-plan.md §3.1: "properties (address, owner, ...)"; silent on co-owned properties (common for inherited Greek property)
- Question: Does a property have exactly one owner, or can it be co-owned with payout shares?
- Options:
  - A) Exactly one owner per property → effect on data: property→owner is many-to-one; a co-owned property is recorded under one representative owner who receives the whole statement
  - B) One or more owners with percentage shares; each gets their share on their own statement → effect on data: a property-owner relation with shares; every statement line is split by share, with its own rounding
- Recommendation: A, because it is what the base plan describes and B multiplies every money line by a split; companies can record co-owners under the one owner who receives the payout today.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-004 — Change of a property's owner
- Surface: data
- Source: absent from the inputs (a property sold or inherited while under management)
- Question: When a property changes owner, does the system keep the ownership history on the same property, or is the old property archived and a new one created?
- Options:
  - A) Owner on a property is changed in place from a given date; reservations count for the owner who held the property on the check-out date → effect on data: an ownership-period history on the property
  - B) The property is archived with its history and re-created under the new owner → effect on data: no ownership history; one property in real life is two records, with two calendars
  - C) The owner cannot be changed once any statement was finalised → effect on data: ownership fixed per record; the company must use B by hand
- Recommendation: B, because it needs no history model and keeps every finalised statement's property unchanged; ownership changes are rare at this scale. Can be deferred to the statements phase.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-005 — Cancelled reservations
- Surface: data
- Source: base-plan.md §3.2 lists reservation money lines; silent on cancellations, including cancellations where the platform still pays the host
- Question: How is a cancelled reservation recorded?
- Options:
  - A) A reservation has a status (confirmed / cancelled); a cancelled one frees its dates and drops its turnover, and any money lines it keeps (a paid cancellation) count in the month of the original check-out → effect on data: a reservation lifecycle with a status; cancelled reservations stay as records
  - B) A cancelled reservation without money is deleted; one with a payout is edited down to its money lines → effect on data: no status, no record that a cancellation happened
  - C) No cancellations: staff delete the reservation; paid cancellations are entered as a manual adjustment → effect on data: cancellation income is not linked to a property stay
- Recommendation: A, because paid cancellations are real income the owner is owed, and a status keeps the record auditable without blocking the dates.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-006 — Edits after a statement is finalised
- Surface: data
- Source: base-plan.md §3.4: "finalised (frozen; later edits go to next month as adjustments)"; silent on how an adjustment comes into being
- Question: When a reservation or expense that counted in a finalised month changes, is the adjustment computed by the system or entered by hand?
- Options:
  - A) Records in a finalised month stay editable; the system computes the difference in the owner's amount and posts it as an adjustment on the owner's next open month, with a reference to the edit → effect on data: adjustments are derived records linked to the change that caused them
  - B) Records in a finalised month are locked; an admin enters a manual adjustment (amount, reason) on a later month → effect on data: adjustments are free-standing entries; the original record keeps the wrong value
  - C) Records stay editable, nothing is computed, and an admin enters the adjustment by hand → effect on data: the reservation and the statement disagree with nothing linking them
- Recommendation: A, because it is the reading of "later edits go to next month as adjustments" that keeps the reservation correct and the payout matching a hand calculation without a second manual step.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-007 — Audit trail of money-affecting changes
- Surface: data
- Source: absent from the inputs; base-plan.md §4 "the part that must be right"
- Question: Which changes are recorded with who made them and when?
- Options:
  - A) Every create, update and delete on reservations, money lines, expenses, property terms, adjustments, statements and payouts, with user, time and before/after values, visible to admins → effect on data: an audit-log entity kept as long as the records it describes
  - B) Only statement transitions (drafted, finalised, paid) with user and time → effect on data: no history of who changed an amount before finalisation
  - C) No audit trail beyond created/updated timestamps → effect on data: no record of who changed anything
- Recommendation: A, because a disputed payout between a company and an owner is resolved by showing who changed which amount when, and the volumes here are small.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-008 — Guest personal data stored
- Surface: data
- Source: base-plan.md §3.2: reservations carry "guests"; §6 excludes guest identity collection; silent on which guest fields exist
- Question: What personal data about the guest does a reservation store?
- Options:
  - A) Guest full name and number of guests only → effect on data: the minimum that names the stay; no contact data to protect or retain
  - B) Full name, number of guests, phone and email → effect on data: contact data stored per guest, with its own retention and access rules
  - C) First name and number of guests only → effect on data: no surname anywhere; staff identify stays by property and dates
- Recommendation: B, because companies call or message guests about arrival today and keeping the number on the reservation is why they would leave WhatsApp threads; the narrower views (guest page, cleaner link) still show first name only.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-009 — Retention of guest personal data
- Surface: data
- Source: absent from the inputs (GDPR applies; the money lines must outlive the guest's identity for finalised statements)
- Question: How long are guest personal fields kept after check-out, and what happens then?
- Options:
  - A) Guest name and contact fields are anonymised 24 months after check-out; dates, channel and money lines stay → effect on data: finalised statements keep their numbers but no longer show who stayed
  - B) Kept as long as the account exists → effect on data: personal data with no end of life
  - C) Anonymised 6 months after check-out → effect on data: same as A, shorter; disputes raised later cannot name the guest
- Recommendation: A, because two years covers platform disputes and a full tax year with margin while giving the data a defined end. Can be deferred to the reservations phase.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-010 — Removing owners, properties and cleaners
- Surface: data
- Source: absent from the inputs (an owner leaves the company, a property stops being managed, a cleaner stops working)
- Question: When an owner, property or cleaner leaves, are they deleted or archived?
- Options:
  - A) Archived: hidden from daily lists, logins and links revoked, history and finalised statements kept unchanged; hard delete only for records nothing references → effect on data: an archived state on each of the three entities
  - B) Deleted with everything that references them → effect on data: finalised statements and the owner's history disappear
- Recommendation: A, because finalised statements are frozen by guardrail 4 and cannot lose the records they were computed from.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-011 — An account leaves the installation
- Surface: data
- Source: absent from the inputs (§2: several accounts share one installation)
- Question: What happens to an account's data when the account stops using the product?
- Options:
  - A) The account is suspended (no logins, links dead), its data is exported for it on request, and it is deleted 90 days later → effect on data: a suspended account state and a deletion deadline
  - B) Deleted immediately on request after an export → effect on data: no grace period; a mistaken closure is unrecoverable
  - C) Suspended and kept indefinitely → effect on data: personal data of owners and guests kept with no end of life
- Recommendation: A, because it gives a defined end of life with a window to undo a mistake. Can be deferred until before the first external account goes live.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-012 — Installation operator's access to accounts
- Surface: security
- Source: absent from the inputs (§2: "no account ever sees another's data"; silent on who creates accounts and supports them)
- Question: Does the product have a platform-operator role that can see across accounts?
- Options:
  - A) No cross-account role in the application; the operator manages accounts through server-side commands only → effect on security: there is no web credential that can read two tenants
  - B) A platform-admin area in the web app listing accounts, with the ability to view inside an account for support → effect on security: one credential type crosses every tenant boundary and needs its own protection and logging
- Recommendation: A, because it keeps the tenant boundary absolute in the web application, and at this scale the operator can support accounts from the server.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-013 — Two-factor authentication
- Surface: security
- Source: base-plan.md §7: "Laravel Fortify"; silent on second factors
- Question: Is a second factor (authenticator app) required, optional or absent for staff and owners?
- Options:
  - A) Required for admin staff, optional for operations staff and owners → effect on security: every login that can see money and IBANs is protected by a second factor
  - B) Optional for everyone → effect on security: protection depends on each user
  - C) None in MVP → effect on security: a leaked password exposes an account's money and owners' IBANs
- Recommendation: A, because admins see every IBAN and amount of the account and Fortify provides the second factor already.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-014 — Guest link validity window
- Surface: security
- Source: base-plan.md §3.6: "Expires after checkout"; silent on from when it works and exactly when it stops
- Question: From when to when does a guest's link show the stay?
- Options:
  - A) Works from creation until 23:59 on the check-out day (Europe/Athens) → effect on security: door instructions and Wi-Fi are visible from booking until departure
  - B) Works from creation; the address, check-in instructions and Wi-Fi appear only from 7 days before arrival; ends at 23:59 on the check-out day → effect on security: access details are exposed for one week instead of from booking
  - C) Works from creation until 3 days after check-out → effect on security: a guest can still read access details after leaving
- Recommendation: A, because the base plan expires the link at checkout and access details usually change per stay; B is worth it only if instructions are long-lived codes.
- Blocks: specification
- Answer: A (2026-10-09)
- Superseded by: Q-090

### Q-015 — Cleaner link lifetime
- Surface: security
- Source: base-plan.md §2: "Signed link per cleaner, no account; revocable by staff"; silent on expiry
- Question: Does a cleaner's link expire on its own, or only when staff revoke it?
- Options:
  - A) Valid until staff revoke or reissue it → effect on security: a forwarded or leaked link works until someone notices
  - B) Expires every 90 days and staff reissue it → effect on security: a leaked link dies on its own; staff resend links four times a year
- Recommendation: A, because the link only shows addresses and times of the cleaner's own turnovers, revocation is immediate, and resending links outside the product (messaging is out of scope) is a real cost.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-016 — Guest names in the owner portal
- Surface: security
- Source: base-plan.md §3.5: owner sees "reservations"; §5.3 limits guest page and cleaner link to first name; silent on what the owner sees
- Question: How much of the guest's identity does an owner see on their reservations and statements?
- Options:
  - A) No guest name; dates, channel and guest count only → effect on security: owners receive no guest personal data
  - B) Guest first name only → effect on security: same rule as the cleaner link
  - C) Guest full name → effect on security: owners receive guest personal data from the company
- Recommendation: B, because it lets an owner recognise a stay in a statement while keeping guest data with the company that collected it.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-017 — Money the owner sees before finalisation
- Surface: security
- Source: base-plan.md §3.5: owner sees "reservations and finalised statements"; silent on whether reservations show amounts
- Question: Does the owner see a reservation's amounts before the month's statement is finalised?
- Options:
  - A) No: reservations in the portal show no amounts; money appears only in finalised statements → effect on security: owners never see figures the company has not reviewed
  - B) Yes: each reservation shows its owner share as soon as it is entered → effect on security: owners see draft figures that may change before finalisation
- Recommendation: A, because the base plan exposes finalised statements, and draft numbers that later change are the disputes the product exists to remove.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-018 — Operations role and owner details
- Surface: security
- Source: base-plan.md §2: operations sees "properties, reservations, turnovers, cleaners; never amounts, terms, expenses or statements"; silent on owner records
- Question: What does the operations role see of owners?
- Options:
  - A) Owner name and phone only; never IBAN, email or the owner list as a whole → effect on security: operations staff cannot read payout details
  - B) Full owner records except IBAN → effect on security: operations sees owner contact data
  - C) Full owner records including IBAN → effect on security: payout details visible to every staff member
- Recommendation: A, because operations needs to reach an owner about a property, not to manage owners or payouts.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-019 — How an account is created
- Surface: scope
- Source: absent from the inputs (§2: several accounts share one installation)
- Question: How does a new management company or host get an account?
- Options:
  - A) The operator creates the account and its first admin; no public sign-up → effect on scope: no sign-up, onboarding or trial flow in MVP
  - B) Public self-service sign-up → effect on scope: a sign-up flow, email verification, abuse controls and an empty-account onboarding in MVP
- Recommendation: A, because the first accounts are onboarded by hand and self-service adds a whole flow the MVP's success criterion does not need.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-020 — Charging accounts for the product
- Surface: scope
- Source: absent from the inputs
- Question: Does the product itself bill accounts (plans, subscription, payment)?
- Options:
  - A) No billing in the product; any charging happens outside it → effect on scope: no plans, limits or payment provider in MVP
  - B) Subscription billing in the product → effect on scope: plans, limits and a payment provider in MVP; effect on external: a paid third party and invoicing obligations
- Recommendation: A, because the base plan describes no commercial model and billing is unrelated to the MVP's success criterion.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-021 — How a finalised statement reaches the owner
- Surface: scope
- Source: base-plan.md §8: "send each owner a finalised statement"; §3.5 owner portal; silent on PDF or email
- Question: What does "send a statement" mean in the MVP?
- Options:
  - A) The finalised statement appears in the owner portal; nothing else → effect on scope: no document generation, no email
  - B) Portal plus a PDF download of the statement for staff and owner → effect on scope: a printable statement document in two languages
  - C) Portal, PDF, and an email to the owner on finalisation with a link → effect on scope: B plus a statement notification email
- Recommendation: C, because "send" implies the owner is told without having to check, the email carries a link and no figures, and the transactional email needed for logins already exists.
- Blocks: specification
- Answer: C (2026-10-09)

### Q-022 — Receipts on expenses
- Surface: scope
- Source: base-plan.md §3.4: "expenses (maintenance, consumables, cleaning where owner-paid)"; silent on receipts
- Question: Can an expense carry a receipt file that the owner can see?
- Options:
  - A) No: an expense is date, property, category, description and amount → effect on scope: no file uploads in MVP
  - B) Yes: one or more receipt images or PDFs per expense, visible to the owner on the finalised statement → effect on scope: file upload, storage and owner access to files; effect on data: stored documents with retention
- Recommendation: B, because owners challenge expenses and the receipt is the answer; it is the main thing the hand-typed statement cannot carry.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-023 — Cleaner pay summary
- Surface: scope
- Source: base-plan.md §3.3: turnovers carry "a cost"; silent on paying cleaners
- Question: Does the MVP show what each cleaner is owed for a month?
- Options:
  - A) No: turnover costs feed owner statements only → effect on scope: cleaner pay stays in a spreadsheet
  - B) Yes: a per-cleaner monthly list of done turnovers and their total, for admins; no payment recording → effect on scope: one report in MVP
- Recommendation: B, because the costs are already recorded per turnover and paying cleaners from them is the next spreadsheet the company keeps otherwise.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-024 — Account-level reporting
- Surface: scope
- Source: absent from the inputs (products in this category usually show occupancy and revenue)
- Question: Does the MVP include reports beyond statements and the self-owned monthly view?
- Options:
  - A) No reports beyond statements, the self-owned monthly view and the cleaner summary if chosen → effect on scope: no dashboards in MVP
  - B) An admin dashboard with occupancy and income per property per month → effect on scope: a reporting screen in MVP
- Recommendation: A, because the success criterion is a correct statement, and reports can be built later from the same data.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-025 — Importing existing data
- Surface: scope
- Source: base-plan.md §1: "Today they run it on Excel"; §8 onboarding; silent on import
- Question: Can an account import owners, properties or reservations from a spreadsheet?
- Options:
  - A) No import; everything is entered in the product → effect on scope: onboarding 60 properties is manual
  - B) CSV import of owners and properties → effect on scope: an import flow with validation and error reporting
  - C) CSV import of owners, properties and reservations → effect on scope: B plus reservation and money-line import
- Recommendation: A, because the success criterion is one month entered by hand and an import format is better designed once real files are seen.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-026 — Blocked dates on the calendar
- Surface: scope
- Source: base-plan.md §3.2: channels include "owner stay"; silent on blocks for maintenance; §1 the product does not push availability
- Question: Can staff block a property's dates without a reservation?
- Options:
  - A) No: the calendar shows reservations and owner stays only → effect on scope: no block entity; maintenance downtime is not shown
  - B) Yes: a blocked period with a reason, refused against overlapping reservations → effect on scope: a block entity in the calendar and timeline
- Recommendation: A, because the product does not push availability to the platforms, so a block here would only be a note; an owner stay already covers the common case.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-027 — Negative monthly payout
- Surface: external
- Source: base-plan.md §4: "Open (for design-pack): a month whose deductions exceed the income ... Proposal: no payout, and the negative balance carries forward"
- Question: What happens when an owner's month comes out negative?
- Options:
  - A) Payout is zero and the negative amount carries forward as an adjustment on the owner's next month → effect on external: the owner owes the company until future income covers it
  - B) The statement shows the negative amount as owed by the owner, recorded as paid when the owner settles it → effect on external: the company invoices the owner outside the product
  - C) The company absorbs the shortfall; the payout is zero and nothing carries forward → effect on external: fixed monthly fees are not collected in empty months
- Recommendation: A, because it is your proposal and it keeps every euro accounted for without the product handling money flowing from owner to company.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-028 — Guest-paid cleaning fee in the calculation
- Surface: external
- Source: base-plan.md §4: "Who keeps the cleaning fee the guest pays is a per-property setting"; the formula starts at gross and does not show the cleaning fee
- Question: Is the cleaning fee the guest pays inside gross, and does a percentage management fee apply to it?
- Options:
  - A) The cleaning fee is its own line outside gross; it goes whole to whoever keeps it per property, and no management fee applies to it → effect on external: management fees are earned on rental income only
  - B) Gross includes the cleaning fee; when the company keeps it, it is deducted after the management fee is computed → effect on external: a percentage fee is also earned on the cleaning fee
  - C) Gross includes the cleaning fee; when the company keeps it, it is deducted before the management fee is computed → effect on external: fees on rental income only, but the line reads as part of gross
- Recommendation: A, because it keeps the fee base unambiguous and makes "who keeps the cleaning fee" a single line on the statement.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-029 — Base of a percentage-of-gross fee
- Surface: external
- Source: base-plan.md §4: fee model "% of gross"; gross includes the climate resilience fee, which is "passed to the state"
- Question: Does a "% of gross" management fee apply to taxes passed to the state?
- Options:
  - A) No: % of gross is computed on gross minus the climate resilience fee and other taxes → effect on external: the company earns no fee on state levies
  - B) Yes: % of the literal gross the guest paid → effect on external: the company earns a fee on state levies
- Recommendation: A, because a fee on a pass-through levy is hard to defend to an owner; B is right only if your contracts say so.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-030 — The "other taxes" money line
- Surface: external
- Source: base-plan.md §3.2 lists "other taxes" as a money line; the §4 formula does not use it
- Question: How does the "other taxes" line enter the calculation?
- Options:
  - A) Treated like the climate resilience fee: deducted from gross before net rental income → effect on external: the owner's share excludes it
  - B) Removed from the MVP: the only tax line is the climate resilience fee → effect on external: any other levy has to be entered as an expense
  - C) Recorded for information only, not deducted → effect on external: the owner is paid on amounts that include it
- Recommendation: A, because it makes the formula and the money lines agree and handles a levy the platforms add without an expense workaround.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-031 — VAT on the management fee
- Surface: external
- Source: absent from the inputs (§1: "not accounting software (no invoices, no myDATA)"; management fees are usually subject to VAT)
- Question: Does the statement deduct VAT on top of the management fee?
- Options:
  - A) No VAT logic: agreed fee terms are VAT-inclusive, and the deduction is exactly the fee → effect on external: companies whose contracts state fee plus VAT must convert their terms
  - B) A per-account VAT rate (0 allowed) is added on top of the management fee and shown as its own line → effect on external: the statement reflects fee-plus-VAT contracts; still no invoice is issued
- Recommendation: B, because a payout that must match a hand calculation to the cent fails on every fee-plus-VAT contract under A, and a rate of 0 serves hosts.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-032 — Rounding of computed amounts
- Surface: external
- Source: base-plan.md §5.5: "rounding rules written down and tested"; §8: payout "matches a hand calculation to the cent"
- Question: At what level are percentage amounts rounded to the cent?
- Options:
  - A) Per reservation, half up to the cent; the month is the sum of rounded lines → effect on external: each statement line is exact as printed and the total equals the sum of lines
  - B) On the monthly total, half up; lines are shown unrounded or rounded for display → effect on external: the total can differ by a cent from the sum of the displayed lines
- Recommendation: A, because an owner checking the statement adds up the lines they see.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-033 — Source of climate resilience fee rates
- Surface: external
- Source: base-plan.md §4: "Open (for design-pack): the climate resilience fee (amount per night by season and property type). Proposal: a per-account table of rates staff maintain ... current rates need confirming"
- Question: Where do the climate resilience fee rates come from?
- Options:
  - A) A per-account table of rates by season and property type, maintained by each account's admins, used to prefill each reservation's fee → effect on external: each account is responsible for keeping the state's rates current
  - B) One installation-wide table maintained by the operator, used to prefill each reservation's fee (editable per reservation) → effect on external: the operator is responsible for the rates for every account
  - C) No table: staff type the fee on every reservation → effect on external: the amount is whatever the channel statement shows, with no check
- Recommendation: B, because the rate is set by law and identical for every account, so one maintained table avoids each account misconfiguring it; it requires a property-type field on each property either way under A or B.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-034 — Owner stays and fees
- Surface: external
- Source: base-plan.md §3.2: channel "owner stay"; §4 fee models silent on owner stays
- Question: Do owner stays incur management fees?
- Options:
  - A) No management fee of any model on an owner stay; its turnover cost follows the property's cleaning terms → effect on external: owners using their own property pay only cleaning
  - B) Treated like any reservation, so a fixed-per-reservation fee applies → effect on external: owners pay a fee to stay in their own property
- Recommendation: A, because an owner stay has no income, and charging a per-reservation fee on it is a commercial term contracts rarely contain.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-035 — Hosting jurisdiction and provider
- Surface: external
- Source: absent from the inputs (§1: Greece; owners' IBANs and guests' data are personal data)
- Question: Where is the product hosted?
- Options:
  - A) An EU-based VPS provider in an EU region (for example Hetzner, Germany/Finland), paid by the operator → effect on external: data stays in the EU under an EU provider's terms
  - B) A Greek hosting provider → effect on external: data stays in Greece; fewer provider choices
  - C) A US hyperscaler's EU region (AWS, GCP, Azure) → effect on external: data in the EU under a US provider's terms
- Recommendation: A, because it keeps data in the EU at the lowest monthly cost for a single Docker host. Can be deferred to the deployment phase.
- Blocks: specification
- Answer: A (production; development runs on localhost) (2026-10-09)

### Q-036 — Transactional email provider
- Surface: external
- Source: absent from the inputs (logins, invitations and password resets need email)
- Question: Who sends the product's emails, and who pays?
- Options:
  - A) An EU-based transactional provider (for example Brevo or Mailgun EU region), paid by the operator, sending from the product's domain → effect on external: a third party receives recipient addresses and message contents
  - B) Amazon SES in an EU region, paid by the operator → effect on external: same as A, under a US provider's terms
  - C) The operator's own SMTP mailbox → effect on external: no new third party; deliverability and sending limits are the mailbox's
- Recommendation: A, because invitation and reset emails must arrive, and an EU provider keeps recipient data in the EU. Can be deferred to the authentication phase.
- Blocks: specification
- Answer: A (production; development uses a mail-trap account) (2026-10-09)

### Q-037 — Map on the guest page
- Surface: external
- Source: base-plan.md §3.6: "address and map link"
- Question: Is the map a link to an outside map service, or a map embedded in the page?
- Options:
  - A) A plain link to the property's coordinates in Google Maps; nothing embedded → effect on external: no API key, no cost, no third party loaded by the page
  - B) An embedded map → effect on external: a tile or maps provider with terms of use, possibly a cost, and the guest's IP sent to it
- Recommendation: A, because the base plan says "map link", and on a phone the link opens the guest's own map app.
- Blocks: specification
- Answer: B (a free map solution) (2026-10-09)

### Q-038 — Error tracking service
- Surface: external
- Source: absent from the inputs
- Question: Are application errors sent to an outside error-tracking service?
- Options:
  - A) No: errors are logged on the server only → effect on external: no third party receives error data
  - B) A hosted error tracker (for example Sentry, EU region) with personal data scrubbed → effect on external: a third party receives stack traces and request metadata
- Recommendation: A, because at MVP scale server logs suffice and adding a third party later is a configuration change. Can be deferred to the deployment phase.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-039 — Requests from owners and guests about their data
- Surface: external
- Source: absent from the inputs (GDPR access and erasure requests)
- Question: How are access and erasure requests from owners, guests and cleaners handled?
- Options:
  - A) The account (the company) handles them; the product offers per-person export and erasure for admins → effect on external: accounts can meet their obligations inside the product
  - B) The account asks the operator, who handles them with server-side tools → effect on external: the operator is involved in every request; no product feature in MVP
- Recommendation: B, because requests will be rare at MVP scale and the retention card already gives data a defined end. Can be deferred until before the first external account goes live.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-040 — Staff navigation model
- Surface: ux
- Source: base-plan.md §3 lists pillars; silent on how staff screens connect
- Question: How is the staff application navigated?
- Options:
  - A) Sections by activity — Timeline (home), Reservations, Turnovers, Properties, Owners, Expenses, Statements, Settings — each listing across all properties → effect on ux: the multi-property timeline is the first screen and work is done across properties
  - B) Property-first: pick a property, then its calendar, reservations, turnovers and expenses; statements and owners separate → effect on ux: work is done one property at a time
- Recommendation: A, because turnovers and statements are daily and monthly work across many properties, and the base plan names the multi-property timeline.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-041 — Branding seen by owners, guests and cleaners
- Surface: ux
- Source: absent from the inputs (§1: the customer is the account; owners and guests are its outside users)
- Question: Whose brand do owners, guests and cleaners see?
- Options:
  - A) The account's name and logo on the owner portal, guest page, cleaner link and emails, with a small product mark → effect on ux: each company appears to its owners and guests as itself
  - B) The product's brand everywhere → effect on ux: owners and guests see a third-party tool
  - C) Full white-label including a custom domain per account → effect on ux: A plus each account's own domain; effect on external: certificates and DNS per account
- Recommendation: A, because companies present the statement and guest page to their own clients, while custom domains are a large step for no MVP need.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-042 — Bilingual house information
- Surface: ux
- Source: base-plan.md §7: "the guest page and cleaner link follow the language set on the reservation / cleaner"; §3.1 house info, Wi-Fi, house rules are staff-entered text
- Question: Is the text staff write for guests and cleaners (house info, check-in instructions, rules, notes) kept in both languages?
- Options:
  - A) Each such text field has a Greek and an English version; the page shows the reservation's language and falls back to the other if empty → effect on ux: a guest sees content in their language when staff provide it
  - B) One version of each text, shown to every guest whatever the language → effect on ux: only labels and headings follow the reservation's language
- Recommendation: A, because most guests read English and most cleaners Greek, and the language setting means little if the content does not follow it.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-043 — Accessibility target
- Surface: ux
- Source: absent from the inputs
- Question: Which accessibility level does the product aim for?
- Options:
  - A) WCAG 2.1 AA as a design and test target for every screen, without certification → effect on ux: contrast, keyboard use and labelling rules apply to every screen
  - B) No stated target → effect on ux: accessibility is whatever PrimeVue gives by default
- Recommendation: A, because the guest page is public-facing and AA costs little when it is a rule from the first screen.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-044 — Devices per actor
- Surface: ux
- Source: absent from the inputs (cleaners and guests use a link on their phone)
- Question: Which device does each part of the product design for first?
- Options:
  - A) Staff: desktop-first, usable on a tablet; owner portal: responsive; guest page and cleaner link: phone-first → effect on ux: the timeline and statements are designed for a wide screen
  - B) Everything phone-first → effect on ux: the staff timeline and statement review are designed for a narrow screen
- Recommendation: A, because statement review and the multi-property timeline are desk work, while guests and cleaners only ever open a link on a phone.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-045 — Money items in the month a property changes owner
- Surface: data
- Source: raised by the answer to Q-004 (A: owner changed in place from a given date; reservations count for the owner on the check-out date); silent on expenses and the fixed monthly fee in that month
- Question: In the month a property changes owner, which owner do its expenses and its fixed monthly fee belong to?
- Options:
  - A) Every dated item goes to the owner who held the property on its date; the fixed monthly fee is dated the last day of the month, so the new owner pays it whole → effect on data: one rule for all items, no proration; the old owner pays no fixed fee for their last part-month
  - B) Expenses by their date; the fixed monthly fee split between the two owners pro rata by days, each part rounded to the cent → effect on data: a fixed fee becomes two derived lines with a rounding rule
  - C) Expenses by their date; the fixed monthly fee charged whole to the owner who held the property on the 1st of the month → effect on data: the outgoing owner pays the whole changeover month
- Recommendation: A, because it extends the check-out-date rule to every item and avoids a proration rule for an event that is rare. Can be deferred to the statements phase.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-046 — Who may complete a public sign-up
- Surface: security
- Source: raised by the answers to Q-019 (B: public self-service sign-up) and Q-020 (A: no billing in the product)
- Question: Does a public sign-up give a working account immediately, or does it wait for the operator?
- Options:
  - A) The account is active as soon as the email address is verified → effect on security: anyone on the internet can create a free tenant and store data in the installation; abuse is handled after the fact by the operator
  - B) Sign-up creates a pending account; the operator approves it with a server-side command before anyone can log in → effect on security: no tenant exists that the operator has not admitted; effect on ux: a new account waits for approval
  - C) Sign-up requires an invitation code issued by the operator → effect on security: only invited companies can create a tenant; effect on ux: the sign-up page is useless without a code
- Recommendation: B, because with no billing an open sign-up gives a free hosted product to anyone, and approval keeps the self-service flow you chose while the operator stays in control of who is a tenant.
- Blocks: specification
- Answer: B (2026-10-09)

### Q-047 — Terms accepted at sign-up
- Surface: external
- Source: raised by the answer to Q-019 (B: public self-service sign-up); absent from the inputs (accounts store owners' and guests' personal data in the operator's installation)
- Question: Does sign-up require accepting terms that set out the operator's legal role?
- Options:
  - A) Sign-up requires accepting the operator's terms of service, privacy policy and a data processing agreement (the account is controller, the operator processor); the version accepted, the user and the time are stored → effect on external: the operator's legal relationship with each account is recorded in the product; the texts must be written before launch
  - B) No terms in the product; any agreement happens outside it → effect on external: accounts store personal data in the installation with no recorded agreement
- Recommendation: A, because a public sign-up is where that agreement is normally made, and storing which version was accepted costs little. The texts themselves are the operator's to write. Can be deferred to the sign-up phase.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-048 — Retention of expense receipts
- Surface: data
- Source: raised by the answer to Q-022 (B: receipt files on expenses, visible to the owner)
- Question: How long are receipt files kept?
- Options:
  - A) As long as the expense they belong to, which is as long as the account (and deleted with it under Q-011) → effect on data: receipts behind finalised statements remain available to owners for the life of the account
  - B) Deleted 5 years after the statement month; the expense line stays → effect on data: old statements lose their receipts but keep their numbers
- Recommendation: A, because the receipts justify frozen statements, and Q-011 already gives them an end of life when the account leaves. Can be deferred to the statements phase.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-049 — Map tile source for the embedded guest map
- Surface: external
- Source: raised by the answer to Q-037 (B: an embedded map, using a free solution)
- Question: Which free source serves the embedded map on the guest page?
- Options:
  - A) Self-hosted vector tiles: one OpenStreetMap-derived map file of Greece (Protomaps PMTiles) served from the product's own server, rendered with an open-source library, with OpenStreetMap attribution → effect on external: no third party receives the guest's IP; no usage limits or cost beyond disk space; the file is refreshed by the operator from time to time
  - B) The public OpenStreetMap tile servers → effect on external: free but governed by the OpenStreetMap Foundation's tile usage policy (no guaranteed availability, heavy use may be blocked); every guest's IP goes to the OpenStreetMap Foundation
  - C) A commercial provider's free tier (for example MapTiler or Stadia Maps) → effect on external: an API key under that provider's terms; free only below a monthly view limit and often only for non-commercial use; guests' IPs go to the provider
- Recommendation: A, because it is the only free option with no third-party terms or traffic limits and no guest data leaving the installation, and a Greece-only map file is small. The page also keeps an "open in maps" link so the guest can navigate with their own app.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-050 — How staff and owners receive their login
- Surface: security
- Source: raised while writing `07` §1; absent from the inputs (who creates a staff or owner login and how the first password is set)
- Question: How does a new staff member or owner get their first password?
- Options:
  - A) An admin invites them; they receive an email with a single-use link that sets the password and expires after 7 days → effect on security: no one but the person ever knows the password; a leaked old invitation dies on its own
  - B) An admin sets an initial password and passes it on, and the person must change it at first login → effect on security: the admin knows every initial password and it travels outside the product
  - C) Invitation link as in A, without expiry → effect on security: an unused invitation in a mailbox works forever
- Recommendation: A, because it keeps passwords known only to their holder and uses the transactional email already chosen in Q-036.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-051 — One person as staff and owner
- Surface: security
- Source: raised while writing `02` §4; absent from the inputs (a staff member, or the host of an account, who also owns a managed property)
- Question: Can one login be both a staff login and an owner login of the same account?
- Options:
  - A) No: a staff login never opens the owner portal and an owner login never opens the staff app; a person who is both uses two logins with two email addresses (Q-001) → effect on security: two credential classes never meet in one session
  - B) Yes: one login may carry a staff role and an owner record, with a switch between the staff app and the portal → effect on security: one session spans both surfaces, and the owner-isolation scope must be applied per surface, not per login
- Recommendation: A, because it keeps owner isolation a property of the login itself, and the case is rare: a host's own properties are self-owned and need no owner login.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-052 — Backup retention
- Surface: data
- Source: raised while writing `11` (recorded first as default D-019); absent from the inputs. Anonymised or deleted personal data survives in backups until they expire
- Question: How long are backups kept?
- Options:
  - A) 30 days of nightly backups → effect on data: anonymised or deleted personal data disappears from every copy within 30 days; a mistake older than 30 days cannot be restored
  - B) 7 days → effect on data: personal data leaves backups within a week; restores reach back one week only
  - C) 30 daily plus 12 monthly backups → effect on data: personal data persists in monthly copies for up to a year after anonymisation or account deletion
- Recommendation: A, because it bounds how long removed personal data survives while covering a month-end mistake found during statement review.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-053 — Channel commission on the guest-paid cleaning fee
- Surface: external
- Source: raised while writing `06` §3 after Q-028 (A: the cleaning fee is its own line outside gross and goes whole to whoever keeps it); channels usually charge their host-side commission on the cleaning fee too
- Question: Who bears the part of the channel commission charged on the cleaning fee?
- Options:
  - A) Whoever keeps the cleaning fee: commission is entered in two lines (on the stay, on cleaning) when the channel reports the split, otherwise all of it on the stay → effect on external: when the company keeps the cleaning fee it also bears the commission on it, where the channel's report allows
  - B) Always the owner: one commission line, all deducted from rental income → effect on external: an owner pays commission on a cleaning fee the company keeps
  - C) Staff enter the cleaning fee already net of its commission → effect on external: same split as A, but staff compute it by hand and the statement shows no commission on cleaning
- Recommendation: A, because the commission follows the money it was charged on, and the fallback keeps entry simple when a channel does not split it.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-054 — Fixed-per-reservation fee on a paid cancellation
- Surface: external
- Source: raised while writing `06` §3 after Q-005 (A: paid cancellations keep their money lines) and Q-034 (A: no fee on owner stays)
- Question: Does a fixed-per-reservation management fee apply to a cancelled reservation?
- Options:
  - A) Only when the cancellation keeps income (gross above zero) → effect on external: the company earns its fixed fee on a paid cancellation, and nothing on an unpaid one
  - B) Never on a cancelled reservation → effect on external: the owner keeps all of a paid cancellation minus commission and taxes
  - C) Always, paid or not → effect on external: an owner pays a fee on a booking that brought nothing
- Recommendation: A, because it mirrors the percentage models, which also earn on a paid cancellation and nothing on an unpaid one.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-055 — Retention of archived owners' and cleaners' personal data
- Surface: data
- Source: raised while writing `10` §5; Q-009 sets guest retention and Q-010 archives owners and cleaners, but nothing sets how long an archived owner's or cleaner's contact data and IBAN are kept
- Question: How long are an archived owner's and cleaner's personal details kept?
- Options:
  - A) Phone, email and IBAN of an archived owner, and an archived cleaner's phone, are erased 24 months after archiving; names stay on finalised statements and turnovers → effect on data: the same end of life as guest data, history stays readable
  - B) Kept as long as the account exists → effect on data: IBANs and contacts of people who left are kept with no end of life
  - C) Erased at archiving → effect on data: no way to contact a former owner about a late adjustment or dispute
- Recommendation: A, because it matches the 24 months you chose for guests (Q-009), covers late disputes, and ends the life of IBANs nobody pays any more. Can be deferred to the retention work package.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-056 — UUID version
- Surface: data
- Source: assumption review: `03` §1: "UUIDs MUST be version 7, generated by the application." (D-009)
- Question: Which UUID version do record identifiers use?
- Options:
  - A) UUIDv7 generated by the application → effect on data: identifiers are time-ordered and reveal their creation time to anyone who sees one in a URL
  - B) UUIDv4 → effect on data: identifiers are fully random and reveal nothing about when a record was created; indexes grow less compactly
- Recommendation: A, because the pack currently assumes it; choose B if creation time visible in guest and cleaner URLs matters to you. Can be deferred to FND-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-057 — Precision of stored percentages
- Surface: data
- Source: assumption review: `03` §1 and `06` §1: "every percentage as integer basis points" (D-012)
- Question: At what precision are fee and VAT percentages stored?
- Options:
  - A) Integer basis points (1% = 100, so 0.01% precision) → effect on data: a contract rate with more decimals (e.g. 18.125%) cannot be entered
  - B) A finer integer unit (millionths) → effect on data: any contract rate can be entered; rounding tests cover more cases
- Recommendation: A, because management fees and VAT are agreed in whole or two-decimal percentages. Can be deferred to PRP-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-058 — Default turnover cost per property
- Surface: data
- Source: assumption review: `03` §2 "A property MUST have a default turnover cost." and `05` §2 "prefilled from the property's default turnover cost and editable per turnover" (D-014)
- Question: Where does a turnover's cost come from?
- Options:
  - A) A default cost on each property, copied into each new turnover and editable per turnover → effect on data: a cost field on every property and on every turnover
  - B) Entered by hand on every turnover → effect on data: no property-level cost; every turnover needs a typed amount
  - C) A rate per cleaner → effect on data: cost stored on the cleaner; the same property costs differently by who cleans it
- Recommendation: A, because cleaning usually costs the same per property and exceptions still get their own amount. Can be deferred to PRP-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-059 — How a self-owned property is recorded
- Surface: data
- Source: assumption review: `03` §3: "A period with no owner MUST mean the property belongs to the account itself." (D-027)
- Question: How is a property owned by the account itself represented?
- Options:
  - A) An ownership period with no owner → effect on data: one property model and one ownership history for both account kinds
  - B) A synthetic owner record representing the account → effect on data: an extra owner per account with no login and no statement, special-cased everywhere
- Recommendation: A, because it keeps the single model your base plan asks for. Can be deferred to PRP-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-060 — Turnovers follow reservation edits
- Surface: data
- Source: assumption review: `04` §3 and `05` §1: "A turnover MUST follow its reservation's date and property while pending, and MUST be deleted when its reservation is cancelled while pending; a done turnover MUST NOT change automatically." (D-020)
- Question: What happens to a turnover when its reservation's dates or property change, or it is cancelled?
- Options:
  - A) A pending turnover moves with the reservation and is deleted on cancellation; a done turnover never changes automatically → effect on data: the schedule stays in step and recorded work and its cost are kept
  - B) Turnovers never change automatically; staff fix them by hand → effect on data: stale turnovers remain after edits
  - C) Done turnovers follow too → effect on data: recorded work and its cost can be moved or deleted by a reservation edit
- Recommendation: A, because it keeps the schedule right without erasing work already done. Can be deferred to RES-04.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-061 — Same-day check-out and check-in, enforced in the database
- Surface: data
- Source: assumption review: `04` §4: "A stay MUST occupy [check-in, check-out) so that a check-out and a check-in on the same day do not overlap, and the rule MUST be enforced by a database exclusion constraint as well as by validation." (D-010)
- Question: Do a check-out and a check-in on the same day count as an overlap, and is the rule enforced in the database?
- Options:
  - A) Not an overlap (half-open stay), enforced by a database constraint and by validation → effect on data: back-to-back stays are storable; overlaps are refused even when two people save at once
  - B) Validation only → effect on data: two simultaneous saves can store overlapping reservations
  - C) Same-day counts as an overlap → effect on data: back-to-back stays cannot be stored
- Recommendation: A, because the turnover pillar assumes same-day turnover and the constraint holds under concurrent edits. Can be deferred to RES-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-062 — Climate fee rates keep their history
- Surface: data
- Source: assumption review: `06` §5: "... with dated validity so past reservations keep their rates." (D-023)
- Question: When the state changes a climate resilience fee rate, is the old rate kept?
- Options:
  - A) Rates carry a valid-from date and a change adds a new rate → effect on data: rate history is kept; each night uses the rate valid on its date
  - B) One current rate, overwritten on change → effect on data: no history; only amounts already on reservations remember the old rate
- Recommendation: A, because prefilling a reservation that spans a rate change needs both rates. Can be deferred to RES-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-063 — Draft statements computed, not stored
- Surface: data
- Source: assumption review: `06` §9: "A draft MUST be computed from current records whenever it is opened; only finalisation stores lines." (D-031)
- Question: Are draft statements stored or computed when opened?
- Options:
  - A) Computed from current records each time; only finalisation stores lines → effect on data: a draft always reflects current records; nothing to go stale
  - B) Stored and refreshed on demand → effect on data: a stored draft can disagree with the records until refreshed
- Recommendation: A, because only the finalised snapshot needs freezing. Can be deferred to MON-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-064 — Guest-page contact number
- Surface: data
- Source: assumption review: `08` §2: "The contact number MUST be the property's own when set, otherwise the account's." (D-016)
- Question: Which contact number does the guest page show?
- Options:
  - A) The property's own number when set, otherwise the account's → effect on data: a contact number on the account and optionally on each property
  - B) The account's number only → effect on data: one number for every property
- Recommendation: A, because some companies have a local contact per area. Can be deferred to OUT-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-065 — How often retention runs
- Surface: data
- Source: assumption review: `10` §5: "Anonymisation and erasure MUST run daily from the scheduler." (D-025)
- Question: How often do anonymisation and erasure run?
- Options:
  - A) Daily → effect on data: personal data outlives its deadline by at most one day
  - B) Monthly → effect on data: personal data outlives its deadline by up to a month
- Recommendation: A, because the cost is the same and the deadline you chose is then met to the day. Can be deferred to OPS-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-066 — Guest and cleaner links never open a session
- Surface: security
- Source: input audit: `02` §4: "Guests and cleaners MUST NOT receive a session or an account; each request is authorised by its link token alone." (the base plan says only "no account")
- Question: Does opening a guest or cleaner link authorise each request by its token, or exchange the token for a session?
- Options:
  - A) Every request carries the token; no session or cookie is created → effect on security: revoking or expiring a link takes effect on the next request; the token sits in the URL
  - B) The link sets a short session cookie and redirects to a clean URL → effect on security: the token leaves the address bar, but a revoked link keeps working until the session ends
- Recommendation: A, because revocation and the check-out expiry then act immediately. Can be deferred to OUT-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-067 — Password reset by email
- Surface: security
- Source: input audit: `09` §7 lists a password reset email tagged as input; the base plan does not mention password recovery
- Question: Can staff and owners reset a forgotten password themselves?
- Options:
  - A) Yes, through a reset email with a single-use, time-limited link → effect on security: anyone who controls the mailbox can take over the login (a second factor still protects admins)
  - B) No; an admin re-sends an invitation to set a new password → effect on security: no self-service recovery path; admins handle every forgotten password, and an admin who forgets needs the operator
- Recommendation: A, because it is the standard path Fortify provides and admins keep their second factor. Can be deferred to ACC-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-068 — No third-party host at runtime
- Surface: security
- Source: assumption review: `02` §5: "No page MAY load fonts, scripts, styles or tiles from a third-party host at runtime." (D-018)
- Question: May pages load fonts, scripts, styles or tiles from third-party hosts (CDNs)?
- Options:
  - A) Nothing is loaded from a third-party host; everything is bundled and served by the product → effect on security: no third party sees visitors' IPs or can inject script
  - B) Public CDNs are allowed (e.g. Google Fonts) → effect on security: CDN operators receive visitor IPs and become part of the page's trust
- Recommendation: A, because it matches your choices to keep guest IPs away from map and error-tracking providers. Can be deferred to FND-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-069 — Staff may mark a turnover done
- Surface: security
- Source: assumption review: `05` §1: "... and staff MAY also mark it done." (D-029)
- Question: Who may mark a turnover done?
- Options:
  - A) The assigned cleaner through their link, and staff → effect on security: staff can record a cleaner's work as done on their behalf
  - B) Only the assigned cleaner → effect on security: only the cleaner can assert completion; records stall when the cleaner does not act
- Recommendation: A, because a cleaner without a phone at hand must not block the record. Can be deferred to RES-04.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-070 — How far ahead the cleaner link shows
- Surface: security
- Source: assumption review: `08` §3: "It MUST cover today to 60 days ahead plus pending turnovers from the previous 7 days." (D-030)
- Question: Which of a cleaner's turnovers does the cleaner link show?
- Options:
  - A) Today to 60 days ahead, plus pending ones from the previous 7 days → effect on security: a leaked link exposes about two months of addresses and dates
  - B) All future turnovers → effect on security: a leaked link exposes the cleaner's whole future schedule
  - C) Today and tomorrow only → effect on security: minimal exposure; no planning ahead for the cleaner
- Recommendation: A, because it covers a season's planning horizon week by week. Can be deferred to OUT-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-071 — One page for every inactive link
- Surface: security
- Source: assumption review: `08` §4: "A dead, revoked or unknown link MUST return the same generic page, revealing nothing about whether it existed." (D-032)
- Question: What does an expired, revoked, cancelled or unknown guest or cleaner link show?
- Options:
  - A) One identical page in every case, telling the visitor to contact the host → effect on security: no response reveals whether a link ever existed
  - B) A distinct message per case (expired, revoked, unknown) → effect on security: responses confirm which links exist or existed
- Recommendation: A, because it still tells a real guest what to do. Can be deferred to OUT-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-072 — Link tokens stored only as hashes
- Surface: security
- Source: assumption review: `10` §2: "Guest and cleaner links MUST carry a 256-bit random token of which only a SHA-256 hash is stored; revoking deletes the hash, reissuing creates a new token." (D-013)
- Question: How are guest and cleaner link tokens generated and stored?
- Options:
  - A) A 256-bit random token per link, only its hash stored, revocable one by one → effect on security: a database leak yields no usable links
  - B) Laravel signed URLs (a signature over the record ID) → effect on security: one link cannot be revoked without invalidating every link
  - C) Random tokens stored in clear → effect on security: anyone who reads the database can open every guest and cleaner page
- Recommendation: A, because it is the only option that is both revocable per link and safe against a database leak. Can be deferred to PRP-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-073 — What logs never contain
- Surface: security
- Source: assumption review: `10` §3: "Logs, exception reports and audit views MUST NOT contain IBANs, link tokens, passwords, second-factor secrets, or guest surnames, phones or emails." (D-017)
- Question: Which data is kept out of logs, exception reports and audit views?
- Options:
  - A) IBANs, link tokens, passwords, second-factor secrets and guest surnames, phones and emails never appear → effect on security: logs and their copies hold no credentials or guest contact data
  - B) Only credentials (passwords, tokens, secrets) are redacted → effect on security: IBANs and guest contact data reach logs, which are kept and copied more freely than the database
- Recommendation: A, because logs outlive the retention you set for the database. Can be deferred to FND-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-074 — Rate limiting and no email enumeration
- Surface: security
- Source: assumption review: `10` §9: "Login, reset, invitation and sign-up forms MUST be rate limited and MUST NOT reveal whether an email has a login." (D-033)
- Question: Are the authentication forms rate limited, and do they hide whether an email has a login?
- Options:
  - A) Rate limited per email and IP; identical responses whether or not the email exists → effect on security: guessing is throttled and nobody can test which emails have logins
  - B) Rate limited, but forms say "no login with this email" → effect on security: friendlier errors, and anyone can test which people have logins
- Recommendation: A, because owner and staff email lists are exactly what a phishing attempt needs. Can be deferred to ACC-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-075 — HTTPS for every request
- Surface: security
- Source: assumption review: `11` §2: "Every request MUST be served over HTTPS." (D-034)
- Question: Must every request be served over HTTPS?
- Options:
  - A) Every request, including guest and cleaner pages → effect on security: link tokens and personal data never cross the network in clear
  - B) Only logged-in surfaces → effect on security: guest and cleaner tokens and pages can travel in clear
- Recommendation: A, because the guest page carries access instructions and Wi-Fi. Can be deferred to OPS-03.
- Blocks: specification
- Answer: A (production only; local development runs on plain HTTP) (2026-10-09)

### Q-076 — Operator commands are logged
- Surface: security
- Source: assumption review: `11` §4: "... with Artisan commands on the server, each logged with command, arguments and time" (D-023)
- Question: Are the operator's server commands logged?
- Options:
  - A) Every operator command is logged with command, arguments and time → effect on security: approvals, suspensions, deletions and data exports leave a record
  - B) Not logged → effect on security: cross-account operator actions leave no trace
- Recommendation: A, because the operator is the only actor that touches every account. Can be deferred to ACC-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-077 — Restore rehearsal before launch
- Surface: scope
- Source: assumption review: `11` §5 and `12` §7: "A restore MUST be rehearsed before the first external account goes live." (D-019)
- Question: Is a rehearsed restore from backup a precondition for the first external account?
- Options:
  - A) Yes, part of the release gate → effect on scope: the MVP release includes a proven restore
  - B) No → effect on scope: launch with untested backups; recovery is proven only when needed
- Recommendation: A, because an untested backup is not known to be a backup. Can be deferred to OPS-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-078 — New commercial promises go through the scope matrix
- Surface: scope
- Source: assumption review: `13` §Coverage rule: "Any future commercial promise MUST be added here before implementation and classified as MVP, Future or Out of Scope; a code change alone does not change product scope." (D-004)
- Question: Must every new commercial promise be classified in the scope matrix before it is built?
- Options:
  - A) Yes; code alone never changes scope → effect on scope: scope changes only through an entry you see
  - B) No; tickets or code may extend scope directly → effect on scope: the product can grow without your classification
- Recommendation: A, because it is the only point where you see scope change before it is built.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-079 — Change control and agent latitude
- Surface: scope
- Source: assumption review: `14` §6: "The ADR is a `DECISIONS.md` entry of type `adr` carrying `Owner approval: pending` ... Small implementation details may be decided locally if they preserve the locked behavior and are recorded in `DECISIONS.md`." (D-002)
- Question: What may an implementation agent decide without you?
- Options:
  - A) Small details that keep locked behaviour, recorded in DECISIONS.md; any change to a locked decision needs an ADR you approve → effect on scope: agents move without waiting on you, locked decisions never move without you
  - B) Nothing without your approval → effect on scope: every implementation detail waits for you
- Recommendation: A, because it keeps you on decisions and off tooling.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-080 — Expenses absorbed by the account
- Surface: external
- Source: input audit: `06` §6: "An expense MUST be either charged to the owner or absorbed by the account"; the base plan's payout formula subtracts "owner-charged expenses" but never says other expenses exist
- Question: Can an expense be recorded as absorbed by the company rather than charged to the owner?
- Options:
  - A) Yes; each expense is charged to the owner or absorbed, and only charged ones reduce the payout → effect on external: the company can record its own costs on a property without billing the owner
  - B) No; every expense recorded is charged to the owner → effect on external: costs the company absorbs stay outside the product
- Recommendation: A, because the base plan's wording "owner-charged expenses" implies the other kind, and keeping every euro in one place is the product's purpose. Can be deferred to MON-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-081 — Where owner-paid cleaning appears on a statement
- Surface: external
- Source: assumption review: `05` §2: "An owner-paid turnover cost MUST be deducted on the line of the reservation whose check-out created it" (D-015)
- Question: Where does an owner-paid turnover cost appear on the owner's statement?
- Options:
  - A) On the line of the reservation whose check-out created it → effect on external: cleaning reads as part of each stay's share; expenses list maintenance and consumables
  - B) In the expenses section → effect on external: cleaning reads as a separate expense; payout is the same
- Recommendation: A, because it follows the formula in your base plan. Can be deferred to MON-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-082 — Timezone of the statement month
- Surface: external
- Source: assumption review: `06` §4: "... the month of its check-out date, in Europe/Athens" (D-011)
- Question: In which timezone is a check-out date, and so a statement month, decided?
- Options:
  - A) Europe/Athens → effect on external: a stay checking out on the last day of a month counts in that month as staff and owners see it
  - B) UTC → effect on external: events near midnight can fall into a different month's statement and payout
- Recommendation: A, because every property is in Greece. Can be deferred to MON-01.
- Blocks: specification
- Answer: The timezone of the property, set when the property is set up (2026-10-09)

### Q-083 — Finalising with missing money lines
- Surface: external
- Source: assumption review: `06` §9: "A draft MUST NOT be finalised while a counting reservation has no money lines." (D-028)
- Question: Can a statement be finalised while a reservation in it has no money lines?
- Options:
  - A) No; finalisation is refused and the draft lists those reservations → effect on external: a payout is never frozen with a stay counted as zero; month close waits for complete entry
  - B) Yes, with a warning; missing lines count as zero → effect on external: a statement can be frozen with a wrong payout, corrected only by a later adjustment
- Recommendation: A, because operations staff enter reservations without amounts, so a missing amount is normal before review. Can be deferred to MON-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-084 — Dashboard figures
- Surface: external
- Source: assumption review: `09` §2: "Occupancy MUST be nights of confirmed non-owner-stay reservations falling in the month divided by nights in the month, and income MUST follow the check-out month rule" (D-022)
- Question: How are dashboard occupancy and income computed?
- Options:
  - A) Occupancy counts sold nights only; income follows the statement month rule → effect on external: dashboard income always agrees with statements
  - B) Occupancy includes owner stays; income allocated per night → effect on external: occupancy shows any use of the property, and income disagrees with statements for stays crossing a month
- Recommendation: A, because two income figures that disagree invite the disputes the product exists to remove. Can be deferred to MON-06.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-085 — Database on the same host
- Surface: external
- Source: assumption review: `11` §2: "Production MUST run with Docker Compose on that host: application, queue worker, scheduler and PostgreSQL, behind a TLS-terminating proxy with automatically renewed certificates." (D-034)
- Question: Does production run PostgreSQL itself on the one VPS?
- Options:
  - A) Yes; everything runs on the one VPS, including PostgreSQL, with automatic certificates → effect on external: no provider beyond the VPS host holds the data; the operator runs the database
  - B) Managed PostgreSQL at a provider → effect on external: a further provider and monthly cost; database operations handled by them
- Recommendation: A, because it keeps one provider and the lowest cost at MVP scale. Can be deferred to OPS-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-086 — Where backups are stored
- Surface: external
- Source: assumption review: `11` §5: "PostgreSQL MUST be dumped nightly together with receipt files to storage of the same provider in an EU region" (D-019)
- Question: Where are backups stored?
- Options:
  - A) Storage of the same hosting provider, EU region → effect on external: no further third party holds data; a provider-wide failure affects data and backups together
  - B) A second provider in the EU → effect on external: an additional third party with its own terms holds every account's data, and survives a failure of the first
- Recommendation: A, because it adds no provider; choose B if you want protection from losing the hosting account itself. Can be deferred to OPS-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-087 — Operations enter reservations without amounts
- Surface: ux
- Source: input audit: `04` §2: "A reservation entered by operations MUST be saved without money lines for an admin to complete."
- Question: How do reservations that operations staff enter get their money lines?
- Options:
  - A) Operations save the reservation without amounts; an admin completes the money lines later, and finalisation waits for them → effect on ux: the "run a month" journey has a separate admin step to complete amounts
  - B) Only admins enter reservations → effect on ux: operations cannot enter reservations, contrary to their role in the base plan
- Recommendation: A, because the base plan gives operations reservations but never amounts. Can be deferred to RES-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-088 — Turnovers created without a cleaner
- Surface: ux
- Source: assumption review: `05` §1: "it MAY be created unassigned and reassigned while pending" (D-029)
- Question: Must a turnover have a cleaner when it is created?
- Options:
  - A) No; it is created unassigned and staff assign it later → effect on ux: entering a reservation never stops to choose a cleaner; assignment is its own step
  - B) Yes; a cleaner is chosen when the reservation is saved → effect on ux: reservation entry requires choosing a cleaner on the spot
- Recommendation: A, because the cleaner is often chosen after the reservation is entered. Can be deferred to RES-04.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-089 — Account-active email
- Surface: ux
- Source: assumption review: `09` §7 and `11` §4: approving an account "sends the account-active email" (D-035)
- Question: Does the product email the first admin when the operator approves their account?
- Options:
  - A) Yes, with a login link → effect on ux: the sign-up journey ends with a signal that the account is ready
  - B) No → effect on ux: the applicant must check back or be told outside the product
- Recommendation: A, because otherwise a self-service sign-up ends in silence. Can be deferred to ACC-02.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-090 — Guest link expiry in the property's timezone
- Surface: security
- Source: raised by the answer to Q-082 (statement month in the property's timezone); Q-014 fixed the guest link's end at "23:59 Europe/Athens on the check-out day" (`08` §2, `10` §2, `14` §2)
- Question: In which timezone does a guest link stop working at 23:59 on the check-out day?
- Options:
  - A) The property's timezone; the link works from creation until 23:59 on the check-out day there → effect on security: access ends at the end of the guest's last day where they stay; this replaces Q-014's Europe/Athens wording
  - B) Europe/Athens, as Q-014 says → effect on security: for a property in another timezone the link stops up to some hours earlier or later than the end of the guest's local check-out day
- Recommendation: A, because the guest's check-out day is a day at the property, and every other property date now follows its timezone (D-040). Choosing A supersedes Q-014; choosing B keeps it.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-091 — What recording a payout stores
- Surface: data
- Source: assumption review round 2: `06` §9: "Recording the payout MUST store the date paid" (D-038)
- Question: When an admin marks a statement paid, what does the product store?
- Options:
  - A) The date the payout was paid → effect on data: every paid statement carries a payment date that can be matched to a bank statement
  - B) Only a paid flag with the time it was recorded → effect on data: the product shows that a statement was paid, not when the money left
- Recommendation: A, because the pack currently assumes it and reconciliation needs the date. Can be deferred to MON-03.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-092 — Default timezone for a new property
- Surface: data
- Source: assumption review round 2: `03` §2: "A property MUST carry a timezone, chosen by staff when the property is set up, defaulting to Europe/Athens." (D-040, after Q-082)
- Question: When staff set up a property, is its timezone prefilled?
- Options:
  - A) Prefilled with Europe/Athens and changeable → effect on data: every property has a timezone from creation; one outside Greece needs a deliberate change
  - B) No default; staff must choose one for every property → effect on data: no property gets a timezone by accident, at the cost of one more required field
- Recommendation: A, because the product is for Greek properties and the field stays editable. Can be deferred to PRP-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-093 — A finalised statement never returns to draft
- Surface: data
- Source: input audit round 2: `06` §9: "A finalised statement MUST NOT return to draft." (the base plan says finalised is frozen and later edits go to next month, not that finalisation cannot be undone)
- Question: Can an admin undo the finalisation of a statement?
- Options:
  - A) No; once finalised it stays finalised, and corrections are adjustments on a later month → effect on data: a finalised statement and its snapshot are permanent records
  - B) Yes, until the payout is recorded as paid → effect on data: a finalised snapshot can be discarded and recomputed; the owner may have seen numbers that later change
- Recommendation: A, because the owner is emailed on finalisation (Q-021), so undoing it would change numbers the owner has already been sent.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-094 — Where the server gets the current account from
- Surface: security
- Source: assumption review round 2: `02` §3: "Staff and owners MUST get it from their login, guests and cleaners from their link." (D-038)
- Question: How does the server decide which account a request belongs to?
- Options:
  - A) From the login for staff and owners and from the link for guests and cleaners; nothing in the URL selects an account → effect on security: the tenant boundary depends only on the credential presented
  - B) From a per-account address (subdomain or path) checked against the login or link → effect on security: the account is named in every request and must be cross-checked, a second place where isolation can fail; each account gets its own address
- Recommendation: A, because it follows from one login belonging to one account (Q-001) and gives isolation a single point of failure to test. Can be deferred to ACC-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-095 — Staff roles are fixed
- Surface: security
- Source: input audit round 2: `07` §2: "roles are not configurable" (the base plan names two roles but does not say accounts cannot change them)
- Question: Can an account change what the admin and operations roles may do, or add roles?
- Options:
  - A) No; the two roles and their permissions are fixed for every account → effect on security: one permission matrix, tested cell by cell, for all accounts
  - B) Yes; admins can adjust permissions or add roles → effect on security: each account has its own matrix, which isolation and permission tests must cover per configuration
- Recommendation: A, because the base plan defines the two roles exactly and a configurable matrix multiplies what must be tested.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-096 — Timezone of other dates
- Surface: external
- Source: assumption review round 2: `06` §4: "Every other date tied to a property MUST be read in the property's timezone, and dates not tied to a property in Europe/Athens." (D-040)
- Question: Which timezone applies to dates other than the statement month (turnover day, cleaner link 'today', retention deadlines, the fixed monthly fee's last day)?
- Options:
  - A) Property-bound dates in the property's timezone; dates not tied to a property in Europe/Athens → effect on external: a stay, its turnover and its statement month share one calendar; fixed fees and retention deadlines fall on Greek calendar days
  - B) Only the statement month in the property's timezone; everything else in Europe/Athens → effect on external: for a property outside Greece a turnover can fall on a different day than its check-out
- Recommendation: A, because it extends your Q-082 answer to every date of the same stay. Can be deferred to MON-01.
- Blocks: specification
- Answer: A (2026-10-09)

### Q-097 — Guest link on a cancelled reservation
- Surface: security
- Source: input audit round 5: `08` §2: "... and MUST stop working at once if the reservation is cancelled." (the base plan says only "Expires after checkout"; Q-090 sets the expiry time)
- Question: Does a guest link stop working as soon as its reservation is cancelled?
- Options:
  - A) Yes, at once → effect on security: a guest who cancelled can no longer read the address, access instructions or Wi-Fi
  - B) No, it keeps working until 23:59 on the original check-out day → effect on security: a cancelled guest keeps access details for a stay that will not happen
- Recommendation: A, because access details are for guests who are coming. Can be deferred to OUT-02.
- Blocks: specification
- Answer: A (2026-10-09)
