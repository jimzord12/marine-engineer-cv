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
| D1 captain | Pending | |
| D2 silver | Pending | |
| E1 boundary review | Pending | |
| E2 docs/delivery | Pending | |
