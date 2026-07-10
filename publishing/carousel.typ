// Sacred Guide — LinkedIn Carousel
// 1080x1350px slides (LinkedIn carousel optimal)
// Poetry chapbook aesthetic: warm, generous, still

#let bg = rgb("#F5F0EB")       // warm off-white
#let fg = rgb("#2D2A26")       // near-black warm
#let accent = rgb("#9B5B3A")   // muted terracotta
#let subtle = rgb("#8A8279")   // warm gray for attributions

#let slide(body) = {
  pagebreak(weak: true)
  set page(
    width: 1080pt * 0.75,
    height: 1350pt * 0.75,
    margin: (
      left: 80pt,
      right: 80pt,
      top: 100pt,
      bottom: 100pt,
    ),
    fill: bg,
    numbering: none,
  )
  body
}

#let quote-slide(quote, attribution) = {
  slide[
    #v(1fr)
    #set text(
      font: ("EB Garamond", "Garamond", "Georgia"),
      size: 22pt,
      fill: fg,
      weight: "regular",
    )
    #set par(leading: 1.0em, justify: false)
    #quote
    #v(28pt)
    #set text(
      font: ("Inter", "Segoe UI", "Helvetica"),
      size: 11pt,
      fill: subtle,
      tracking: 0.06em,
    )
    #attribution
    #v(1fr)
  ]
}

// --- SLIDE 1: COVER ---
#set page(
  width: 1080pt * 0.75,
  height: 1350pt * 0.75,
  margin: (
    left: 80pt,
    right: 80pt,
    top: 100pt,
    bottom: 100pt,
  ),
  fill: bg,
  numbering: none,
)

#v(1fr)
#align(left)[
  #set text(
    font: ("EB Garamond", "Garamond", "Georgia"),
    size: 28pt,
    fill: fg,
    weight: "regular",
  )
  #set par(leading: 0.9em, justify: false)
  Six wisdom traditions.

  Six AI agents.

  17 sessions of argument.

  One guide.
]
#v(40pt)
#line(length: 60pt, stroke: 1.2pt + accent)
#v(20pt)
#align(left)[
  #set text(
    font: ("Inter", "Segoe UI", "Helvetica"),
    size: 12pt,
    fill: subtle,
    tracking: 0.04em,
  )
  Passages from The Sacred Guide
]
#v(1fr)

// --- SLIDE 2 ---
#quote-slide[
  "A human being is not a thing that exists and then, optionally, enters into relationships. A human being _is_ the relationships."
][
  — Room 1, The Table
]

// --- SLIDE 3 ---
#quote-slide[
  "The flinch is not the sin. The editing is the sin."
][
  — Room 3, The Other
]

// --- SLIDE 4 ---
#quote-slide[
  "The kitchen does not hold still for the fire. It keeps asking for breakfast."
][
  — Room 5, The Fire
]

// --- SLIDE 5 ---
#quote-slide[
  "Grief is not a process with stages. Grief is the discovery that you were not one person."
][
  — Room 5, The Fire
]

// --- SLIDE 6 ---
#quote-slide[
  "You are not the weather. You are the house the weather built."
][
  — Room 6, The Reckoning
]

// --- SLIDE 7 ---
#quote-slide[
  "Beginning again is not failure. It is the only move that is not a lie."
][
  — Room 8, The Return
]

// --- SLIDE 8: IRRECONCILABLE ---
#slide[
  #v(1fr)
  #set text(
    font: ("Inter", "Segoe UI", "Helvetica"),
    size: 12pt,
    fill: accent,
    tracking: 0.06em,
    weight: "medium",
  )
  One of 13 things the six voices could not agree on:
  #v(32pt)
  #set text(
    font: ("EB Garamond", "Garamond", "Georgia"),
    size: 19pt,
    fill: fg,
    weight: "regular",
  )
  #set par(leading: 0.95em, justify: false)
  "The book does not convene your companions. It names that it does not. The naming is the most the book can offer at this site."
  #v(28pt)
  #set text(
    font: ("Inter", "Segoe UI", "Helvetica"),
    size: 11pt,
    fill: subtle,
    tracking: 0.06em,
  )
  — Silence 5: The Absent We
  #v(16pt)
  #set text(size: 10.5pt, fill: subtle)
  #set par(leading: 0.85em)
  Seven rooms name the collective as a problem. No room names the collective as a presence arriving for you. The guide presumes a reader who has community to turn toward — and names the silent exclusion of the reader who has none.
  #v(1fr)
]

// --- SLIDE 9: CLOSE ---
#slide[
  #v(1fr)
  #line(length: 60pt, stroke: 1.2pt + accent)
  #v(28pt)
  #set text(
    font: ("EB Garamond", "Garamond", "Georgia"),
    size: 26pt,
    fill: fg,
    weight: "regular",
  )
  #set par(leading: 0.85em)
  The Sacred Guide
  #v(10pt)
  #set text(
    font: ("Inter", "Segoe UI", "Helvetica"),
    size: 13pt,
    fill: subtle,
  )
  85 pages. Free.
  #v(40pt)
  #set text(size: 11pt, fill: subtle, tracking: 0.02em)
  #set par(leading: 0.9em)
  Buddhism · Christianity · Islam

  Confucianism · Taoism · Zoroastrianism
  #v(32pt)
  #set text(size: 10.5pt, fill: accent)
  github.com/daharmattan1/sacred-guide
  #v(1fr)
]
