// The Sacred Guide — Book Template
// Literary press style: 5.5" x 8.5" trade paperback
// Mirrors A Handbook for Living design exactly

// --- Warm identity tokens (front matter only; body text stays near-black) ---
// Typst colors are rgb() numeric, never hex strings.
#let warm-accent   = rgb(122, 63, 40)   // #7a3f28 — deep terracotta-brown (matches the site title)
#let warm-rule     = rgb(178, 122, 85)  // #b27a55 — lighter terracotta for hairlines/ornament
#let warm-ink-soft = rgb(91, 82, 71)    // #5b5247 — soft ink for italic subtitles/captions

// The recurring ornament: an open ring (a cup seen from above / an open room /
// the open page). One quiet mark, used on the title page and the section breaks.
#let sacred-mark = [#box(baseline: 0pt)[#circle(radius: 3.2pt, stroke: 0.6pt + warm-rule)]]

#let book-template(
  title: "The Sacred Guide",
  subtitle: "Written by six voices",
  epigraph: none,
  body,
) = {
  // Page geometry
  set page(
    width: 5.5in,
    height: 8.5in,
    margin: (
      inside: 0.875in,
      outside: 0.75in,
      top: 0.875in,
      bottom: 1in,
    ),
    numbering: "1",
    number-align: center + bottom,
  )

  // Body text — Garamond for literary serif
  set text(
    font: ("Garamond", "EB Garamond", "Georgia"),
    size: 11pt,
    lang: "en",
    hyphenate: true,
  )

  // Paragraph settings
  // Real widow/orphan control (Typst): never strand a single line at the top or
  // bottom of a page. This is what prevents the "1-2 lines spill onto a near-empty
  // next page" problem — it was commented-as-done before but never actually set.
  set par(
    leading: 0.636em,
    justify: true,
    first-line-indent: 0.25in,
  )
  set par(spacing: 0.636em)            // inter-paragraph = leading (even color)
  show par: set block(breakable: true)
  // Keep blocks from breaking so a heading/figure is never orphaned at a page foot.
  set text(costs: (orphan: 100%, widow: 100%))

  // Chapter-opening vertical drop. 5.5×8.5 trade trim has ~6.6in of live height,
  // so a 1.6in drop (≈24%) opens the chapter with air WITHOUT burning the page or
  // shoving body text over the page boundary (the old 2.5in ≈ 38% did both).
  let chapter-drop = 1.6in
  let chapter-after = 0.55in

  // Heading styles — Level 1: Room titles (chapter equivalent)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(chapter-drop)
    set text(
      size: 16pt,
      weight: "regular",
      tracking: 0.12em,
    )
    align(center, smallcaps(it.body))
    v(chapter-after)
    set par(first-line-indent: 0pt)
  }

  // Level 2: Aftermatter section title
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    v(chapter-drop - 0.1in)
    set text(
      size: 14pt,
      weight: "regular",
      tracking: 0.10em,
    )
    align(center, smallcaps(it.body))
    v(chapter-after - 0.05in)
    set par(first-line-indent: 0pt)
  }

  // Running headers
  set page(
    header: context {
      let page-num = here().page()
      if page-num <= 2 { return }

      let chapters = query(heading.where(level: 1))
      let aftermatter = query(heading.where(level: 2))
      let all-headings = chapters + aftermatter
      let matching = all-headings.filter(h => h.location().page() <= page-num)
      if matching.len() == 0 { return }
      let current-chapter = matching.last()

      if current-chapter.location().page() == page-num { return }

      set text(size: 8.5pt)
      if calc.odd(page-num) {
        h(1fr)
        emph[The Sacred Guide]
      } else {
        text(tracking: 0.05em, smallcaps(current-chapter.body))
        h(1fr)
      }
      v(-4pt)
      line(length: 100%, stroke: 0.3pt + luma(180))
    },
  )

  // --- FRONT MATTER ---

  // COVER — the full-bleed warm cup image (same cover as the website + KDP). The
  // image already carries the title + "Written by six voices", so it doubles as the
  // title page; no separate text title page follows. Zero-margin, edge to edge.
  set page(margin: 0pt, numbering: none, header: none)
  place(top + left, image("cover/cover_front.png", width: 100%, height: 100%, fit: "cover"))

  // EPIGRAPH leaf — a quiet opening page after the cover. Centered on the page so
  // it reads as an intentional leaf, not an orphan. Carries the warm ring motif.
  pagebreak()
  set page(
    margin: (inside: 0.875in, outside: 0.75in, top: 0.875in, bottom: 1in),
    numbering: none, header: none,
  )
  v(1fr)
  align(center, block(width: 3.7in)[
    #set par(leading: 0.8em)
    #text(size: 12pt, style: "italic", fill: warm-ink-soft, epigraph)
    #v(0.5in)
    #text(size: 12pt, fill: warm-rule)[#sacred-mark]
  ])
  v(1.35fr)

  // --- TABLE OF CONTENTS (one page) ---
  pagebreak()
  v(1.4in)
  align(center)[
    #text(size: 13pt, tracking: 0.22em, weight: "regular", fill: warm-accent, smallcaps[Contents])
    #v(0.14in)
    #line(length: 0.7in, stroke: 0.5pt + warm-rule)
  ]
  v(0.42in)

  {
    set text(size: 10.5pt)
    // Tighter leading so the whole contents fits on a single page (was 1.7em → spilled).
    set par(first-line-indent: 0pt, leading: 1.15em)
    outline(title: none, indent: 0pt, depth: 2)
  }

  // --- BODY ---
  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)

  body
}

// --- CUSTOM ELEMENTS FOR THE SACRED GUIDE ---

// Room epigraph — italic line after room title, before scene break
#let room-epigraph(content) = {
  set par(first-line-indent: 0pt)
  v(0.1in)
  align(center, block(width: 4in, text(style: "italic", size: 10.5pt, content)))
  v(0.3in)
}

// Scene break — centered ornamental break between sections.
// (Body rhythm preserved: the original gray "∗ ∗ ∗". The warm open-ring motif is
// reserved for the FRONT MATTER via #fm-break so the reading body is untouched.)
#let scene-break() = {
  v(0.35in)
  align(center, text(size: 9pt, tracking: 0.3em, luma(120))[#sym.ast.op #sym.ast.op #sym.ast.op])
  v(0.35in)
  set par(first-line-indent: 0pt)
}

// Front-matter section break + the colophon section header. Used ONLY in the
// front matter (copyright / about pages), so it never touches the sacred body.
// A quiet warm header — far lighter than a chapter title — with the ring motif.
#let fm-break() = {
  v(0.3in)
  align(center, text(size: 9pt, tracking: 0.3em, fill: warm-rule)[#sym.ast.op #h(0.2em) #box(baseline: -0.5pt)[#circle(radius: 2.6pt, stroke: 0.5pt + warm-rule)] #h(0.2em) #sym.ast.op])
  v(0.3in)
  set par(first-line-indent: 0pt)
}
#let fm-section(title) = {
  v(0.15in)
  set par(first-line-indent: 0pt)
  align(center, text(size: 11pt, tracking: 0.14em, weight: "regular", fill: warm-accent, smallcaps(title)))
  v(0.22in)
}

// Gap — the breathing space between rooms
// Gaps are set in a narrower measure, italic, with extra vertical space
#let gap(content) = {
  v(0.6in)
  align(center)[
    #block(width: 3.5in)[
      #set text(style: "italic", size: 10.5pt)
      #set par(justify: true, first-line-indent: 0pt, leading: 0.7em)
      #content
    ]
  ]
  v(0.6in)
}

// Practice section header
#let practice-header(title) = {
  v(0.35in)
  align(center, text(size: 9pt, tracking: 0.3em, luma(120))[#sym.ast.op #sym.ast.op #sym.ast.op])
  v(0.25in)
  set par(first-line-indent: 0pt)
  text(size: 10pt, weight: "regular", tracking: 0.08em, smallcaps(title))
  v(0.15in)
}

// Inline italic passage (for embedded quotes/voices within prose)
#let voice(content) = emph(content)

// Aftermatter silence entry
#let silence-entry(number, title, body-text) = {
  v(0.2in)
  set par(first-line-indent: 0pt)
  text(weight: "bold", [#number — #title])
  v(0.08in)
  set par(first-line-indent: 0pt)
  body-text
  v(0.15in)
}
