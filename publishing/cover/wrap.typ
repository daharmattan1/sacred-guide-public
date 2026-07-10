// The Sacred Guide — full paperback cover WRAP (KDP)
// Trim 5.5 x 8.5, 90 pages, white paper, bleed 0.125".
//   spine = 90 * 0.0025" = 0.225"
//   full width  = 0.125 + 5.5 + 0.225 + 5.5 + 0.125 = 11.475"
//   full height = 8.5 + 0.125 + 0.125 = 8.75"
// Under 100pp => NO spine text (KDP rule) => spine is a blank warm band.
// compile: typst compile wrap.typ paperback_wrap.png --ppi 300

#let bleed = 0.125in
#let trim-w = 5.5in
#let trim-h = 8.5in
#let spine = 0.225in
#let full-w = bleed + trim-w + spine + trim-w + bleed   // 11.475in
#let full-h = trim-h + bleed + bleed                     // 8.75in

#let sand = rgb("#F5F0EB")
#let ink = rgb("#2D2A26")
#let amber = rgb("#9B5B3A")

#set page(width: full-w, height: full-h, margin: 0pt, fill: sand)

// ---- FRONT panel (right): full-bleed cup cover image ----
// left edge of front = bleed + trim-w + spine
#place(top + left, dx: bleed + trim-w + spine - 0in, dy: 0in,
  box(width: trim-w + bleed, height: full-h, clip: true,
    image("cover_base_cup.jpg", width: 100%, height: 100%, fit: "cover")))

// Front title (mirrors cover_front.png), positioned within the front panel's safe area.
#place(top + left,
  dx: bleed + trim-w + spine + (trim-w - 4.2in)/2,
  dy: bleed + 1.15in,
  block(width: 4.2in)[
    #set align(center)
    #set text(font: ("Garamond", "Georgia"), fill: ink)
    #text(size: 30pt, tracking: 0.14em, weight: "regular", smallcaps[The Sacred Guide])
    #v(0.28in)
    #text(size: 13pt, tracking: 0.05em, style: "italic")[Written by six voices]
  ])

// ---- SPINE (center): blank warm band (no text, under 100pp) ----
// already sand-filled by the page fill; nothing to draw.

// ---- BACK panel (left): warm field + back-cover blurb ----
// Back safe area: inside bleed, with comfortable margins.
#place(top + left, dx: bleed + 0.6in, dy: bleed + 0.9in,
  block(width: trim-w - 1.2in)[
    #set text(font: ("Garamond", "Georgia"), fill: ink, size: 11.5pt)
    #set par(justify: false, leading: 0.7em, first-line-indent: 0pt, spacing: 1.0em)

    She is asleep on her feet in her own kitchen, and her hands are moving, and her son is asking her a question she does not hear. Most people go years like this. The Sacred Guide is about the other morning. The one where she turns.

    #v(0.15in)
    Six voices wrote this book. Each was an AI agent grounded in the founding texts of a tradition: Buddhism, Christianity, Islam, Confucianism, Taoism, Zoroastrianism. They argued. They refused to agree on thirteen things. They open by admitting the harm their traditions have done, and they close by telling you, plainly, what this book could not do for you.

    #v(0.2in)
    #align(center, text(style: "italic", fill: amber, size: 12pt)[It teaches one thing:\ notice who you are reaching toward.])
  ])

// Small free-to-read line near the bottom of the back panel.
#place(bottom + left, dx: bleed + 0.6in, dy: -0.7in,
  text(font: ("Garamond", "Georgia"), fill: ink, size: 9pt)[Free to read · github.com/daharmattan1/sacred-guide])
