# Sample 08 — company-based experience

Component-library implementation is paused. Revision 07 remains the previously approved visual reference; revision 08 is a new sample awaiting visual approval. The September 9 component plan must be revised against the next locked sample before execution, particularly its voyage-entry architecture, data model and summary metrics.

## Changes

- Hero right column: Email, Discipline, Rank. Rank wording is Second Engineer; the supplied YPI reference uses 2nd Engineer.
- Experience: company → vessel type → vessel, with rank and accumulated service duration for each ship. No machinery specifications or responsibility descriptions.
- Company calendar ranges show the outer employment period, while durations represent accumulated service months and exclude time between contracts.
- Durations use whole months, displayed as years and months. The sample is newly fictional, not a conversion or rounding of the old 926-day dataset.
- Summary derives from data: 66 months = 5 years 6 months, 7 unique vessel IDs, 3 companies. Repeated service on the same vessel should aggregate under its ID rather than inflate vessel count.
- Certificates retain the original wording, rows, column widths, typography, padding and colors. Their page position changes because experience now fits on page one.
- Education & languages replaces Engineering toolkit and the old bottom details. Both are arrays so further entries can be appended. The school/qualification wording and language proficiency are illustrative, to be confirmed before a real candidate CV.

## Review approach

Keep two pages and do not invent credentials to fill whitespace. Page two intentionally has capacity for additional certificates and education. The new sample is not locked and no component library or captain variant has been implemented.

Build: `typst compile --root . --font-path fonts designs/08-flagship-company.typ <new-output-path>.pdf`
