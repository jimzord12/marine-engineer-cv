# Git workflow

Read this before branching, committing, tagging or opening a pull request.

## Branches

- `main` is always releasable: the suite passes and the three PDFs in
  `exports/` match the code.
- Work happens on short-lived branches named `<type>/<topic>`:
  `feat/chief-engineer-artwork`, `fix/duration-wrap`,
  `refactor/agent-ready-layout`, `docs/adr-frozen-v11`.
- One topic per branch. A branch that grows a second topic gets split.

## Commits

- Conventional Commits as in `conventions.md`. Small, coherent, each one
  compiles.
- Agents commit and push to the working branch without asking.
- Amend, rebase, force-push, reset and branch deletion require the owner's
  explicit approval with the exact command shown first.

## Pull requests

- Every branch reaches `main` through a pull request, even for the owner's
  own work, so the CI run and the diff are recorded.
- The PR description states what changed, why, and where the evidence is:
  the `builds/` folder name from the last `tests/run.py` run and, for visual
  work, which rendered page was inspected.
- CI (`.github/workflows/verify.yml`) must be green.
- **Merging into `main` needs the owner's explicit approval in the
  conversation.** Agents never merge on their own judgement. Once approved,
  squash-merge with the PR title as the commit subject.

## Tags

- `archive/<name>` marks a snapshot before a large removal. Files deleted
  from the tree remain reachable there.
- `reference/v11` style tags mark the commit that produced a frozen
  reference render.
- Release tags follow `vMAJOR.MINOR.PATCH` and match `typst.toml`.

## What is committed

| Committed | Ignored |
|---|---|
| Source, themes, artwork, layouts, examples, fictional JSON | `private/` with real candidate data |
| Bundled fonts and licence notices | `builds/` with every build and test output |
| The three current deliverable PDFs in `exports/` | Scratch PDFs and PNGs at the repo root |
| The frozen reference PDF and hash manifest | `__pycache__/` |
| Design studies with their review renders | Anything under `previews/` or `exports/review/` from earlier sessions |
| Preview PNGs used by the README | |

Binary files are marked in `.gitattributes`. Each committed PDF is around
2.7 MB, so do not add renders casually. Replace, do not accumulate.

## Releasing a new render

1. Change code or data on a branch. Run `python tests/run.py`.
2. Build with `./scripts/build.ps1`, inspect both pages of every changed
   example.
3. Copy the new PDF into `exports/` with the next version number and remove
   the old one. Refresh the two preview PNGs in `docs/images/`.
4. If the engineer look changed on purpose, write an ADR, replace the frozen
   reference, regenerate `tests/baseline.json`, and tag the commit.
5. Open the PR with the evidence folder named. Wait for approval to merge.
