# Vision

Read this when deciding whether a feature belongs in the project.

> Draft written during the 2026-09-12 restructure from what the code and
> history show. The product owner should edit the "Direction" section.

## What this is

A small, dependable library for producing polished two-page CVs for seafaring
roles. The person editing a CV changes data, not layout code. The person
designing a new look changes a theme or an artwork pack, not the template.
The output is a PDF that a shipping company's HR desk can open, read and
parse.

## What it is not

- Not a general resume framework. One template family, maritime roles,
  two pages by default.
- Not an online service. Everything builds locally with one compiler.
- Not an automatic layout engine. Pagination is explicit and reviewed by a
  human. The system refuses to shrink fonts to make content fit.
- Not a store of real people. Public content stays fictional.

## Principles

1. **Five inputs, one template.** Candidate, theme, artwork, layout, display
   switch. Each can change alone. If a feature needs two of them to know
   about each other, it is in the wrong place.
2. **Approved looks are frozen.** A locked reference render is a contract.
   The library must reproduce it exactly, and the suite proves it on every
   run.
3. **Loud failure over silent drift.** Overflow, missing months, a name that
   does not fit the plate: each fails with a message naming the fix.
4. **Evidence, not assurance.** A change is done when the suite passes and a
   render exists in a fresh folder.
5. **Small enough to read.** The whole library is under 500 lines of Typst.
   Keep it that way.

## Direction

Likely next steps, in rough priority. None is committed until the owner says
so.

- More roles as artwork packs: chief engineer, electro-technical officer,
  deck officer.
- More themes with the same components.
- A one-page layout profile for cadets and short careers.
- A private-repo workflow for real candidates that reuses this library as a
  Typst package.
