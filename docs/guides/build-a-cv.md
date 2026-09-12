# Build a CV for a real person

Read this when producing an actual CV. The public repository never receives
real data; everything below happens in the ignored `private/` folder.

## 1. Create the private workspace

One folder per candidate, named after the person and role:

```text
private/jane-doe-second-engineer/
  README.md              how to build, what was decided, where the evidence is
  candidate.json         candidate data
  cv.typ                 entry point
  portrait.jpg           authorised photograph
  reference.pdf          the approved render, once there is one
```

`cv.typ`. The shipped layout's page plan assumes the example's six
companies, so a real candidate always overrides `pages` with their own
company indices, zero-based, in JSON order:

```typst
#import "../../lib.typ": flagship
#import "../../themes/golden-blue.typ": theme
#import "../../artwork/engineer.typ": artwork
#import "../../layouts/flagship-v11.typ": layout as base
#let layout = (..base, pages: (
  (companies: (0, 1)),
  (companies: (2,), synopsis: true, certificates: true, education: true),
))
#let candidate = json("candidate.json")
#show: flagship.with(candidate: candidate, theme: theme, artwork: artwork, layout: layout,
  show-vessel-durations: true)
```

Three companies here: two open page one, the third closes page two with the
synopsis, certificates and education. Adjust the split after looking at the
render. Splitting one large company across pages is shown in
`../reference/layout-and-pagination.md`.

## 2. Fill the data

Copy `content/engineer-example.json` or `content/captain-example.json` and
replace every value. Field meanings and error messages are in
`../reference/candidate-schema.md`. Set `identity.portrait` to
`/private/jane-doe-second-engineer/portrait.jpg` or `null`.

If you do not know months per vessel, set `show-vessel-durations: false` and
give each company a `service-months` total instead.

## 3. Compile

```powershell
typst compile --root . --font-path fonts private/jane-doe-second-engineer/cv.typ builds/jane-doe-01.pdf
```

Use a new file name each time. For live editing:

```powershell
typst watch --root . --font-path fonts private/jane-doe-second-engineer/cv.typ builds/jane-doe-preview.pdf
```

## 4. Fix what does not fit

Every failure names the fix. The common ones:

- A name, rank or contact too long for the hero: shorten it or override the
  size in the entry point, `theme: (..theme, sizes: (..theme.sizes, name: 30pt))`.
- `Page plan company index out of bounds`: the `pages` override does not
  match the number of companies in the JSON. Fix the indices.
- Overflow on a page: move a company to the next page or split it as shown
  in `../reference/layout-and-pagination.md`. Do not shrink the body font.

## 5. Look at every page

Open the PDF. Check the hero, the split between pages, the synopsis
position, and that education sits where you want it. Check the text is
selectable and the reading order makes sense for the portal you will submit
to.

## 6. Keep it private

Nothing under `private/` is tracked. Do not copy renders into `exports/`.
Do not commit certificate numbers, scans or passport details anywhere.

## 7. When the template does not fit

Some real CVs cannot go through `flagship` yet. The known case is a deck
officer whose career is recorded as contract periods rather than service
months; see the note in `../reference/candidate-schema.md`. Until the
template supports that data, compose the page by hand from the same modules:

```typst
#import "../../src/page.typ": document-shell, page-header
#import "../../src/hero.typ": hero
#import "../../src/sections.typ": profile-summary, section-heading
#import "../../src/skills.typ": skills-section
// then place hero, sections and your own table in cv.typ
```

Rules for this path:

- Import from `src/` modules; never copy library code into the workspace.
- Keep the candidate JSON valid against the schema. Put data the schema
  cannot hold, such as contract periods, in a separate `presentation.json`
  beside it. Never invent months from calendar periods.
- Keep the approved render as `reference.pdf` in the folder and record in
  the folder's `README.md` why the custom composition exists and what it
  matched. Once the template can express the data, the entry point is
  rewritten to use `flagship` and compared against that reference.
