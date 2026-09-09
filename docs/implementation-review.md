# V11 library — implementation and review record

Approved plan: `superpowers/plans/2026-09-09-v11-library.md`. Execution is inline in the authorized repository. Each task is reviewed, verified, committed and pushed before the next task. Frozen v11 is never modified.

| Task | State | Review and evidence |
|---|---|---|
| A1 baseline | PASS | Fresh compile equals v11 at 144 dpi and normalized text on both pages. Deliberate added red text rejected for both raster/text. Frozen SHA-256 manifest includes historical assets/data/designs/PDFs/fonts. Verifier creates new evidence directories and detects page-count/font/bounds errors. |
| B1 configuration | PASS | Theme, artwork slots and geometry separated. Assertion fixture compiles with no visible content. Review retained grouped modules and all frozen values. Removed accidentally tracked Python bytecode from the index only (local file preserved) and ignored runtime caches. |
| B2 data | PASS | Red test first (missing module), then valid 0/1/11/12/13/138 duration cases, frozen 138/23/6 totals, repeated vessel deduplication and company-only months. Missing visible months, inconsistent totals and negative months rejected with specific diagnostics. Reviewed separation of normalization, validation and pure totals; frozen JSON untouched. |
| C1 primitives/hero | PASS | Hero region exactly matches v11 at 144 dpi. Missing portrait/contact fixtures compile; excessive name/email receive explicit fit diagnostics. SVG API corrected against official Typst image documentation (`image(bytes(...))`); initial one-pixel edge discrepancy was the fixture's missing background, not component geometry. Related hero pieces retained in one focused module. |
| C2 content | PASS | Content gallery compiled and visually reviewed. Company/type/vessel nesting, metrics, certificate records and appendable education/languages render through focused modules. Hidden durations emit no text and leave vessel/rank coordinates exactly unchanged. Review kept cells owned by the shared grid, not independent row grids. |
| C3 composition | PASS | Public engineer entry point produces two pages with zero raster differences at 144 dpi and identical normalized text on each page. Full hidden-duration build preserves all vessel/rank coordinates and totals. Review found a scoped page-margin rule causing an extra page; moved page policy to the whole page iteration and restored header paragraph inheritance. Exact baseline then passed. |
| D1 captain | PASS | Two-page captain compiled with unchanged theme/layout/components. Original wheel, compass ornaments and chart/bridge backgrounds use palette placeholders. Both pages inspected; no engineer wording leaks into visible text. Same fictional portrait retained deliberately. |
| D2 silver | PASS | Silver theme changes only the theme import; same captain data/art/layout. Two pages visually reviewed and page text matches Classic exactly. Review found legacy SVG secondary colors not following themes; added explicit theme art-color mapping and reran engineer exact regression successfully. |
| E1 boundary review | PASS | 21 reproducible compile cases plus PDF assertions pass (`tests/run.py`). Three-page fixture has 31 vessels, 10 certificates, 2 education and 3 language entries; explicit company split keeps full company totals without duplication. Duplicate allocations and overflow fail explicitly. Certificate headers repeat. Optional fields, company-only months and wrapped duration geometry tested. All decorative art tagged as artifacts. |
| E2 docs/delivery | Pending | |

## Review decisions

- Kept closely related hero functions together; no separate file for every small wrapper.
- Added `src/pagination.typ` when explicit company fragments made validation a separate responsibility. The template now only composes pages; data totals remain independent of page allocations.
- Kept vessel rows as cell arrays owned by a shared grid. Hidden time cells reserve measured geometry but contain no duration text, including when the visible duration wraps.
- Removed the obsolete voyage/machinery/toolkit abstractions from the active API; preserved all historical source files.
- Layout profiles deliberately expose margins, row/company density and the final flexible education gap. No automatic font shrinking or promise of optimal pagination.
- Added missing rank-width fit checks during hero review. Excessive names/contacts/ranks require an explicit typography or geometry adjustment.
- Explicit white page paint initially changed raster compositing across the document. Retained the default unpainted white PDF canvas for white themes; non-white themes can set page fill. Exact v11 comparison passed again.
- No unresolved material finding after the final E1 suite. The three primary PDFs remain two pages; the engineer still matches v11 exactly.
