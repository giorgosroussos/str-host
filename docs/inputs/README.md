# Inputs

Raw material the specification pack was written from, received 2026-10-09. Files here are copied verbatim and never edited; if the owner supplies a revision, it is added as a new file with its date.

| File | Received | Kind | Authority |
| --- | --- | --- | --- |
| `requirements/base-plan.md` | 2026-10-09 | requirements | authoritative; §7 (stack, languages) is authoritative (constraints) |

## What each authority level means

- **Authoritative.** A requirements source. Every normative statement in `specs/` that restates it carries the `[input]` tag. Where two authoritative inputs disagree, the disagreement is a question card in `QUESTIONS.md`, not a choice.
- **Authoritative (constraints).** Fixes the stack, deployment, jurisdiction, budget or existing systems. Statements restating it are `[input]`. Constraints the inputs do not fix are cards.
- **Non-authoritative.** Direction only: look, tone, layout, examples of what a competitor does, an earlier draft. Specifications win on behaviour. Each behavioural conflict between such an input and the requirements is a card, and the input is never cited as the provenance of a normative statement.

Lines of `base-plan.md` marked **Open:** and stated as a proposal are not settled requirements: each is a question card, with the proposal as a candidate option.

## Non-authoritative inputs and their conflicts

No non-authoritative input was received.

## What the inputs do not cover

The inputs fix the stack but not where the product is hosted, by whom, or how it is deployed; they name Greece as the market but state no data-protection or retention posture for owner, guest and cleaner data; they state no budget and no paid third parties (email delivery for logins, maps for the guest page); and they name no existing systems to import from beyond the spreadsheets in use today. The cards that ask for each are listed in `QUESTIONS.md`.
