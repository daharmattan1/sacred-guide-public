// The Sacred Guide — Master Document
// Compile: typst compile sacred-guide.typ sacred-guide.pdf

#import "template.typ": book-template, room-epigraph, scene-break, gap, practice-header, silence-entry

#show: book-template.with(
  title: "The Sacred Guide",
  subtitle: "Written by six voices",
  epigraph: [This guide will ask you to see what is in front of you. It may make what you see harder to bear.],
)

#include "chapters/00_frontmatter.typ"
#include "chapters/00_foreword.typ"
#include "chapters/00_threshold.typ"
#include "chapters/00_preamble.typ"
#include "chapters/01_the_table.typ"
#include "chapters/02_the_debt.typ"
#include "chapters/03_the_other.typ"
#include "chapters/04_the_crack.typ"
#include "chapters/05_the_fire.typ"
#include "chapters/06_the_reckoning.typ"
#include "chapters/07_the_question.typ"
#include "chapters/08_the_return.typ"
#include "chapters/09_saturday.typ"
#include "chapters/11_the_six_voices.typ"
#include "chapters/10_what_the_book_could_not_do.typ"
