# Revision 09 — extended experience and duration typography

This sample supersedes revision 08 for visual review, but is not yet locked. Component implementation remains paused.

- Fictional career: 138 service months, 23 distinct vessels, six companies. Dates are company calendar ranges; durations exclude gaps between service periods.
- Experience is deliberately split after the third company and ends near the middle of page two.
- Company duration typography: 16 pt instead of 19 pt.
- Summary retains years/months, with Barlow 25 pt numbers and Source Sans 3 14 pt units. All three metric stacks use the same 3 mm gap, previously 1.5 mm.
- Global `vessel-durations` input defaults to `true`. With `false`, each vessel row has only ship name and a right-aligned rank. No per-row visibility option exists. This is a display setting; service data remains available for totals.
- Hero, certificate and education/language styling remain from revision 08. More experience shifts the latter sections down on page two.
- Both duration modes compile to two pages. Primary delivery shows durations; hidden mode is a development verification build.

Before implementing the component plan, incorporate company/type/vessel nesting and this global visibility policy into its contracts.
