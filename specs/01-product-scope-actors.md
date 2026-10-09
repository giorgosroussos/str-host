# 01 — Product, Scope and Actors

What the product is, who uses it, and what the first release contains.

## 1. Product

- The product MUST give an account one place for its properties, owners, reservations, turnovers, expenses and money, and MUST produce each owner's monthly statement and payout without a spreadsheet. [input]
- The product MUST NOT push prices or availability to any platform, take bookings, issue invoices, report to myDATA, or message guests or cleaners. [input]

## 2. Accounts

- The customer is the account; each account is a tenant of one shared installation. [input]
- An account MUST be usable both as a management company (5–60 properties owned by others) and as an individual host (1–5 properties of its own) with one model and no account-kind switch. [input]
- A property owned by the account itself MUST carry no management fee, produce no owner statement and have no owner portal; the account's monthly view replaces the statement (`06` §9). [input]
- An account MAY have both self-owned properties and properties of owners; a host who takes on someone else's property adds an owner. [input]

## 3. Actors

| Actor | Gets in by | Sees |
| --- | --- | --- |
| Staff (admin, operations) | Login | Their own account, limited by role (`07` §2) |
| Owner | Login to the owner portal | Only their own properties, reservations, expenses and finalised statements (`08` §1) |
| Guest | Signed link per reservation, no account | Only their own stay (`08` §2) |
| Cleaner | Signed link per cleaner, no account, revocable | Only their own upcoming turnovers (`08` §3) |

- Owners, guests and cleaners MUST only ever see the narrow view their row describes. [input]

## 4. Getting an account

- A company or host MUST be able to sign up publicly with a name, an email address and a password, and MUST verify the email address. [Q-019]
- A signed-up account MUST stay pending until the operator approves it with a server command (`11` §4); no login to a pending account succeeds. [Q-046]
- The person who signs up MUST become the account's first admin. [Q-019]
- Sign-up MUST record acceptance of the operator's terms (`10` §8). [Q-047]
- The product MUST NOT charge accounts: no plans, limits or payment provider. [Q-020]

## 5. MVP capabilities

The MVP MUST provide: [input]

- properties and owners, with commercial terms per property (`03`, `06` §2);
- reservations with money lines, a calendar per property and a multi-property timeline (`04`);
- turnovers at every check-out, assigned to cleaners (`05`);
- monthly owner statements that are drafted, reviewed, finalised and marked paid (`06`);
- a read-only owner portal (`08` §1);
- a guest page per reservation (`08` §2);
- a cleaner link per cleaner (`08` §3).

The MVP MUST also provide: [Q-022, Q-021, Q-023, Q-024]

- receipt files on expenses, visible to the owner on finalised statements; [Q-022]
- a PDF of every statement and an email to the owner when it is finalised; [Q-021]
- a monthly pay summary per cleaner for admins; [Q-023]
- an admin dashboard of occupancy and income per property per month (`09` §2). [Q-024]

## 6. Future (phase 2)

These are anticipated and MUST NOT be built in the MVP: [input]

- iCal import of dates from Airbnb and Booking.com;
- channel APIs, two-way sync, pricing;
- guest identity collection for registration obligations, online check-in;
- invoicing, myDATA, tax reports for owners;
- online payments to owners;
- messaging guests or cleaners by email, SMS or WhatsApp;
- maintenance tickets and inventory of consumables.

## 7. Out of Scope

- Billing accounts for the product. [Q-020]
- Importing owners, properties or reservations from files; all data is entered in the product. [Q-025]
- Blocked dates without a reservation; the calendar holds reservations and owner stays only. [Q-026]
- Co-owned properties with payout shares (`03` §3). [Q-003]
- Custom domains per account. [Q-041]
- Any web role that sees more than one account. [Q-012]

## 8. Definition of done for the MVP

- A company MUST be able to onboard its owners and properties, enter a month of reservations, run that month's turnovers, and send each owner a finalised statement whose payout matches a hand calculation to the cent (`12` §5). [input]
- Owners MUST be able to log in and see only their own data, and every guest MUST get a link that shows their stay and nothing else. [input]
