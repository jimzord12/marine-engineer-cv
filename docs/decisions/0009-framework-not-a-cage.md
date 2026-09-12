# 0009. The framework is the happy path, not a cage

Date: 2026-09-12
Status: Accepted

## Context

ADRs 0007 and 0008 give the project a shared core, named templates and one
component contract. The owner's experience is that a new, small framework
cannot cover everything an operator asks for, and that forcing agents to
stay inside it would block delivery. The two real CVs produced so far
already had to go around the template. What was missing was not permission
to do that, but a way to notice it and learn from it.

## Decision

The core, the templates and the contract are the preferred path. When the
work the owner wants cannot be done through them, an agent goes around
them: composes by hand, adds a one-off, extends a component locally. Every
bypass is recorded in `docs/framework-gaps.md` in a few lines: what was
needed, what was bypassed, what was built instead, what the framework would
need. The log feeds the rule of three from ADR 0007.

A bypass goes around components, never around rules. The frozen
references, the fictional-content rule, the no-shrinking rule and the
totals rule hold regardless.

Stated by the owner in conversation on 2026-09-12; the rule carve-out is
the agent's refinement, accepted in the same conversation.

## Consequences

- Constitution section 10 records the rule; `AGENTS.md`, the vision, the
  build guide and the `new-cv` skill point at the gaps log.
- The gaps log is read before any framework work is planned. An entry that
  appears a second time is a candidate component, slot or extension; a
  third appearance makes it one.
- "Reviewed" or "done" on a task that bypassed the framework without a gaps
  entry is not done.
- The framework is expected to change shape as the log grows. Rigidity is a
  defect, not a virtue.
