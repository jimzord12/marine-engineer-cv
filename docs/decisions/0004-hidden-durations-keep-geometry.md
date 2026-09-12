# 0004. Hidden durations reserve geometry and emit no text

Date: 2026-09-09
Status: Accepted

## Context

Some candidates cannot state months per vessel, or prefer not to show them.
An early version hid the text but let the rank column slide right, which
changed the look of every row and broke comparison against the approved
design. Rendering the text in white would leave it in the extracted PDF
text.

## Decision

`show-vessel-durations` is one global switch. When false, the duration cell
measures the text it would have shown and emits an empty box of that width
and height. Vessel name and rank keep their coordinates exactly. No duration
text enters the PDF. Company totals may come from `service-months` when
per-vessel months are absent.

## Consequences

- The suite checks that every vessel and rank has identical coordinates in
  both modes, including a wrapped duration.
- There is no per-row toggle by design.
- Company totals still require either every vessel's months or an explicit
  company total; unknown time is never treated as zero.
