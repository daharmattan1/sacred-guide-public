#!/usr/bin/env python3
"""
Build a reflowable EPUB of The Sacred Guide from the source markdown.

Pure-Python (ebooklib + markdown) — no pandoc/java needed. Reads guide/*.md
in reading order (front matter first), one EPUB chapter per file, builds a
working nav TOC, embeds the cover, and sets metadata.

Usage:
    python build_epub.py
Output:
    publishing/sacred-guide.epub
"""

import re
from pathlib import Path
import markdown
from ebooklib import epub

PUBLISHING_DIR = Path(__file__).parent
REPO_DIR = PUBLISHING_DIR.parent
GUIDE_DIR = REPO_DIR / "guide"
COVER_PATH = PUBLISHING_DIR / "cover" / "cover_front.png"

# Front matter first, then the same reading order as the PDF.
# Each tuple: (filename, nav-title). Gaps fold into the preceding room.
SECTIONS = [
    ("00_frontmatter.md", None),          # title/license/about — no separate TOC entry beyond title
    ("00_foreword.md", "Foreword"),
    ("00_threshold.md", "Threshold"),
    ("00_preamble.md", "Preamble"),
    ("01_the_table.md", "Room 1: The Table"),
    ("01_gap.md", None),
    ("02_the_debt.md", "Room 2: The Debt"),
    ("02_gap.md", None),
    ("03_the_other.md", "Room 3: The Other"),
    ("03_gap.md", None),
    ("04_the_crack.md", "Room 4: The Crack"),
    ("04_gap.md", None),
    ("05_the_fire.md", "Room 5: The Fire"),
    ("05_gap.md", None),
    ("06_the_reckoning.md", "Room 6: The Reckoning"),
    ("06_gap.md", None),
    ("07_the_question.md", "Room 7: The Question"),
    ("07_gap.md", None),
    ("08_the_return.md", "Room 8: The Return"),
    ("08_gap.md", None),
    ("09_saturday.md", "Saturday"),
    ("11_the_six_voices.md", "The Six Voices"),
    ("10_what_the_book_could_not_do.md", "What the Book Could Not Do"),
]

CSS = """
body { font-family: Georgia, 'Times New Roman', serif; line-height: 1.55; margin: 5% 6%; color: #2D2A26; }
h1 { font-variant: small-caps; font-weight: normal; letter-spacing: 0.08em; text-align: center;
     font-size: 1.5em; margin: 2.5em 0 1.5em; }
h2 { font-variant: small-caps; font-weight: normal; letter-spacing: 0.06em; text-align: center;
     font-size: 1.2em; margin: 2em 0 1.2em; }
p { text-indent: 1.4em; margin: 0; }
p:first-of-type, h1 + p, h2 + p, hr + p { text-indent: 0; }
em { font-style: italic; }
hr { border: none; text-align: center; margin: 1.6em 0; }
hr:after { content: "* * *"; letter-spacing: 0.4em; color: #9B5B3A; }
blockquote { font-style: italic; margin: 1.4em 2em; }
.frontmatter p { text-indent: 0; margin: 0.6em 0; }
"""


def md_file_to_html(md_text: str, frontmatter: bool = False) -> str:
    html = markdown.markdown(md_text.strip(), extensions=["extra"])
    if frontmatter:
        html = f'<div class="frontmatter">{html}</div>'
    return html


def build():
    book = epub.EpubBook()
    book.set_identifier("the-sacred-guide-2026-first-edition")
    book.set_title("The Sacred Guide")
    book.set_language("en")
    book.add_author("Victor Sowers")
    book.add_metadata("DC", "description",
                      "A guide to attending, written by six AI agents grounded in the founding "
                      "texts of six wisdom traditions. It opens by admitting harm and ends by "
                      "naming what it could not do.")
    book.add_metadata("DC", "rights", "Creative Commons Attribution-NonCommercial 4.0 (CC BY-NC 4.0)")
    book.add_metadata("DC", "subject", "Spirituality")
    book.add_metadata("DC", "subject", "Comparative Religion")

    # Cover
    if COVER_PATH.exists():
        book.set_cover("cover.png", COVER_PATH.read_bytes())

    # Stylesheet
    css = epub.EpubItem(uid="style", file_name="style/main.css",
                        media_type="text/css", content=CSS)
    book.add_item(css)

    chapters = []
    toc = []
    n_files = 0
    total_words = 0

    for fname, nav_title in SECTIONS:
        src = GUIDE_DIR / fname
        if not src.exists():
            print(f"  WARNING: {fname} not found, skipping")
            continue
        md_text = src.read_text(encoding="utf-8")
        total_words += len(md_text.split())
        n_files += 1
        is_fm = fname == "00_frontmatter.md"

        if fname.endswith("_gap.md"):
            # Fold the gap into the previous chapter as a centered breathing space.
            gap_html = md_file_to_html(md_text)
            if chapters:
                chapters[-1].content += f'<div style="margin:2.5em 0;text-align:center;font-style:italic;">{gap_html}</div>'
            continue

        slug = fname.replace(".md", "").replace("_", "-")
        ch = epub.EpubHtml(title=(nav_title or "The Sacred Guide"),
                           file_name=f"{slug}.xhtml", lang="en")
        ch.add_item(css)
        ch.content = f'<html><head></head><body>{md_file_to_html(md_text, frontmatter=is_fm)}</body></html>'
        book.add_item(ch)
        chapters.append(ch)
        if nav_title:
            toc.append(ch)

    book.toc = tuple(toc)
    book.add_item(epub.EpubNcx())
    book.add_item(epub.EpubNav())
    book.spine = ["cover", "nav"] + chapters

    out = PUBLISHING_DIR / "sacred-guide.epub"
    epub.write_epub(str(out), book)
    size_kb = out.stat().st_size / 1024
    print(f"  SUCCESS: sacred-guide.epub ({size_kb:.0f} KB)")
    print(f"  {n_files} source files, {total_words} words, {len(toc)} TOC entries, "
          f"{len(chapters)} spine chapters")
    print(f"  cover embedded: {COVER_PATH.exists()}")


if __name__ == "__main__":
    build()
