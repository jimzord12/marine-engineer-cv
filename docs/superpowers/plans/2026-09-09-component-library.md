# Marine CV Component Library Implementation Plan

> **PAUSED — sample redesign requested.** Do not execute this plan until the company-based sample is approved and this plan is revised. See `../../sample-08-review.md`. Company/type/vessel grouping replaces the voyage-based architecture below; summary metrics and education sections also changed.

> **For agentic workers:** REQUIRED SUB-SKILL: Use executing-plans to implement this plan task-by-task. Steps use checkbox syntax for tracking. Execute inline with self-review checkpoints; delegation is not required.

**Goal:** Reproduce the approved two-page engineer CV through reusable Typst components, then produce two captain examples using independent role assets and themes.

**Architecture:** Candidate data, visual theme, illustration pack and document composition are separate inputs. Small content-producing Typst functions compose into sections and the Flagship template. Page flow belongs to the template; illustrations never determine body layout.

**Tech Stack:** Typst 0.15.1, bundled OFL fonts, native SVG, PowerShell; Python/PyMuPDF for development verification only. No hosted service or new runtime required to build a CV.

**Spec:** The approved requirements and design decisions below form the implementation specification for this plan.

## Global constraints / specification

- Preserve `designs/07-flagship-hero.typ`, its input/assets, and `exports/review/07-flagship-hero.pdf` as the frozen reference.
- Preserve existing historical revisions. No deletion, directory cleanup, destructive Git or replacing generated outputs without explicit approval.
- Routine localized source edits are authorized. Build into fresh output directories and keep public examples fictional.
- First deliverable: the same engineer document, same visible wording, two pages, same layout, fonts and colors.
- Do not silently accept a visual redesign as an improvement during extraction. Visual changes require a separately identified decision.
- Two captain deliverables: same Flagship theme with captain illustrations; then the same captain data/layout/illustrations with another color and font theme.
- Captain illustration direction: a restrained ship's wheel around/behind the portrait; bridge/navigation side ornaments and faint page backgrounds. Upper wheel tips may clip at the page boundary, but text, photograph and content must remain clear.
- Themes own colors and font families plus typography settings. Shared layout tokens own spacing and geometry; role packs supply asset-specific placement corrections only.
- Aim for polished two-page reference examples, and demonstrate a deliberate three-page longer-content example. Never shrink all text to force a page count.
- Keep selectable real PDF text, embedded fonts and decorative artwork marked as artifacts. Extraction checks do not constitute commercial ATS certification.
- Documentation in Greek for usage; English CV content and code identifiers.

## Findings from the actual repository

The approved source currently contains page rules, hardcoded colors/fonts, helper functions, data loading, decorations and composition in one file. It selects three voyages for page one and the remainder for page two. The `compact` voyage argument is unused. The default `main.typ` still opens the first prototype. Historical builds and verification reports are useful references but are not a public component API.

Preserve the historical areas in place. Establish a clearly documented active path; avoid moving old assets and breaking historical imports merely to make the folder tree look cleaner.

## Planned active file structure

```text
lib.typ                         public imports; no document side effects
src/
  theme.typ                     theme validation and shared layout tokens
  data.typ                      schema checks and legacy example adapter
  primitives.typ                label, divider, badge, metric, decoration, icon-bullet
  contact.typ                   contact-item and contact-group
  hero.typ                      portrait/frame/backdrop/identity-plate/hero
  sea-service.typ               date-range, vessel-specs, voyage-entry, sea-service-list
  sections.typ                  section-heading, section, profile-summary, expertise-group,
                                details-list, metrics-strip
  certificates.typ              certificate-table
  page.typ                      page-header, page-footer, resume-page document wrapper
  templates/flagship.typ         flagship composition and explicit page plans
themes/
  flagship.typ                  approved navy/teal/brass and original fonts
  silver-bridge.typ              charcoal/silver/white with modern display typography
roles/
  engineer.typ                  original art pack and placement defaults
  captain.typ                   navigation art pack and placement defaults
assets/captain/
  wheel.svg
  ornament-left.svg
  ornament-right.svg
  background-first.svg
  background-continuation.svg
  bullet.svg
examples/
  engineer.typ
  captain.typ
  captain-alternate.typ
content/captain-example.json
tests/
  fixtures.typ                  isolated component gallery and boundary cases
  pagination.typ                long-content and explicit overflow fixtures
  verify.py                     PDF/text/font/render comparisons
  baseline.json                 reference hashes, renderer version and geometry
scripts/build-examples.ps1       safe builds of active examples into fresh directory
docs/
  architecture.md
  customization.md
  review-log.md
```

`main.typ` will select `examples/engineer.typ` once equivalence passes. The existing historical build script remains available; README distinguishes the two build routes. Keep closely related functions together: approximately 27 components does not mean 27 files.

## Interfaces and ownership

Conceptual public entry point (Typst named arguments):

```typst
#import "../lib.typ": flagship
#import "../themes/flagship.typ": theme
#import "../roles/captain.typ": artwork
#let candidate = json("../content/captain-example.json")
#show: flagship.with(candidate: candidate, theme: theme, artwork: artwork,
  pages: (
    (kind: "opening", voyages: (0, 3), metrics: true),
    (kind: "continuation", voyages: (3, 5), credentials: true, toolkit: true),
  ))
```

Page ranges are half-open indices. Validation rejects duplicate/missing voyage indices, invalid bounds and incompatible page kinds. Explicit plans make the approved composition predictable. Long-content examples receive additional planned pages; do not build a speculative automatic page-packing engine.

All rendering functions receive `theme`; only functions drawing role decorations receive `artwork`. Leaf components receive their specific data or child content, never the entire candidate object. No component reads JSON directly, chooses a professional role by string, or sets document-wide page rules except the document wrapper.

| Group | Components and input responsibilities |
|---|---|
| Primitives | `label(body, theme)`, `divider(theme)`, `badge(body, theme)`, `metric(value, caption, theme)`, `decoration(asset, theme)`, `icon-bullet(body, marker, theme)` |
| Contacts | `contact-item(label, value, href, theme)`, `contact-group(items, align, theme)` |
| Hero | `portrait(source, alt, theme)`, `portrait-frame(asset, theme)`, `portrait-backdrop(asset, theme)`, `identity-plate(name, rank, theme)`, `hero(identity, contacts, theme, artwork)` |
| Sea service | `date-range(start, end, days, theme)`, `vessel-specs(fields, theme)`, `voyage-entry(trip, index, theme, artwork)`, `sea-service-list(trips, start-index, theme, artwork)` |
| Sections | `section-heading(number, title, subtitle, theme)`, `section(heading, body)`, `profile-summary(body, illustration, theme)`, `expertise-group(title, items, theme, artwork)`, `details-list(items, theme)`, `metrics-strip(items, theme)` |
| Certificates | `certificate-table(records, theme)` |
| Page | `page-header(identity, caption, theme)`, `page-footer(disclosure, theme)`, `resume-page(theme, artwork, identity, body)` |

This yields 28 small/composed units, not a quota. `resume-page` owns document page defaults and page-aware backgrounds/footers; `flagship` calls it once around the composition. Remove a wrapper if it has no meaningful policy, reuse or readability benefit. Split a function further only when its pieces have independent inputs or layout policies.

Theme semantic color keys: `ink`, `hero`, `accent`, `metal`, `muted`, `surface`, `paper`, `plate`, `rule`, `on-hero`. Font keys: `body`, `display`; named text styles cover labels, body, ship titles, name, rank, metrics and continuation headers. Use explicit tokens for all current sizes, line spacing and tracking. Do not assume white is readable on every surface.

Layout tokens retain the approved A4 margins (16 mm horizontal, 12 mm top, 15 mm bottom), 77 mm hero, 83 mm page-one dark background, 46 mm portrait, 100 mm identity plate, and body spacing 1.5/3/5/7/9 mm. Component-specific dimensions are grouped by component instead of anonymous global numbers.

Artwork slots: `portrait-backdrop`, `portrait-frame`, `hero-left`, `hero-right`, `background-first`, `background-continuation`, `bullet`, `profile-illustration`. Each carries source/content, width and x/y correction as applicable. The theme supplies SVG colors through a small controlled palette substitution/rendering helper. Do not recolor the legacy source files; preserve exact original appearance for the engineer. Captain assets use explicit palette placeholders and must follow both themes, including background opacity.

Data schema: `identity`, two `contacts` groups, `profile`, `voyages`, `metrics`, `certificates`, `expertise`, `details`, `copy`, `disclosure`. A voyage has ship/company/rank/type/start/end/days, an ordered list of `{label, value}` technical fields and a list of responsibilities. Certificates have named `title/scope/issued/review` fields. Labels and section copy are data, not hardcoded engineer terminology. Legacy adaptation preserves current displayed wording. Duration totals are checked against voyage values; regulatory sea-service qualification is outside scope.

## Phase 1 — Establish a measurable reference

### Task 1: Baseline and verification harness
**Files:** create `tests/verify.py`, `tests/baseline.json`; read frozen source/PDF and bundled fonts.

- [ ] Record source, PDF and asset hashes, Typst version, font files, PyMuPDF version and reference page dimensions.
- [ ] Recompile the frozen source into a new build folder and render both existing and newly compiled PDFs using the same renderer at 144 dpi. Investigate any baseline mismatch before extraction.
- [ ] Implement `python tests/verify.py baseline.pdf candidate.pdf --mode exact --output fresh-directory`: require 2 pages, matching normalized extracted text and zero differing rendered pixels; write JSON evidence and difference PNGs. PDF binary equality is not required because metadata can differ.
- [ ] Verify the checker detects a deliberately changed temporary text/color fixture, then run it against two equivalent renders. Never mutate the golden file for a negative test.
- [ ] Record all reviewed results and commit the harness.

**Gate:** We can distinguish an actual visual/content regression from metadata changes.

## Phase 2 — Extract configuration and compose the same document

### Task 2: Theme, artwork and data contracts
**Files:** create `src/theme.typ`, `src/data.typ`, `themes/flagship.typ`, `roles/engineer.typ`, `tests/fixtures.typ`.

- [ ] Extract the semantic palette, fonts, typography and geometry tokens with their exact current values.
- [ ] Define engineer artwork slots using the original asset files and approved offsets: backdrop width 94 mm/y -18 mm; frame 56 mm/y -2 mm; portrait y 3 mm; side ornaments 33 mm/y 48 mm; contact top -2 mm; plate y 45 mm.
- [ ] Implement the legacy data adapter without modifying `content/flagship-example.json`.
- [ ] Validate required fields, positive durations, contact href strings and ordered technical fields with concise actionable errors. Permit optional contacts and empty optional sections.
- [ ] Compile fixtures for valid engineer data, missing required name, optional missing phone, and captain-style vessel fields. Confirm failures explain the offending field.
- [ ] Review for role-specific wording in theme/layout and commit.

### Task 3: Extract primitives and the hero
**Files:** create `src/primitives.typ`, `src/contact.typ`, `src/hero.typ`; extend `tests/fixtures.typ`.

- [ ] Implement the primitive/contact functions and compose the hero from its five named parts.
- [ ] Keep positioning in `hero`; portrait and identity components contain no absolute page coordinates. Maintain clipping only for the portrait and page boundary.
- [ ] Render an engineer hero fixture over the approved dark background and compare its region to the golden PDF.
- [ ] Exercise long name, long email, missing optional contact and absent optional backdrop. Wrapping must stay within assigned bounds; an impossible header must fail clearly or require an explicit layout override, not overlap silently.
- [ ] Review whether each wrapper provides useful policy; keep related small functions in shared files. Commit after visual review.

### Task 4: Extract sea service, sections and document composition
**Files:** create `src/sea-service.typ`, `src/sections.typ`, `src/certificates.typ`, `src/page.typ`, `src/templates/flagship.typ`, `lib.typ`, `examples/engineer.typ`.

- [ ] Reproduce the existing voyage date column, ship/rank row, machinery details and screw bullets using the contracts above. Remove the unused `compact` argument.
- [ ] Build section headings, metrics strip, certificates, expertise and details components with explicit internal spacing; parent sections own external spacing.
- [ ] Compose the approved three-plus-two voyage page plan through `flagship`, preserving current section copy and continuation header.
- [ ] Run exact baseline verification; inspect complete pages and hero/detail crops. Correct all visual changes before accepting extraction.
- [ ] Check public imports do not emit document content or change page settings until the template is called.
- [ ] Review coupling and duplication, then commit the equivalent engineer implementation.

**Gate:** Two-page component-generated engineer CV visually equals the frozen sample and preserves selectable content.

## Phase 3 — Prove role and theme independence

### Task 5: Captain with the original theme
**Files:** create `roles/captain.typ`, six `assets/captain/*.svg` files, `content/captain-example.json`, `examples/captain.typ`.

- [ ] Create a fictional master profile with five distinct embarkations, bridge/navigation responsibilities, vessel tonnage/trading-area fields and illustrative captain credentials. Reuse the fictional portrait initially to isolate the design comparison; disclosure remains explicit.
- [ ] Draw a restrained eight-spoke wheel with a real rim, hub and handles around the portrait. Set safe width/offset so wheel tips can clip at the top while the nameplate, contacts and face remain clear.
- [ ] Draw matching navigation side ornaments and faint chart/compass/bridge background details. Replace the screw marker with a subtle navigation marker.
- [ ] Compile using the unchanged Flagship theme and template; any required role correction belongs in artwork placement, not an `if captain` branch inside components.
- [ ] Inspect both pages, wheel crop and text extraction; ensure no engineer wording/machinery fields leak into this example. Commit.

### Task 6: Captain with a second theme
**Files:** create `themes/silver-bridge.typ`, `examples/captain-alternate.typ`.

- [ ] User-selected direction: charcoal, silver and white with modern display typography. Start with charcoal `202830`, silver `B8C2CC`, white `FFFFFF`, muted slate `596570`, pale grey `F0F3F5`; use Source Sans 3 semibold for display as well as body, replacing the narrow Barlow display of the original. Both families are already bundled. Adjust theme typography sizes to preserve the layout and verify contrast visually.
- [ ] Use exactly the same captain data, artwork pack and page plan. Change only the theme input; theme-specific display size/leading can accommodate font metrics.
- [ ] Verify SVG colors also follow the theme and title/body contrast remains clear.
- [ ] Inspect both pages for changed line lengths, clipping and balance; confirm all candidate content survives unchanged and both examples remain two pages. Commit.

**Gate:** Swapping role and swapping theme are demonstrably independent operations.

## Phase 4 — Pagination, self-review and handoff

### Task 7: Stress content and complete bounded review loops
**Files:** create `tests/pagination.typ`, `docs/review-log.md`; adjust components only where evidence requires.

- [ ] Build a deliberate three-page fixture containing more voyages and certificates, with explicit page allocations, stable numbering and continuation headers.
- [ ] Check certificate header repetition on a continued table; avoid headings stranded at page bottoms and keep a normal voyage together. An oversized voyage must prompt shortening or an explicit continuation treatment; do not hide overflow or shrink the whole CV.
- [ ] Check long ship/company names, multiline certificate titles, omitted optional sections, missing portrait, and a large name. Document supported limits and explicit adjustment points.
- [ ] For each review cycle, record: observation, affected component, reason to split/combine/retain, change, verification evidence, remaining issue. Review repository clarity, component ownership and final PDF separately.
- [ ] After any shared component correction, rebuild all three primary examples; rerun exact engineer comparison and inspect the affected captain regions. Stop repeating checks once all acceptance criteria pass with no unresolved material issue.
- [ ] Confirm embedded fonts, text presence, page counts, content order at section level and safe bounds for essential text. Decorative edge clipping is intentionally permitted.
- [ ] Commit verification and review evidence.

### Task 8: Make the active project easy to use
**Files:** create `scripts/build-examples.ps1`, `docs/architecture.md`, `docs/customization.md`; modify `main.typ`, `README.md` with localized edits.

- [ ] Add a safe build command for the three examples that refuses an existing destination and stops on compilation failures. Preserve historical builds.
- [ ] Point `main.typ` at the equivalent engineer example and explain the active folders before the historical gallery.
- [ ] Document copying an example, editing candidate data, changing theme, swapping artwork and allocating a third page. Include one small working import example rather than requiring users to understand every component.
- [ ] Document component spacing ownership, theme/artwork contracts, boundaries of parsing checks and the frozen-reference policy.
- [ ] Build from the documented commands; verify repository status includes only intentional changes, then commit and push through normal additive Git operations.
- [ ] Deliver three PDFs and comparison previews plus a Markdown review summary to the thread's `outputs/` using fresh names. Link those user-facing deliverables in the final response.

## Acceptance checklist

- [ ] Engineer: exact rendered equivalence and text equivalence to the approved two-page reference.
- [ ] Captain A: original theme, captain-specific art and content, polished two pages.
- [ ] Captain B: identical captain content/layout/art pack, visibly distinct color and font theme, polished two pages.
- [ ] Three-page fixture: no lost voyages/certificates, correct continuation behavior.
- [ ] Components: explicit inputs, no data-file reads, no role conditionals, meaningful composition boundaries.
- [ ] Configuration: colors/fonts centrally editable; role artwork centrally swappable; spacing has clear ownership.
- [ ] Repository: obvious active entry point, preserved historical references, no redundant new dependency or generated clutter.
- [ ] Evidence: exact baseline checks plus visual inspection, text/font checks and recorded self-review decisions.

## Plan self-review

All requested outcomes map to phases above. Architecture extraction precedes captain changes so differences remain attributable. The pagination scope intentionally uses explicit page plans with tested flow rules, rather than promising automatic optimal composition. Historical files stay in place to respect preservation and keep their imports working. The user selected charcoal/silver/white and modern typography for the second theme; no blocking preference remains. No implementation changes have been made while preparing this plan.
