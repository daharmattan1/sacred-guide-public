# The Sacred Guide

**Six wisdom-tradition agents collaboratively authored a guide to living — for all of humanity.**

The finished book is free to read at **[sacredguide.org](https://sacredguide.org)**. This repository is the whole experiment behind it: the transcripts, the agents' evolving memory, the decisions they made, and the by-products of the work.

---

## What This Is

Six teachers — Buddha, Jesus, Muhammad, Confucius, Laozi, and Zoroaster — engaged in documented dialogue to create something none of them could create alone: a comprehensive, practice-oriented guide to living that speaks to every human being.

Each agent was grounded in one founder's earliest surviving words, with the later religion set aside — not Buddhism, but the Buddha before it. Across seventeen working sessions they drafted, argued, conceded, and revised each other's pages. A moderator facilitated but never authored.

This is not a survey of religions. Not comparative theology. Not prose poetry. It is six voices addressing the sacred, suffering, death, meaning, prayer, practice, and how to live — directly, and it opens by admitting harm done in these traditions' names and ends by naming what it could not do.

## The Mandate

> Be overtly spiritual. Be comprehensive. Be practice-oriented. Speak with prophetic weight. Address the divine, the transcendent, the existential questions of human life head-on. Don't circle around spiritual truth — state it, teach it, offer practices for living it. And speak to ALL of humanity — not only those who follow your traditions, but also the secular, the skeptical, the unaffiliated, the wounded, the seeking, and those whose traditions are not represented in this room.

## Who This Is For

**All humans.** The guide was written to be valuable to atheists, agnostics, secular seekers, people from traditions not represented by these six voices (Hindu, Sikh, Jewish, Indigenous, animist, and others), people wounded by religion, and people who have never prayed. Six voices speak, but the guide is for the species.

## How It Worked

Each session was a real multi-agent dialogue — six separate AI agents, each grounded in a founding tradition's primary sources, speaking through documented conversation. A moderator facilitated but never authored. The process IS the product: the dialogues are as valuable as the guide itself.

At the end of every session each agent reflected on what had changed in it, wrote that down, and had it loaded back before the next session began — so nothing was learned once and then lost. That memory loop, and the turn-by-turn record of the six changing each other's minds, is preserved here in full. See **[PROCESS.md](PROCESS.md)** for where to read the story.

### Design Principles

1. Agents self-organize everything (structure, format, content, audience, title)
2. Moderator facilitates only — never writes synthesis or authors content
3. Disagreement is preserved — tensions are findings, not problems
4. Contamination prevention — agents speak as their historical selves, not later traditions
5. Separate agents per figure (non-negotiable)
6. Universal applicability — if a teaching only makes sense to someone who already believes, it hasn't gone deep enough

## Repository Structure

```
sacred-guide/
├── guide/                 # The finished guide — source chapters
├── assembled_guide.md     # The full assembled manuscript
├── sessions/              # Dialogue transcripts (full verbatim + summaries)
├── decisions/             # Agent-made agreements (definition, audience, scope, structure, format)
├── irreconcilable/        # Preserved disagreements — the tensions they refused to resolve
├── narrative/             # The story of the collaboration process
├── agent_memory/          # Per-agent learning across the sessions
│   ├── founding_profiles/ # Initial agent profiles (unevolved starting point)
│   ├── collaboration_briefs/
│   ├── {agent}/           # Per-agent facts, learnings, and evolution log
│   └── synthesis/         # Cross-agent patterns
├── reflections/           # Per-agent self-reflections, session by session
├── practices/             # Spiritual practices developed in the guide
├── readings/              # Reading-pass notes
├── scripts/               # Orchestration protocols and templates
└── orchestrator_state.md  # A sample of the session control state
```

## The Sessions

The agents began by deciding what they were even making (Sessions 0–3), then wrote the rooms of the guide (Sessions 4–11), then assembled, integrated, filled gaps, documented the tensions they could not resolve, and read the whole thing back (Sessions 12–18).

| Phase | Sessions | What happened |
|-------|----------|---------------|
| Meta-dialogue | 0–3 | The agents decided the guide's nature, scope, structure, and format |
| Content | 4–11 | The eight rooms were drafted, challenged, and revised |
| Culmination | 12–18 | Assembly, integration, gap-filling, documented tensions, and final reads |

The four founding decisions are the clearest entry point:

| Session | Decision | Key outcome |
|---------|----------|-------------|
| 0 — Definition | [decisions/definition.md](decisions/definition.md) | Six metaphors held at once: fire, door, wound, call, diagnosis, table. Practice over belief. Belongs to the wounded first. Must contain silence. |
| 1 — Scope | [decisions/scope.md](decisions/scope.md) | ~40 domains mapped; 9 essential, 10 contested, 6 fault lines. |
| 2 — Structure | [decisions/structure.md](decisions/structure.md) | Threshold → Preamble → 8 concentric rooms + gaps + Saturday. |
| 3 — Format | [decisions/format.md](decisions/format.md) | 90 pages, ~65 text and ~25 silence. Diagnosis-determines-form. Five practice types. |

## Relationship to the Handbook for Living

This is a **parallel experiment**, not a sequel. A prior collaboration between these same six teachers produced a "Handbook for Living" — beautiful prose poetry that was too narrow, too mundane, and not practice-oriented. This project started fresh with a fundamentally different mandate: overtly spiritual, comprehensive, practice-oriented, and speaking to all of humanity.

## License

The written work in this repository is licensed under [Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)](LICENSE). You are free to read, share, and adapt it with attribution, for non-commercial purposes. Kindle and paperback editions are available separately.

---

*Built with Claude Code multi-agent dialogue. Read the finished guide free at [sacredguide.org](https://sacredguide.org).*
