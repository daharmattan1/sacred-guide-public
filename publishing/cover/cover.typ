// The Sacred Guide — front cover
// Full-bleed painterly cup image (textless base) + title typography.
// Output: 1600 x 2560 (KDP-friendly 1:1.6), compile:
//   typst compile cover.typ cover_front.png --ppi 300
// (page is 5.333in x 8.533in at 300ppi = 1600 x 2560 px)

#set page(
  width: 5.333in,
  height: 8.533in,
  margin: 0pt,
)

// Full-bleed background image (the chosen textless cup candidate)
#place(top + left, image("cover_base_cup.jpg", width: 100%, height: 100%, fit: "cover"))

// Title block — sits in the warm empty upper third, above the cup.
// Warm near-black to read against the cream wall. Mirrors the book's
// interior identity: smallcaps Garamond, wide tracking.
#place(
  top + center,
  dy: 1.15in,
  block(width: 4.2in)[
    #set align(center)
    #set text(font: ("EB Garamond", "Garamond", "Georgia"), fill: rgb("#2D2A26"))
    #text(size: 30pt, tracking: 0.14em, weight: "regular", smallcaps[The Sacred Guide])
    #v(0.28in)
    #text(size: 13pt, tracking: 0.05em, style: "italic")[Written by six voices]
  ],
)
