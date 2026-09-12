# Build a CV for a real person

Read this when producing an actual CV. The public repository never receives
real data; everything below happens in the ignored `private/` folder.

## 1. Create the private workspace

```text
private/
  jane-doe.json          candidate data
  jane-doe.typ           entry point
  portrait.jpg           authorised photograph
```

`private/jane-doe.typ`. The shipped layout's page plan assumes the example's
six companies, so a real candidate always overrides `pages` with their own
company indices, zero-based, in JSON order:

```typst
#import "../lib.typ": flagship
#import "../themes/golden-blue.typ": theme
#import "../artwork/engineer.typ": artwork
#import "../layouts/flagship-v11.typ": layout as base
#let layout = (..base, pages: (
  (companies: (0, 1)),
  (companies: (2,), synopsis: true, certificates: true, education: true),
))
#let candidate = json("jane-doe.json")
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
`/private/portrait.jpg` or `null`.

If you do not know months per vessel, set `show-vessel-durations: false` and
give each company a `service-months` total instead.

## 3. Compile

```powershell
typst compile --root . --font-path fonts private/jane-doe.typ builds/jane-doe-01.pdf
```

Use a new file name each time. For live editing:

```powershell
typst watch --root . --font-path fonts private/jane-doe.typ builds/jane-doe-preview.pdf
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
