# AGENTS.md — map of this repository

Composable Typst library that renders two-page maritime CVs. One template,
`flagship`, takes five independent inputs: candidate JSON, theme, artwork
pack, layout profile and a durations switch. Read this file, then open only
what your task needs.

## Where things are

| Path | Role | Touch it when |
|---|---|---|
| `lib.typ` | Public import surface, no side effects | Adding or renaming an exported function |
| `src/` | Library modules: data, theme check, primitives, hero, experience, sections, certificates, education, skills, page, pagination, `templates/flagship.typ` | Changing how anything renders |
| `themes/` | Visual tokens only: colours, fonts, sizes, tracking, leading, SVG colour map | Adding a look |
| `artwork/` | Artwork packs: which SVG goes in which slot, plus offsets | Adding a role's illustrations |
| `layouts/` | Geometry and page plan: margins, gaps, widths, which companies go on which page | Fixing page balance |
| `content/` | Fictional candidate JSON, one per example | Changing example data |
| `examples/` | Seven-line entry points that wire the five inputs together | Adding an example |
| `assets/`, `fonts/`, `licenses/` | Original SVG artwork, bundled OFL fonts, licence notices | Adding art or a font |
| `tests/` | `run.py` runner, `verify.py` PDF checks, `baseline.json` hash manifest, `fixtures/*.typ` compile cases | Changing behaviour |
| `reference/` | Frozen v11 PDF that the engineer example must match pixel for pixel | Never |
| `designs/` | Four frozen, evaluated design studies as worked examples | Reading for inspiration only |
| `exports/` | The three current deliverable PDFs | Releasing a new version |
| `schema/` | JSON Schema for candidate files | Changing the data contract |
| `docs/` | Governance and reference documentation, see below | Recording a decision |
| `scripts/build.ps1` | Builds the three examples into a new `builds/` folder | Rarely |
| `builds/` | Ignored. Every build and test run writes to a new timestamped folder here | Reading evidence |

## Commands

```powershell
./scripts/build.ps1                     # three PDFs into builds/library-<timestamp>/
./scripts/build.ps1 -HideVesselDurations
python tests/run.py                     # full suite, evidence into builds/tests-<timestamp>/
typst compile --root . --font-path fonts examples/engineer.typ builds/scratch.pdf
```

`tests/run.py` needs Typst 0.15.1 on PATH plus Python with `pymupdf` and
`pillow`. Building a CV needs only Typst.

## Rules that never change

Full text in `docs/constitution.md`. The short list:

1. `reference/Marine-Engineer-CV-v11.pdf` and the hashes in `tests/baseline.json` are frozen. `examples/engineer.typ` must render pixel-identical to it. A change that breaks this needs a new frozen reference and an ADR.
2. Every output goes to a new folder. Scripts refuse to overwrite.
3. Public content is fictional. Real candidate data lives in `private/`, which is ignored.
4. No automatic font shrinking. Overflow fails loudly and the page plan is changed by hand.
5. Evidence before "done": the suite output, a render, or a diff image.

## Documentation

| Read | When |
|---|---|
| `docs/vision.md` | Deciding whether a feature belongs here |
| `docs/architecture.md` | Before changing any module |
| `docs/tech-stack.md` | Setting up a machine, or asking "why Typst" |
| `docs/constitution.md` | Before anything irreversible |
| `docs/conventions.md` | Before writing code, docs or a commit message |
| `docs/git-workflow.md` | Branching, commits, PRs, tags, what gets committed |
| `docs/reference/candidate-schema.md` | Editing a candidate JSON |
| `docs/reference/theme.md` | Creating or editing a theme |
| `docs/reference/artwork-pack.md` | Creating or editing an artwork pack |
| `docs/reference/layout-and-pagination.md` | Page balance, splits, overflow errors |
| `docs/reference/skills-component.md` | Using the optional skills section |
| `docs/reference/verification.md` | What the suite checks and how to read its output |
| `docs/guides/build-a-cv.md` | Producing a CV for a real person |
| `docs/decisions/` | Why things are the way they are (ADRs) |
| `docs/history.md` | How the project got here |

## Skills

`.claude/skills/new-cv`, `verify-cv`, `new-theme`. Each is a short checklist
that names the files to copy, the commands to run and the evidence to report.

## Working agreement for agents

- Understand the seam before editing: imports, call sites, the fixture that
  covers it. Say what you found in a line, then act.
- Prefer the owning module over a parallel one. Related components stay in
  one small file.
- Every non-trivial change ends with `python tests/run.py` passing and the
  evidence path reported. A visual change also needs a rendered page.
- Commit and push on the working branch freely. Never merge to `main`
  without explicit approval in the conversation.
