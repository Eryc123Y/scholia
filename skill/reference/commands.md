# Scholia command reference (Typst)

```typ
#import "@preview/scholia:0.1.0": *
#show: scholia   // .with(prose: "book", double: true, paper: "us-letter", fonts: (…))
```

Options on `scholia`: `theme: "light"|"dark"` (default light; dark = slate — swaps the
whole colour card), `prose: "notes"|"book"` (default notes — no indent + para spacing;
book — first-line indent + tight), `double: false|true` (single/two-sided),
`paper`, `fonts:` (overrides the per-role fallback lists). 中文 works out of the box
(Songti SC fallback). Body/math default to STIX Two (Libertinus / New CM Math fallback).

## Cover & structure
- `cover(title, subtitle: …, author: …, date: …, kicker: …)` — pure-typographic title page (centred).
- `=`, `==`, `===` — section / subsection / subsubsection. The section number + title
  sit over a coloured rule; auto-numbered `1.1`. Case is rendered as written.

## Knots (theorem-likes — built on frame-it; shared, section-tied numbering)
- `theorem`, `lemma`, `proposition`, `corollary` → **blue** (thm) knot.
- `definition` → **teal** (def) knot.
- `example` → **amber** (eg) knot.
- `remark[…]` → unboxed, teal italic head.
- `proof[…]` → ends on a small solid square (qed).
- Call as `theorem[title][body]`; omit the title with `theorem[body]`. e.g.
  `definition[sheaf][…]`. An optional middle slot is a **tag** (source / claim-ID),
  styled by `label-it`: `theorem[Bézout][GSM 211, Thm. 2.16][…]`.
- **Cross-reference (native):** label a knot with `<thm:soa>` after it, refer with
  `@thm:soa` → renders "Theorem 2.1", clickable. Prefer this over `warp/pick` for
  pointing at a numbered knot.

## The intuition voice
- `note[…]` — the informal "what's really going on", on a soft wash. Read-only layer.
- `whisper[…]` — a short inline aside in the note voice.
- `keyword[…]` — bold, in the theme's keyword colour, for a term being introduced.
- `label-it[…]` — a small bold sans badge in the theme's tag colour (the theorem tag style); usable inline anywhere.

## Pedagogy (fill-in study notes)
- `block-head[…]` — a quiet sub-heading inside a section.
- `trigger[…]` — a "when you'd reach for this" cue (**Trigger.** label).
- `TODO[hint]` — a gap to fill inside a proof/derivation (`[ fill in: hint ]`, amber).
- `fillin(width: 2.2cm)` — an empty ruled blank to write the answer in (default 2.2cm).
- `yourturn[…]` — the amber "Your turn." box: the active-input zone.
- `workspace(n: 3)` — `n` faint ruled lines to write on (for print; delete if typing).
- `recall[question]` — a quick active-recall prompt (a `?` glyph), parked in the right margin.

## The selvage edge
- `loose[…]` — an open question / exercise (selvage aside).
- `warp("key")` — declare a recurring object (drops a label to cross-ref).
- `pick("key")` — pick it up later: a `[ key ↩ ]` chip linked back to the `warp`.

## Tables
Use Typst's native `table`. Pattern for a cheat-sheet / dictionary:
```typ
#table(
  columns: (auto, auto, 1fr),     // last column wraps
  stroke: none,
  table.header[*Tool*][*Setting*][*When to use*],
  [A], [a setting], [a wrapping description that flows if long],
)
```
Colour a header cell with a theme role (see below). Add rules with `table.hline()`.

## Theme & palette
Two colour cards switch via `theme: "light"|"dark"` (dark = slate). Roles per card:
`bg ink muted hairline thm def eg rule tag keyword`. To use a colour yourself,
`import scholia: palettes, active`, then `palettes.light.thm` (a fixed value) or, inside
`context`, `active.get().thm` (the current theme). Retune the cards in `src/colors.typ`.
