// The Sacred Guide — OG / social share image (1200 x 630)
// Landscape: cup image on the right, title block on the left warm field.
// compile: typst compile og_share.typ og_share.png --ppi 150
//   page 8in x 4.2in at 150ppi = 1200 x 630 px

#set page(width: 8in, height: 4.2in, margin: 0pt)

// Full-bleed background (cup, cover-fit). The cup naturally sits lower-left;
// for landscape we shift focus and lay the title over the warm right field.
#place(top + left, image("cover_base_cup.jpg", width: 100%, height: 100%, fit: "cover"))

// Soft warm scrim on the left third so the title always reads, regardless of
// how the image crops. Very light — just enough for contrast.
#place(top + left, rect(width: 58%, height: 100%, fill: gradient.linear(
  rgb("#F5F0EBDD"), rgb("#F5F0EB55"), rgb("#F5F0EB00"), angle: 0deg,
)))

#place(
  left + horizon,
  dx: 0.7in,
  block(width: 4in)[
    #set text(font: ("Garamond", "Georgia"), fill: rgb("#2D2A26"))
    #text(size: 30pt, tracking: 0.12em, weight: "regular", smallcaps[The Sacred Guide])
    #v(0.16in)
    #text(size: 13pt, style: "italic")[Written by six voices]
    #v(0.22in)
    #text(size: 12pt, fill: rgb("#9B5B3A"))[Read it free.]
  ],
)
