# 08 — Outside Views

The three narrow views for people outside the account's staff. What they may never show is the point of this file.

## 1. Owner portal

- The owner portal MUST be read-only. [input]
- It MUST show the owner's properties, their calendars, their reservations and their finalised statements. [input]
- It MUST show only properties and dates covered by the owner's own ownership periods. [input, Q-004]
- Reservations MUST show dates, channel, guest count and the guest's first name, and no amounts. [Q-016, Q-017]
- Finalised statements MUST show every line, the receipts of owner-charged expenses, and a PDF download. [Q-021, Q-022]
- It MUST NOT show internal notes, other owners, draft statements, or any other owner's record. [input, Q-017]
- It MUST use the owner's chosen language and the account's name and logo (`09` §5). [input, Q-041]

## 2. Guest page

- Each reservation MUST have one guest link, and the product MUST NOT send it to the guest itself (`01` §1). [input]
- The page MUST show the address, an embedded map served from the product's own server with an "open in maps" link, check-in time and instructions, Wi-Fi, house rules and a contact number. [input, Q-037, Q-049]
- The contact number MUST be the property's own when set, otherwise the account's. [Q-064, D-016]
- The page MUST NOT show any amount, the owner, any other reservation, or any guest data beyond the first name. [input]
- The page MUST work from the link's creation until 23:59 on the check-out day in the property's timezone, and MUST stop working at once if the reservation is cancelled. [Q-090, Q-097]
- Text MUST appear in the reservation's language, falling back to the other language when that version is empty. [input, Q-042]
- The page MUST carry the account's name and logo. [Q-041]

## 3. Cleaner link

- The link MUST list only that cleaner's turnovers: property address, date, check-out and check-in times, and notes. [input]
- It MUST cover today to 60 days ahead plus pending turnovers from the previous 7 days. [Q-070, D-030]
- The cleaner MUST be able to mark a listed turnover done. [input]
- It MUST NOT show any guest name beyond the first name, any amount, the owner, or any turnover of another cleaner. [input]
- It MUST stay valid until staff revoke or reissue it, and archiving the cleaner revokes it. [Q-015, Q-010]
- Text MUST appear in the cleaner's language, falling back to the other language when empty. [input, Q-042]

## 4. Shared rules

- Guest and cleaner pages MUST be designed for phones first (`09` §8). [Q-044]
- A dead, revoked or unknown link MUST return the same generic page, revealing nothing about whether it existed. [Q-071, D-032]
