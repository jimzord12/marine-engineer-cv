# 0006. Typst stays as the page engine

Date: 2026-09-13
Status: Accepted

## Context

On 2026-09-12 the owner considered replacing Typst with React or plain
HTML, CSS and JavaScript, for two reasons: finer control over the page, and
a component model the owner can read. The JavaScript options were researched
against what this library already needs: pixel-identical output against a
frozen reference, an explicit page plan with overflow as an error,
recoloured SVG artwork, embedded variable fonts, decorative images tagged as
PDF artifacts, and rows whose height is measured so a wrapping value never
shifts its neighbours.

Findings:

- **Headless Chromium** (Playwright, Puppeteer) is the only option where
  "HTML, CSS and JS" is literally true. Its output changes with the browser
  build, so the pixel gate holds only with a pinned browser and a re-baseline
  on every upgrade. Running headers and footers render in a sandbox that
  cannot see the page stylesheet. Row measurement needs `document.fonts.ready`.
  The toolchain is a 150 to 300 MB browser.
- **@react-pdf/renderer** writes PDF from React without a browser, but has no
  CSS: flexbox only, no grid, no tables, no CSS variables. SVG must be
  authored as React elements. It has no measurement API and cannot produce a
  tagged PDF. Reactive Resume, the largest open-source resume builder, moved
  to it in 2026 and had to drop custom CSS and patch three of its packages.
- **Paged.js** is still labelled experimental and publishes no releases.
- **pdfmake, PDFKit, jsPDF, pdf-lib** are drawing APIs with no layout model
  comparable to either CSS or Typst.
- **typst.ts** runs Typst inside Node or the browser, so a web front end can
  sit in front of the existing library without replacing it.

Typst 0.15 added variable fonts and combined PDF/A and PDF/UA export, both
of which this library uses or benefits from.

## Decision

Typst remains the page engine. Web technology may appear only in front of
it: a data editor, a live preview through typst.ts, a website. It never
replaces the renderer. The component model the owner wants is built in
Typst, see ADR 0008.

## Consequences

- The frozen-reference gate in ADR 0001 stays meaningful; nothing in the
  toolchain drifts with a browser release.
- Fine-grained control is delivered by conventions on top of Typst
  functions, not by a new runtime.
- The full comparison is recorded in the research memo of 2026-09-12,
  "Typst or Web for the Marine CV". Re-open this decision only if the
  requirements above change.
