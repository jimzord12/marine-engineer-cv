# 0003. Explicit, validated pagination

Date: 2026-09-09
Status: Accepted

## Context

Typst flows content across pages automatically, but the approved design
depends on where the split falls: which companies open page two, where the
synopsis sits, that education anchors to the bottom. Automatic flow would
place these differently for every candidate, and automatic font shrinking
would silently degrade the typography.

## Decision

The layout carries a `pages` array naming the companies, or row ranges of a
company, on each page and which page carries synopsis, certificates and
education. `validate-pages` proves every vessel row is placed once, in
order, with the closing sections in a legal position. After each page the
template asserts the page counter and fails on overflow with a message that
names the fix. Fonts are never shrunk automatically.

## Consequences

- A new candidate needs a human to choose the split and look at the result.
- Overflow is a compile error, not a surprise third page.
- Totals are computed from the whole candidate, so a split never changes
  numbers.
- Very long careers need row ranges and a continued marker, covered by
  `tests/fixtures/pagination.typ`.
