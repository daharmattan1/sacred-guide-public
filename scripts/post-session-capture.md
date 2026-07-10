# Post-Session Memory Consolidation Protocol

After every dialogue session, consolidate agent learnings into project-local memory. This protocol ensures no insight is lost between sessions.

**Important:** Memory is PROJECT-LOCAL. Unlike the earlier Handbook collaboration, Sacred Guide memory does NOT sync back to any shared corpus store. This is a clean experiment — evolution stays within this project.

---

## Step 1: Extract Session Artifacts (Immediately After Session)

From the `live_transcript.md`, create:

1. **`sessions/NN_topic_transcript.md`** — Full verbatim dialogue, unedited
2. **`sessions/NN_topic_summary.md`** — Moderator-authored synthesis:
   - Key positions taken by each agent
   - Points of agreement
   - Points of tension or disagreement
   - Decisions reached (if any)
   - Practices proposed
   - What was left unresolved
3. **`sessions/NN_topic.json`** — Structured data:
   ```json
   {
     "session_number": NN,
     "topic": "topic_name",
     "date": "YYYY-MM-DD",
     "turn_count": N,
     "agents": ["buddha", "jesus", "muhammad", "confucius", "laozi", "zoroaster"],
     "phases_completed": ["A", "B", "C", "D", "E", "F"],
     "decisions": [],
     "irreconcilable_tensions": [],
     "practices_proposed": [],
     "key_quotes": []
   }
   ```

---

## Step 2: Per-Agent Memory Updates — NOW WRITTEN IN-SESSION (Phase G)

**IMPORTANT (Session 6+):** Per-agent memory (evolution log, collaboration brief, learning rules) is now written by the session agents themselves during Phase G, BEFORE shutdown. This step is NO LONGER done by post-session consolidation agents.

**What Phase G produces (written by each agent in their own voice):**
- Evolution log entry (appended to `agent_memory/{agent}/evolution_log.md`)
- Collaboration brief (rewritten at `agent_memory/collaboration_briefs/{agent}_brief.md`)
- Learning rules (updated at `agent_memory/{agent}/facts/learning_rules.json`)

**What post-session consolidation STILL handles:**
- Session learnings extraction: `agent_memory/{agent}/learnings/session_NN_topic.md` — synthesized from the transcript (what the agent contributed, was challenged on, learned). This is a structured extraction, not a first-person reflection.
- Phase F reflection extraction: `reflections/{agent}/session_NN_topic.md` — verbatim from transcript.

**Why the change:** Sessions 0-5 used third-party consolidation agents to write memory on behalf of the session agents. This produced accurate but weightless memory — descriptions of shifts rather than felt shifts. The Handbook for Living proved that first-person memory (written by the agent who lived the session) produces qualitatively different evolution. The sentence "I no longer believe awareness is an offering" can only be written by the agent who stopped believing it. A consolidation agent would write "Buddha shifted his position on awareness" — correct, but it shapes nothing.

See `scripts/session-protocol.md` Phase G for the full specification.

---

## Step 3: Per-Agent Reflections

Store Phase F exit interview output at:
`reflections/{agent}/session_NN_topic.md`

Extract verbatim from the transcript. These are already first-person (written by the agents during Phase F).

---

## Step 4: Session Learnings (Post-Session Extraction)

Create `agent_memory/{agent}/learnings/session_NN_topic.md`:
- What this agent contributed to the session
- Effective formulations they used (phrases that landed)
- Bridge-building moves (where they connected with another tradition)
- Productive disagreements (where tension generated insight)
- Engagement patterns that worked or didn't

**Note:** This is the ONE per-agent file that is still written by a consolidation agent, because it is a structured extraction (what happened) rather than a first-person account (what it meant). The evolution log and collaboration brief carry the first-person voice; the session learnings carry the structured record.

---

## Step 5: Narrative Updates

### 5a: Evolution Index
Append to `narrative/evolution_index.md`:
```markdown
### Session NN: [Topic] (YYYY-MM-DD)
- [Agent]: [Key relationship shift]
- [Agent] ↔ [Agent]: [New dynamic or tension]
```

### 5b: Convergences
Update `narrative/how_we_see_each_other/convergences.md`:
- New shared metaphors or concepts that emerged
- Unexpected alignments between traditions

### 5c: Process Narrative
Create `narrative/process/session_NN_topic.md`:
- Brief narrative of how the session unfolded
- What the moderator observed
- What surprised the orchestrator

---

## Step 6: Irreconcilable Tensions (If Any)

If Phase E surfaced irreducible tensions, create or update files in `irreconcilable/`:

```markdown
# [Tension Name]

## What It Is
[1-2 sentences]

## Positions
- **[Agent]**: [Their position]
- **[Agent]**: [Their position]

## Why It's Irreducible
[Why this can't be resolved without one side abandoning their core teaching]

## Why It Matters for the Guide
[Why readers need to know about this disagreement]

## First Surfaced
Session NN: [Topic]
```

---

## Checklist

After every session, verify:

**Done IN-SESSION (Phase G — by the agents themselves):**
- [ ] All 6 evolution logs appended (first-person, by agent)
- [ ] All 6 collaboration briefs rewritten (first-person, by agent)
- [ ] All 6 learning rules updated (by agent)
- [ ] All 6 reflections appended to transcript (Phase F)

**Done POST-SESSION (by consolidation or orchestrator):**
- [ ] Transcript extracted to `sessions/`
- [ ] Summary written
- [ ] JSON created
- [ ] Decision document created (if applicable)
- [ ] All 6 session learnings extracted (`agent_memory/{agent}/learnings/`)
- [ ] All 6 reflections extracted to `reflections/{agent}/`
- [ ] Evolution index updated
- [ ] Convergences updated (if new ones emerged)
- [ ] Process narrative written
- [ ] Irreconcilable tensions documented (if any)
- [ ] All changes committed and pushed
