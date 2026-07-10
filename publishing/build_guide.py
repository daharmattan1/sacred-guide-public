#!/usr/bin/env python3
"""
Build script for The Sacred Guide PDF.
Reads guide/*.md files and converts to Typst, then compiles to PDF.

Usage:
    python build_guide.py              # generate .typ + compile
    python build_guide.py --no-compile # generate .typ only
"""

import re
import sys
import subprocess
from pathlib import Path

PUBLISHING_DIR = Path(__file__).parent
REPO_DIR = PUBLISHING_DIR.parent
GUIDE_DIR = REPO_DIR / "guide"
CHAPTERS_DIR = PUBLISHING_DIR / "chapters"

# Reading order — must match assembled_guide.md
# (00_frontmatter.md added 2026-06-27 for the KDP paperback: copyright/license + bio.)
READING_ORDER = [
    "00_frontmatter.md",
    "00_foreword.md",
    "00_threshold.md",
    "00_preamble.md",
    "01_the_table.md",
    "01_gap.md",
    "02_the_debt.md",
    "02_gap.md",
    "03_the_other.md",
    "03_gap.md",
    "04_the_crack.md",
    "04_gap.md",
    "05_the_fire.md",
    "05_gap.md",
    "06_the_reckoning.md",
    "06_gap.md",
    "07_the_question.md",
    "07_gap.md",
    "08_the_return.md",
    "08_gap.md",
    "09_saturday.md",
    "11_the_six_voices.md",
    "10_what_the_book_could_not_do.md",
]


def escape_typst(text: str) -> str:
    """Escape Typst special chars, preserving intentional markup."""
    text = text.replace("#", "\\#")
    text = text.replace("$", "\\$")
    text = text.replace("@", "\\@")
    # Don't escape < > as they appear in prose
    return text


def convert_paragraph(para: str) -> str:
    """Convert a markdown paragraph to Typst inline formatting."""
    text = escape_typst(para)
    # Bold **text** → Typst *text*. Stash behind a placeholder first so the italic
    # pass below cannot re-match the single-asterisk bold output and downgrade it to
    # italic (the run-in labels in the Six Voices appendix depend on bold surviving).
    text = re.sub(r'\*\*(.+?)\*\*', lambda m: f"\x00{m.group(1)}\x01", text)
    # Italic *text* — the bold spans are now hidden, so this only catches real italics.
    text = re.sub(r'(?<!\*)\*([^*]+?)\*(?!\*)', r'_\1_', text)
    # Restore bold as Typst strong (*text*)
    text = text.replace("\x00", "*").replace("\x01", "*")
    # Em dash — Typst uses ---
    text = text.replace(" — ", " --- ")
    text = text.replace("— ", "--- ")
    text = text.replace(" —", " ---")
    # Inline code `text` → italic in reader-facing PDF
    text = re.sub(r'`([^`]+)`', r'_\1_', text)
    # Quotes
    text = text.replace('"', '"').replace('"', '"')
    text = text.replace(''', "'").replace(''', "'")
    return text


def md_to_typst(md_text: str, is_gap: bool = False, is_aftermatter: bool = False, is_voices: bool = False, is_frontmatter: bool = False) -> str:
    """Convert a guide markdown file to Typst source.

    is_voices: the "The Six Voices" appendix — its top title renders as a level-2
    aftermatter heading (like "What the Book Could Not Do") and its per-agent ``##``
    cards render as level-3 sub-heads so they sit below the appendix title rather than
    reading as chapter-sized headings.

    is_frontmatter: the colophon (00_frontmatter.md). Its sections render as QUIET
    warm front-matter headers (#fm-section) — never chapter-sized — and its ``---``
    rules become #fm-break(). The redundant ``# The Sacred Guide`` title + the
    ``*Written by six voices*`` line are dropped (the template already prints the
    designed title page).
    """
    lines = md_text.strip().split("\n")
    output = []
    i = 0

    while i < len(lines):
        line = lines[i].rstrip()

        # Skip blank lines (we handle spacing via Typst)
        if line == "":
            i += 1
            continue

        # Markdown heading
        if line.startswith("# "):
            title = line[2:].strip()
            # Front matter: the top "# The Sacred Guide" is redundant with the
            # designed title page — drop it (and its following italic subtitle).
            if is_frontmatter:
                i += 1
                continue
            # Detect room pattern: "Room N: Title"
            m = re.match(r'Room \d+: (.+)', title)
            if m:
                room_title = m.group(1)
                output.append(f"= {room_title}")
            elif title in ("Foreword", "Threshold", "Preamble", "Saturday"):
                output.append(f"= {title}")
            elif title == "What the Book Could Not Do":
                output.append(f"== What the Book Could Not Do")
            elif title == "The Six Voices":
                output.append(f"== The Six Voices")
            else:
                output.append(f"= {title}")
            output.append("")
            i += 1
            continue

        if line.startswith("## "):
            title = line[3:].strip()
            # Front matter: quiet warm colophon header, never chapter-sized.
            if is_frontmatter:
                output.append(f"#fm-section[{title}]")
                output.append("")
                i += 1
                continue
            # In the Six Voices appendix, each agent card is a sub-head beneath the
            # appendix title — level 3, not a chapter-sized level-1 heading.
            output.append(f"=== {title}" if is_voices else f"= {title}")
            output.append("")
            i += 1
            continue

        # Epigraph line (italic, after heading)
        if line.startswith("*") and line.endswith("*") and not line.startswith("**"):
            # Front matter: drop the "*Written by six voices*" subtitle line — the
            # designed title page already carries it.
            if is_frontmatter:
                i += 1
                continue
            inner = line[1:-1]
            inner = convert_paragraph(inner)
            output.append(f"#room-epigraph[{inner}]")
            output.append("")
            i += 1
            continue

        # Scene break
        if line == "---":
            if is_frontmatter:
                # Suppress a leading rule (no ornament at the very top of the page);
                # only separate sections once real content has been emitted.
                if any(o.strip() for o in output):
                    output.append("#fm-break()")
                    output.append("")
            else:
                output.append("#scene-break()")
                output.append("")
            i += 1
            continue

        # Practice header
        if line.startswith("**Practice:"):
            practice_title = re.sub(r'\*\*Practice:\s*', '', line).rstrip("*").strip()
            output.append(f"#practice-header[{practice_title}]")
            output.append("")
            i += 1
            continue

        # Gap marker (&nbsp;)
        if line.strip() == "&nbsp;":
            i += 1
            continue

        # Aftermatter silence entries: **N — Title** — `path`
        if is_aftermatter:
            m = re.match(r'\*\*(\d+)\s*—\s*(.+?)\*\*\s*—\s*`[^`]+`', line)
            if m:
                num = m.group(1)
                title = m.group(2)
                # Skip blank lines between header and body
                i += 1
                while i < len(lines) and lines[i].strip() == "":
                    i += 1
                # Collect the body paragraph(s) that follow
                body_lines = []
                while i < len(lines) and lines[i].strip() != "" and not re.match(r'\*\*\d+\s*—', lines[i]):
                    body_lines.append(lines[i].strip())
                    i += 1
                body_text = " ".join(body_lines)
                body_text = convert_paragraph(body_text)
                output.append(f"#silence-entry[{num}][{title}][{body_text}]")
                output.append("")
                continue

        # Regular paragraph
        para_lines = [line]
        i += 1
        while i < len(lines) and lines[i].strip() != "":
            # Don't absorb headings, breaks, or special markers
            if lines[i].startswith("#") or lines[i] == "---" or lines[i].startswith("**Practice:") or lines[i].strip() == "&nbsp;":
                break
            if is_aftermatter and re.match(r'\*\*\d+\s*—', lines[i]):
                break
            para_lines.append(lines[i].rstrip())
            i += 1

        para = " ".join(para_lines)
        para = convert_paragraph(para)
        output.append(para)
        output.append("")

    # Front matter: drop a dangling trailing rule (no ornament hanging at the end).
    if is_frontmatter:
        while output and (output[-1].strip() == "" or output[-1].strip() == "#fm-break()"):
            output.pop()

    return "\n".join(output)


def build():
    """Main build function."""
    no_compile = "--no-compile" in sys.argv

    print("Building The Sacred Guide PDF...")
    CHAPTERS_DIR.mkdir(exist_ok=True)

    # Process each file in reading order
    # Group rooms with their gaps
    chapter_files = []
    total_words = 0

    i = 0
    while i < len(READING_ORDER):
        fname = READING_ORDER[i]
        src = GUIDE_DIR / fname
        if not src.exists():
            print(f"  WARNING: {fname} not found, skipping")
            i += 1
            continue

        md_text = src.read_text(encoding="utf-8")
        words = len(md_text.split())
        total_words += words

        is_gap = "_gap" in fname
        is_aftermatter = fname == "10_what_the_book_could_not_do.md"
        is_voices = fname == "11_the_six_voices.md"
        is_frontmatter = fname == "00_frontmatter.md"

        # For gaps, we append to the previous room's .typ file
        if is_gap:
            gap_typst = md_to_typst(md_text, is_gap=True)
            # Append gap to previous chapter file
            if chapter_files:
                prev_path = CHAPTERS_DIR / chapter_files[-1]
                existing = prev_path.read_text(encoding="utf-8")
                gap_wrapped = f"\n#gap[\n{gap_typst.strip()}\n]\n"
                prev_path.write_text(existing + gap_wrapped, encoding="utf-8")
                print(f"  appended gap from {fname} to {chapter_files[-1]} ({words}w)")
            i += 1
            continue

        # Regular section — convert and write
        typst_text = md_to_typst(md_text, is_aftermatter=is_aftermatter, is_voices=is_voices, is_frontmatter=is_frontmatter)

        # Prepend import so chapter can use custom functions
        import_line = '#import "../template.typ": room-epigraph, scene-break, gap, practice-header, silence-entry, fm-section, fm-break\n\n'
        typst_text = import_line + typst_text

        # Output filename
        out_fname = fname.replace(".md", ".typ")
        out_path = CHAPTERS_DIR / out_fname
        out_path.write_text(typst_text, encoding="utf-8")
        chapter_files.append(out_fname)
        print(f"  wrote {out_fname} ({words}w)")

        i += 1

    print(f"\n  Total: {total_words} words across {len(chapter_files)} chapter files")

    # Write master document
    includes = "\n".join(f'#include "chapters/{f}"' for f in chapter_files)
    master = f'''// The Sacred Guide — Master Document
// Compile: typst compile sacred-guide.typ sacred-guide.pdf

#import "template.typ": book-template, room-epigraph, scene-break, gap, practice-header, silence-entry

#show: book-template.with(
  title: "The Sacred Guide",
  subtitle: "Written by six voices",
  epigraph: [This guide will ask you to see what is in front of you. It may make what you see harder to bear.],
)

{includes}
'''
    master_path = PUBLISHING_DIR / "sacred-guide.typ"
    master_path.write_text(master, encoding="utf-8")
    print(f"  wrote sacred-guide.typ")

    # Compile
    if not no_compile:
        print("\nCompiling PDF...")
        result = subprocess.run(
            ["typst", "compile", "sacred-guide.typ", "sacred-guide.pdf"],
            cwd=str(PUBLISHING_DIR),
            capture_output=True,
            text=True,
        )
        if result.returncode == 0:
            pdf_path = PUBLISHING_DIR / "sacred-guide.pdf"
            size_kb = pdf_path.stat().st_size / 1024
            print(f"  SUCCESS: sacred-guide.pdf ({size_kb:.0f} KB)")
        else:
            print(f"  COMPILE ERROR:")
            print(result.stderr)
            print("\nFix errors and re-run, or compile manually:")
            print("  cd publishing && typst compile sacred-guide.typ")
            sys.exit(1)
    else:
        print("\nSkipped compilation (--no-compile)")
        print("To compile: cd publishing && typst compile sacred-guide.typ sacred-guide.pdf")

    print("\nDone.")


if __name__ == "__main__":
    build()
