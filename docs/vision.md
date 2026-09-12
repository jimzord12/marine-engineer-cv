# Vision

Read this when deciding whether a feature belongs in the project. Owned by
the product owner; last confirmed 2026-09-13.

## What this is

A product for merchant marine seafarers: polished, distinctive CVs that a
crewing agency or a shipping company's HR desk opens, reads and parses
without friction. It is built as a family of Typst templates on one shared
core. Every template comes in a deck variation and an engine variation and
in two to four themes. Cadets and short careers get a one-page layout.

The person editing a CV changes data, not layout code. The person designing
a new look changes a theme or an artwork pack. The person designing a new
template writes its sections against the shared core and the component
contract, then freezes an approved render.

## What it is not

- Not a general resume framework. Maritime roles only. Two pages by
  default, one page for cadets.
- Not an online service. Everything builds locally with one compiler. Real
  candidate data never leaves the machine.
- Not an automatic layout engine. Pagination is explicit and reviewed by a
  human. The system refuses to shrink fonts to make content fit.
- Not a store of real people. Public content stays fictional.

## Principles

1. **Five inputs, many templates.** Candidate, theme, artwork, layout,
   display switch. Each can change alone, and a candidate can change
   template without re-entering a career. If a feature needs two inputs to
   know about each other, it is in the wrong place.
2. **Deck and engine are variations, never forks.** A template renders both
   roles from data, artwork and copy. A section that must differ is a slot
   or a data-selected variant of the same template.
3. **Approved looks are frozen.** Every approved template has a locked
   reference render, and the suite proves the library reproduces it on
   every run.
4. **Loud failure over silent drift.** Overflow, missing months, a name that
   does not fit the plate: each fails with a message naming the fix.
5. **Evidence, not assurance.** A change is done when the suite passes and a
   render exists in a fresh folder.
6. **Readable in one sitting.** Each template's own code stays small enough
   to read in one go. Shared code is promoted when a third template needs
   it, never speculated.

## Direction

In priority order. Each item is committed when the owner opens it; none is
started on an agent's initiative.

1. **Deck data support.** Real deck careers are recorded as contract
   periods, not service months. The schema, the synopsis metrics and the
   certificate table must express what deck officers actually have, so a
   real deck CV fits the template instead of bypassing it. See ADR 0007.
2. **The component contract.** Migrate the Flagship modules to the shape in
   ADR 0008, one module per commit under the pixel gate.
3. **A second template.** A named design with its own sections and frozen
   reference, likely grown from one of the studies under `designs/`. This
   is when `src/` splits into core and per-template folders.
4. **Cadet layout.** A one-page layout profile for cadets and short
   careers, for every template.
5. **More themes.** Two to four per template.
6. **A private-repo workflow** that uses this library as a Typst package.
