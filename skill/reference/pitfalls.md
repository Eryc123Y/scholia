# Pitfalls — Typst traps when writing Scholia notes

Most XeLaTeX/unicode-math traps from the LaTeX original are simply *gone* in Typst:
references resolve in a single compile (no "run twice"), math is its own syntax (no
`Missing { inserted`), and there is no `amssymb` clash. What remains:

## Math is Typst, not LaTeX
The source's LaTeX math must be translated. Common maps:
- `\mathbb{R}` → `bb(R)`; `\mathbf 1` → `bb(1)`; `\mathcal{H}` → `cal(H)`.
- `\operatorname{Ldim}` → `op("Ldim")`; `\text{…}` → `"…"` (a string in math) or `#[…]`.
- `\frac{a}{b}` → `(a)/(b)` or `a/b`; `\subseteq` → `subset.eq`; `\infty` → `infinity`.
- Subscripts/superscripts: `h^\star` → `h^star`, `x_t` → `x_t`, multi-token `a^{b c}` → `a^(b c)`.
- A literal `→` renders fine in math as `arrow.r`; in prose Typst falls back fonts automatically,
  so the LaTeX "Optima lacks the glyph" trap does not apply — but check display headings.

## Emphasis/strong delimiters are word-bounded
`*…*` (strong) and `_…_` (emph) only open and close at a word boundary, so a marker
*inside* a word fails to close: `*under*estimate` → "unclosed delimiter". Emphasise the
whole word (`*underestimate*`), or use the function form for a partial word:
`#strong[under]estimate`, `#emph[pre]fix`.

## Multi-page PNG export needs a page template
`typst compile main.typ out.png` **errors** for a multi-page doc. Use a `{p}` (or `{0p}`)
template: `typst compile main.typ "p-{p}.png" --ppi 150`. (PDF output is unaffected.)

## Margin notes (via marginalia)
`sidenote` (and its `recall` preset) are real right-margin notes backed by
`@preview/marginalia`; they auto-avoid overlap. Keep each note short — the right margin
is ~26mm wide.

## Layout
- **Several `fillin()` blanks on one math display can overflow.** Stack them in
  `$ aligned(...) $` (a 2×2 layout) instead of one long row.
- **A wide table column overflows.** Give the long/last column `1fr` (it wraps); fixed/`auto`
  columns do not wrap.
- Keep margin `sidenote`s short so they don't overflow the ~26mm margin.

## Style
- Go light on em-dashes (`—`) in prose; prefer commas/colons.
- When bulk-editing Chinese `.typ` files, use a UTF-8-safe tool (Python `encoding='utf-8'`),
  not an ASCII-typed `perl` replacement, to avoid mojibake.

## Verify before declaring done
Rasterize a page and actually look at it:
```bash
typst compile main.typ "p-{p}.png" --root . --ppi 150
```
Typst's warnings (e.g. `unknown font family`) print to stderr — scan them; an unknown font
means a fallback was used, which may not match the intended look on this machine.
