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
- Q-014 — Guest link validity window — security — Resolved
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
