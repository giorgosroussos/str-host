# STR Host — base plan (draft v0, 2026-10-09)

Working draft, written together before the design-pack run. Lines marked **Open:** are choices still to settle here; anything we don't settle becomes a design-pack decision card.

## 1. The product in one paragraph

A back-office tool for short-term rentals in Greece, listed on Airbnb, Booking.com and direct. It serves two kinds of customer with one model: a **management company** that runs 5–60 holiday apartments and villas on behalf of their owners, and an **individual host** who runs 1–5 of their own. An individual host is an account whose properties are owned by the account itself: the same reservations, turnovers and money lines, with no management fee, no statement to send and no owner portal. A host who later takes on someone else's property simply adds an owner. Today they run it on Excel, the platforms' own dashboards, WhatsApp with cleaners, and a monthly statement typed by hand for each owner. The tool puts every property, reservation, turnover and euro in one place, and produces the owner's monthly statement and payout without a spreadsheet.

**The customer is the account** (management company or host), not the owner and not the guest. Owners and guests are outside users with deliberately narrow views.

**What it is not:** not a channel manager (it does not push prices or availability to the platforms), not a booking engine, not accounting software (no invoices, no myDATA), not a guest messaging tool.

## 2. Actors

| Actor | How they get in | What they see |
|---|---|---|
| Company staff | Login | Everything of their own company |
| Property owner | Login (owner portal) | Only their own properties, reservations, expenses and statements |
| Guest | Signed link per reservation, no account | Only their own stay: arrival details and house info |
| Cleaner | Signed link per cleaner, no account; revocable by staff | Only their own upcoming turnovers (property address, date, times, notes); can mark one done. Never guest names beyond first name, never money |

Several accounts share one installation; each is a tenant, and no account ever sees another's data. For a self-owned property, the account's own monthly view replaces the owner statement (income, deductions, expenses, net).

Staff have two roles: **admin** (everything) and **operations** (properties, reservations, turnovers, cleaners; never amounts, terms, expenses or statements).

## 3. MVP pillars

1. **Properties & owners.** Owners (name, contact, IBAN for payouts), properties (address, owner, AMA registry number, capacity, check-in/out times, house info for guests, Wi-Fi, house rules), and the commercial terms per property (management fee model, who keeps the cleaning fee).
2. **Reservations & calendar.** Reservations per property: channel (Airbnb / Booking.com / direct / owner stay), dates, guests, and the money lines (gross amount, channel commission, cleaning fee, climate resilience fee, other taxes). A calendar per property and a multi-property timeline. Overlapping reservations on the same property are refused.
3. **Turnovers.** Every checkout creates a cleaning/turnover task for that day, assigned to a cleaner, with a status (pending → done) and a cost charged to the owner or absorbed by the company according to the property's terms.
4. **Owner statements & payouts.** Per owner per month: reservations that count in the month, the deductions, management fee, expenses (maintenance, consumables, cleaning where owner-paid), and the payout. A statement is drafted, reviewed, **finalised** (frozen; later edits go to next month as adjustments), and the payout is recorded as paid.
5. **Owner portal.** The owner logs in and sees their properties, the calendar, reservations and finalised statements. Read-only.
6. **Guest page.** A signed link per reservation: address and map link, check-in time and instructions, Wi-Fi, house rules, contact number. Expires after checkout.

## 4. The money (the part that must be right)

Proposed calculation per reservation, all amounts in EUR, stored in cents:

```
gross (what the guest paid on the channel)
− channel commission (host-side fee)
− climate resilience fee (passed to the state)
= net rental income
− management fee (on the property's terms)
− cleaning (if owner-paid)
= owner share of this reservation
```

Owner payout for a month = Σ owner shares − owner-charged expenses ± adjustments from earlier finalised months.

- Management fee models, one per property: **% of net** (default), **% of gross**, **fixed per reservation**, **fixed monthly** (charged per property per month, even in a month with no reservations).
- **Open (for design-pack):** a month whose deductions exceed the income (e.g. a fixed monthly fee with no bookings) gives a negative payout. Proposal: no payout, and the negative balance carries forward to the next month.
- A reservation counts, whole, in the month of its **check-out date**.
- Who keeps the cleaning fee the guest pays is a **per-property setting** (company or owner).
- **Open (for design-pack):** the climate resilience fee (amount per night by season and property type). Proposal: a per-account table of rates staff maintain, not hard-coded; the current rates need confirming.
- The guest page never shows any amount. The owner portal never shows another owner, and never internal notes.

## 5. Guardrails (never broken)

1. **Tenant isolation.** Every tenant table carries `company_id`, derived on the server; isolation tests on every model and every action, always green.
2. **Owner isolation inside a tenant.** An owner sees only their own properties, with tests as strict as tenant isolation.
3. **Guest page and cleaner link leak nothing.** No money, no owner, no other reservation, no guest personal data beyond the first name.
4. **Finalised statements are frozen.** No edit changes a finalised statement's numbers. Corrections are adjustments in a later month.
5. **Money is integers.** Cents, never floats; rounding rules written down and tested.
6. **UUID primary keys** everywhere; nothing guessable in a URL.

## 6. Outside MVP (phase 2)

- iCal import from Airbnb and Booking.com (dates only, not money). The MVP uses manual entry.
- Channel APIs, two-way sync, pricing.
- Guest identity collection for registration obligations; online check-in.
- Invoicing, myDATA, tax reports for owners.
- Online payments to owners (we only record that a payout was made).
- Messaging guests or cleaners (email/SMS/WhatsApp).
- Maintenance tickets beyond a simple expense line; inventory of consumables.

## 7. Stack (fixed)

Laravel 13 (PHP 8.3) · PostgreSQL 16 · Inertia + Vue 3 (TypeScript) + Tailwind 4 + PrimeVue 4 · Laravel Fortify · multi-tenancy with `company_id` + global scope · Pest tests on real PostgreSQL · Docker Compose for the database.

UI in **Greek and English** from day one: staff and owners choose their language; the guest page and cleaner link follow the language set on the reservation / cleaner.

## 8. Done for the MVP

A company can onboard its owners and properties, enter a month of reservations, run that month's turnovers, and send each owner a finalised statement whose payout matches a hand calculation to the cent. Owners can log in and see only their own data, and every guest gets a link that shows their stay and nothing else.
