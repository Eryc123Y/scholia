---
name: fill-in-notes
description: >-
  Turn a textbook chapter, lecture, or paper into beautiful "fill-in" study notes —
  written to be READ (clean statements, intuition) yet engineered to be FILLED
  (blanks, proof skeletons, "your turn" computations) so the reader learns by
  active recall. Notes are typeset with the Scholia Typst package in this repo.
  Use when the user wants study notes from a source with gaps to fill in, worked
  examples restaged as exercises, or theorems stated but proofs left open. Triggers:
  "make fill-in notes", "turn this chapter into notes I can fill in", "guided /
  skeleton study notes", "study notes from this book/PDF", "读+填 笔记",
  "被动+主动 learning notes". NOT for a plain summary, a polished paper, or notes
  with every detail spelled out (that kills the active layer).
---

# Fill-in notes — the Scholia method (Typst)

Produce study notes that a learner both **reads** (passive intake) and **fills**
(active recall). The source is the answer key; the notes are the scaffold. Lead with
a *spine* (one organizing idea) so a chapter becomes a single story, not a transcript.

## Pipeline

1. **Read the source; find the spine.** Skim the chapter/PDF, then name the ONE
   organizing idea and reorganize around it — a dictionary, an engine list, a single
   theorem the rest orbits. Do **not** transcribe section by section if a better shape
   exists. (Concentration → "8 engines"; Nonlinear Algebra → the algebra↔geometry
   dictionary.)
2. **Scaffold.** Create a `.typ` that opens with
   `#import "@preview/scholia:0.1.0": *` then `#show: scholia` (options:
   `prose: "notes"|"book"`, `double:`, `fonts:`).
   Put the master spine on the front page (a cheat-table / map, partly blank), then
   `#include` one file per section under `sections/`.
3. **Draft each section in the Scholia grammar** (see the table below).
4. **Engineer the gaps (~70% read / 30% fill).** Read `reference/method.md`. Blank the
   high-value *thinking* moves, never so much that reading breaks.
5. **Compile + verify.** `typst compile main.typ`. Watch for the `reference/pitfalls.md`
   traps (math is Typst syntax, not LaTeX). Rasterize a page
   (`typst compile main.typ "p-{p}.png" --ppi 150`) and read it back before declaring done.

## The Scholia grammar — what goes where

| beat | device | role |
|---|---|---|
| one-line thesis | `note[…]` | the big idea, read-only |
| when to use it | `trigger[…]` | a cue line |
| sub-heading | `block-head[…]` | quiet section lead |
| quick-reference | native `table(…)` | the cheat-sheet / dictionary |
| definition | `definition[name][…]` (teal knot) | state it, **blank a key clause** with `fillin()` |
| result | `theorem`/`lemma`/`proposition`/`corollary` (blue knot) | state in full (read) |
| proof | `proof[… #TODO[step]]` | skeleton; the learner fills the step |
| worked instance | `example[name][…]` (amber knot) | setup given |
| do-it-yourself | `yourturn[… #workspace(n: 3)]` | the active zone; the example, restaged |
| margin recall | `recall[question]` | a parked active-recall prompt |
| a margin prompt | `sidenote[…]` · `recall[…]` | a side annotation; `recall` is the `?` self-test preset |
| cross-reference | `<thm:x>` … `@thm:x` | label a knot, refer back (native) |

Full command reference: `reference/commands.md`.

## Honest scoping

- The notes restate results from the source. For **personal study** this is fine; before
  making notes that closely track a *copyrighted* book **public**, attribute clearly and
  consider an original example instead (see the repo README's note).
- Keep the source's numbering in the knot title (e.g. `theorem[… Thm. 2.16][…]`); the
  bold auto-numbers are local to the notes.

## See also
- `../examples/demo.typ` — every visual feature on one page (the live cheat-sheet).
- `../README.md` — install, the toolkit table, and known gaps vs. the LaTeX original.
