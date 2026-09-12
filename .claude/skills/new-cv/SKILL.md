---
name: new-cv
description: Produce a CV for a real or new fictional candidate with the marine-cv library. Use when asked to create, set up or render a CV for a person, or to add a new example. Covers the private workspace, data file, entry point, page plan and evidence.
---

# New CV

Follow `docs/guides/build-a-cv.md`. This skill is the checklist.

## Decide the destination

- Real person: everything under `private/` (ignored). Never under
  `content/` or `examples/`.
- New public example: fictional data under `content/<name>-example.json`,
  entry under `examples/<name>.typ`, and add it to `scripts/build.ps1` and
  the compile list in `tests/run.py`.

## Steps

1. Copy the closest data file (`content/engineer-example.json` or
   `content/captain-example.json`) and replace every value. Keep stable ids.
   Whole months. If months per vessel are unknown, use `service-months` on
   the company and plan to hide durations.
2. Validate the JSON against `schema/candidate.schema.json` if a validator
   is available; otherwise rely on the compile-time assertions.
3. Write the seven-line entry point. Pick theme (`themes/`), artwork
   (`artwork/`), layout (`layouts/flagship-v11.typ`), and the durations
   switch.
4. Compile to a new file under `builds/`:
   `typst compile --root . --font-path fonts <entry> builds/<name>-01.pdf`.
5. On a fit or overflow error, apply the fix the message names. Page plan
   changes go in the entry point as a layout override, see
   `docs/reference/layout-and-pagination.md`. Never shrink body fonts.
6. Render each page to PNG and look at it. `python -c` with `pymupdf` works:
   `page.get_pixmap(dpi=96).save(...)`.
7. For a public example, run `python tests/run.py` and confirm PASS.

## Report

State the output path, the page count, what was checked on each page, and
any override applied to the layout or theme.
