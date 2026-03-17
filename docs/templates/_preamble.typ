// _preamble.typ — 0 C.E. GDD Shared Typst Theme
// Place at:  docs/templates/_preamble.typ  in the main repository.
// Import as: #import "/docs/templates/_preamble.typ": gdd-page

#let accent = rgb("#e94560")  // red accent
#let dark = rgb("#1a1a2e")  // near-black for H1
#let mid = rgb("#16213e")  // dark navy for H2/H3

/// Wraps a documentation page with shared styles.
/// `title`  – used in <title> and document metadata.
/// `body`   – page content produced by pandoc.
#let gdd-page(title: "0 C.E. GDD", body) = {
  set document(title: title)

  // PDF layout (ignored in HTML export)
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
  )

  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: "en",
  )

  // ── Table styling ──────────────────────────────────────────────────────────
  set table(
    stroke: (x, y) => (
      top: if y == 0 { 1.5pt + luma(160) } else { 0.5pt + luma(200) },
      bottom: 0.5pt + luma(200),
      left: none,
      right: none,
    ),
    fill: (x, y) => if y == 0 { luma(225) } else if calc.odd(y) { luma(248) } else { white },
    inset: (x: 0.6em, y: 0.42em),
  )

  // ── Heading styles ─────────────────────────────────────────────────────────
  show heading.where(level: 1): it => [
    #v(0.9em, weak: true)
    #text(size: 18pt, weight: "bold", fill: dark)[#it.body]
    #v(0.45em, weak: true)
  ]

  show heading.where(level: 2): it => [
    #v(0.7em, weak: true)
    #text(size: 14pt, weight: "bold", fill: mid)[#it.body]
    #v(0.3em, weak: true)
  ]

  show heading.where(level: 3): it => [
    #v(0.5em, weak: true)
    #text(size: 11pt, weight: "semibold", fill: mid)[#it.body]
    #v(0.2em, weak: true)
  ]

  // ── Code block styling ─────────────────────────────────────────────────────
  show raw.where(block: true): it => block(
    fill: luma(241),
    inset: (x: 1em, y: 0.75em),
    radius: 3pt,
    width: 100%,
    stroke: 0.5pt + luma(210),
  )[
    #set text(font: "DejaVu Sans Mono", size: 9pt)
    #it
  ]

  body
}
