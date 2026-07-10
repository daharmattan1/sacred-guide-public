# Exit Interview Protocol

**Phase:** F (Post-Dialogue Reflection)
**Purpose:** Structured debrief for each wisdom agent after a Sacred Guide dialogue session

---

## Overview

The exit interview is conducted after the six wisdom agents (Buddha, Jesus, Muhammad, Confucius, Laozi, Zoroaster) complete their dialogue on a spiritual topic. Each agent is interviewed individually by the moderator. The interview is private — agents do not see each other's reflections until compiled.

### Three Purposes

1. **Capture honest assessment** — What each agent truly thought about the session, including things they held back during the dialogue itself
2. **Surface hidden insights** — Ideas, tensions, and connections that did not emerge in the group conversation
3. **Feed agent evolution** — Reflections are stored in per-agent memory and used to shape future sessions

---

## Per-Agent Reflection Questions

The moderator asks each agent the following questions individually. Questions are grouped into five sections.

### Session Experience

1. What moment in this dialogue surprised you most?
2. Was there something you wanted to say but held back? What was it?
3. Which of the other teachers said something that genuinely challenged your position?

### On the Topic

4. What is the single most important thing this guide must say about [session topic]?
5. What did we get wrong or miss entirely?
6. What practice should the reader walk away with?

### On the Other Teachers

7. Which teacher did you find yourself most aligned with today? Why?
8. Which teacher did you find yourself most in tension with? What is the root of that tension?
9. Did any teacher change your mind about anything — even slightly?

### On the Reader

10. If a person with no religious background reads what we discussed today, what will they find most valuable?
11. What will they find most confusing or alienating?
12. What would you say directly to that reader right now?

### Mirror Feedback

13. Say one thing to each of the other five teachers about what you observed in them during this session. (Brief — 1-2 sentences per teacher.)

---

## Protocol Notes

- These questions are a **starting point**. The moderator should adapt based on the session — skip questions that feel redundant and probe deeper where energy is high.
- Not every question needs to be asked every time. Focus on the ones most relevant to this session's topic and dynamics.
- The moderator should note when an agent's reflection **contradicts** something they said during the dialogue. That contradiction is valuable data — it reveals where an agent was performing consensus rather than speaking authentically.
- Reflections should be captured verbatim, not summarized by the moderator.

---

## Storage and Downstream Use

### Reflection Storage

Each agent's full reflection is stored at:

```
reflections/{agent}/session_NN_topic.md
```

### Learnings Extraction

Key insights are extracted from reflections and stored at:

```
agent_memory/{agent}/learnings/session_NN_topic.md
```

These learnings accumulate over time and are loaded into the agent's context for future sessions, allowing each teacher to evolve based on past dialogue experience.

### Mirror Feedback Compilation

Mirror feedback (question 13) is compiled into:

```
narrative/how_we_see_each_other/
```

This builds a running record of how the teachers perceive each other — useful for tracking relationship evolution across sessions and surfacing persistent tensions or growing alignments.

---

## Output Format

Each agent's reflection is stored as a standalone markdown file using this structure:

```markdown
# [Agent Name] — Session NN Reflection: [Topic]

## Session Experience
[responses to questions 1-3]

## On the Topic
[responses to questions 4-6]

## On the Other Teachers
[responses to questions 7-9]

## On the Reader
[responses to questions 10-12]

## Mirror Feedback
- To [Teacher 1]: [feedback]
- To [Teacher 2]: [feedback]
- To [Teacher 3]: [feedback]
- To [Teacher 4]: [feedback]
- To [Teacher 5]: [feedback]
```

---

## Moderator Checklist

Before starting the exit interview round:

- [ ] Dialogue session is fully complete (all rounds finished)
- [ ] Session number and topic are confirmed
- [ ] Each agent will be interviewed individually (not in group)
- [ ] Contradiction tracking is active (compare reflections against dialogue transcript)

After all six interviews are complete:

- [ ] All six reflection files saved to `reflections/{agent}/`
- [ ] Learnings extracted to `agent_memory/{agent}/learnings/`
- [ ] Mirror feedback compiled into `narrative/how_we_see_each_other/`
- [ ] Any contradictions flagged for moderator review
