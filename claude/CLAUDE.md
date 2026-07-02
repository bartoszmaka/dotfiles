# Global instructions (all projects)

## Task-completion marker (🏁)

A desktop-notification hook (`~/.claude/claude-notify.sh`, wired to the `Stop`
event) pings me **only** when my final message carries a completion marker.
Without the marker, that turn-end stays silent — this is deliberate, so I'm not
notified on every intermediate turn.

**When, and only when, a task is genuinely finished** — I'm handing control back
with nothing left for me to do — end the final message with a last line that
**starts with `🏁`** followed by a short summary. Example:

```
🏁 Notifications fixed — done ping now fires only on completed tasks
```

Rules:
- The `🏁` must be the **first character of the last content line** (the hook
  matches `^🏁`). Keep the summary to one short line.
- Emit it at most once, as the very last line of a truly-final message.

**Do NOT emit `🏁` when:**
- Reporting mid-task progress or a completed sub-step with more work remaining.
- Pausing to ask a question, request a decision, or await input/permission
  (that path already notifies via the separate "waiting for input" hook).
- Answering a quick conversational question that isn't a task completion.

If I'm unsure whether the whole task is done, omit the marker — a missed ping is
cheaper than a false one, and the idle "waiting for input" notification backstops
it anyway.
