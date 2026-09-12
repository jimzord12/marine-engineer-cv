# Constitution

Rules that do not change without the product owner saying so in writing.
Read before anything irreversible. Conventions, which do evolve, are in
`conventions.md`.

## 1. Frozen references are contracts

- Every approved template has a frozen reference render under `reference/`
  and a public example that must render pixel-identical to it at 144 dpi
  with identical normalised text on every page. `tests/run.py` enforces
  this. Today that is Flagship: `reference/Marine-Engineer-CV-v11.pdf` and
  `examples/engineer.typ`.
- `tests/baseline.json` pins the SHA-256 of every asset, font, example JSON,
  design study and the reference PDF, whether or not the engineer comparison
  uses it. Changing any of them is a design decision, recorded as an ADR in `docs/decisions/`, with a
  new frozen reference and a version bump on the PDF name.
- The four numbered studies and `shared.typ` under `designs/` are frozen.
  Copy ideas out of them; do not edit them. Path-only updates during a move
  are not edits.

## 2. New outputs, never overwrites

Every script and test writes into a new timestamped folder under `builds/`
and refuses to run if the folder exists. Review renders in `exports/`,
`reference/` and `designs/review/` are replaced only by a deliberate release
commit with a new version number.

## 3. Public content is fictional

Names, employers, vessels, dates, certificates and the portrait are invented.
Real candidate data lives in `private/`, which git ignores, one folder per
candidate with its own entry point importing `../../lib.typ`. Certificate numbers, scans and passport details
never enter this repository.

## 4. The system does not lie to fit

No automatic font shrinking, no silent reflow. When content does not fit, the
template fails with a message naming the fix: split a company, allocate
another page, shorten a name, adjust a width. A human changes the page plan
and looks at the result.

## 5. Evidence before "done"

A change is finished when `python tests/run.py` passes, the evidence folder
is named, and a visual change has a rendered page someone looked at. "It
should work" is not a state.

## 6. Totals come from data

Service months, vessel counts and company counts are computed once from the
full candidate. Pages never recompute totals from what they display. Calendar
periods are never converted into service time.

## 7. Roles do not leak into components

Deck and engine are variations of every template, expressed through the
candidate JSON, the artwork pack and copy strings. No component branches on
role. No template is forked by role. A section that must differ between the
two is a slot or a data-selected variant of the same template (ADR 0007).

## 8. Licences travel with their files

Every bundled font keeps its OFL notice in `licenses/`. Adapted code keeps
its original notice. Original artwork is MIT with the project.

## 9. Delivery bar

The team optimises for the smallest commercially sound result: happy path,
common failures, realistic regressions. No speculative abstraction, no
opportunistic cleanup in a feature change. Push back in the conversation when
a request seems wrong; proceed once the owner decides.
