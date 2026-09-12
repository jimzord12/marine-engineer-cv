# Architecture decision records

One file per decision that shapes the code and is expensive to reverse.
Numbered, never edited after acceptance; a later decision supersedes an
earlier one by saying so.

Template:

```markdown
# NNNN. Title

Date: YYYY-MM-DD
Status: Accepted | Superseded by NNNN

## Context
What was true and what forced a choice.

## Decision
What we do, in one or two sentences.

## Consequences
What becomes easier, what becomes harder, what the suite enforces.
```

| ADR | Decision |
|---|---|
| [0001](0001-freeze-v11-as-reference.md) | The approved v11 render is a frozen, pixel-exact contract |
| [0002](0002-five-independent-inputs.md) | One template, five independent inputs |
| [0003](0003-explicit-pagination.md) | Page allocation is explicit and validated, never automatic |
| [0004](0004-hidden-durations-keep-geometry.md) | Hiding durations reserves geometry and emits no text |
| [0005](0005-restructure-for-agents.md) | Prune history, keep four studies, English docs, agent entry files |
