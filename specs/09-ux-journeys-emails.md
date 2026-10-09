# 09 — UX, Journeys and Emails

How people move through the product, what it looks like to whom, and every email it sends.

## 1. Staff navigation

- The staff app MUST be organised in sections by activity, each listing across all properties: Timeline (home), Dashboard, Reservations, Turnovers, Properties, Owners, Expenses, Statements, Settings. [Q-040, Q-024]
- The Timeline MUST show every property's reservations and owner stays side by side and MUST be the first screen after login. [input, Q-040]
- Operations staff MUST NOT see the Dashboard, Expenses or Statements sections or any amount in the others (`07` §2). [input]

## 2. Dashboard

- Admins MUST see, per property per month, occupancy and net rental income. [Q-024]
- Occupancy MUST be nights of confirmed non-owner-stay reservations falling in the month divided by nights in the month, and income MUST follow the check-out month rule of `06` §4. [D-022]

## 3. Staff journeys

These journeys MUST each work end to end and are the browser tests of `12` §6: [input]

1. **Get an account:** sign up, verify the email, wait for approval, log in as admin (`01` §4).
2. **Onboard:** add owners and invite them, add properties with their terms, add cleaners and send their links.
3. **Run a month:** enter reservations; an admin completes money lines; turnovers appear, are assigned, and are marked done; enter expenses with receipts.
4. **Close a month:** review each owner's draft, finalise it, and record the payout when paid (`06` §9).

## 4. Outside journeys

1. **Owner:** accept the invitation, set a password, log in, read a finalised statement and download its PDF (`08` §1). [input, Q-050, Q-021]
2. **Guest:** open the link sent by staff and read the stay's details (`08` §2). [input]
3. **Cleaner:** open the link, see upcoming turnovers, mark one done (`08` §3). [input]

## 5. Branding

- The owner portal, guest page, cleaner link and emails MUST show the account's name and logo, with a small product mark. [Q-041]
- The staff app MUST show the product's own brand. [Q-041]

## 6. Languages

- Every screen, email and PDF MUST exist in Greek and English. [input]
- Staff and owners MUST choose their language; the guest page follows the reservation's language and the cleaner link the cleaner's. [input]
- A missing interface string MUST fall back to English, and a test MUST fail when the two language files differ in keys. [D-024]

## 7. Emails

The product MUST send exactly these emails, in the recipient's language and from the product's sending domain: [input, Q-036]

| Email | To | Trigger | Provenance |
| --- | --- | --- | --- |
| Verify email | person signing up | sign-up | Q-019 |
| Account active | first admin | operator approval | D-035 |
| Invitation | new staff or owner | admin invites | Q-050 |
| Password reset | staff or owner | reset request | input |
| Statement finalised | owner | admin finalises | Q-021 |

- The statement email MUST carry a link to the portal and no amount. [Q-021]
- The product MUST NOT send any email to guests or cleaners. [input]

## 8. Devices

- Staff screens MUST be designed for desktop first and remain usable on a tablet; the owner portal MUST adapt to any screen; guest and cleaner pages MUST be designed for phones first. [Q-044]

## 9. Accessibility

- Every screen MUST meet WCAG 2.1 AA, checked automatically on every page a browser test visits (`12` §1). [Q-043, D-036]
