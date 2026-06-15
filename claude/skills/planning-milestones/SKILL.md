---
name: planning-milestones
description: Use when you have an approved design spec (typically from brainstorming) and the feature is too large to ship as a single plan or PR. Triggers when you need to decompose a spec into ordered, reviewable milestones before any implementation begins.
---

# Planning Milestones

## Overview

Turn an approved design spec into an ordered milestones plan, then have Codex independently review the plan for inconsistencies, scope issues, and gaps. Apply severity-tagged findings before finalizing.

**Announce at start:** "I'm using the planning-milestones skill to break this spec into milestones."

## When to Use

- A brainstorming spec exists (typically `docs/superpowers/specs/<date>-<topic>-design.md`) but is too large for a single plan/PR
- You need a sequenced roadmap with explicit dependencies before implementation
- You want an independent Codex review of the decomposition before committing to it

**Don't use when:**
- No design spec exists yet → use `superpowers:brainstorming` first
- The feature fits in a single plan → skip straight to `superpowers:writing-plans`

## The Process

### Step 1: Locate the source spec

1. If the user supplied a path, use it
2. Otherwise list `docs/superpowers/specs/*-design.md`, pick the most recent, and confirm with the user if ambiguous
3. Read the spec end to end before drafting anything

### Step 2: Resolve ordering ambiguity (only if needed)

If the spec leaves milestone ordering or grouping genuinely ambiguous, ask one targeted question:
- Risk-first vs value-first?
- Any pieces that must ship together?

Do NOT brainstorm requirements here — the spec is the source of truth. If requirements are incomplete, stop and send the user back to `superpowers:brainstorming`.

### Step 3: Draft the milestones plan

Write `docs/superpowers/milestones/YYYY-MM-DD-<topic>-milestones.md` containing:

- **Source spec**: link to the design doc
- **Overview**: one paragraph on the decomposition strategy
- **Milestones** (numbered). For each:
  - **Goal**: one sentence
  - **In scope**: bullets
  - **Out of scope**: bullets — explicit, prevents creep
  - **Deliverables**: concrete artifacts (files, endpoints, UI states, migrations)
  - **Dependencies**: which prior milestones must land first
  - **Success criteria**: how you know it is done (tests, demos, manual checks)

Each milestone should be small enough to plan as one `superpowers:writing-plans` pass and ship as one PR.

### Step 4: Self-review

Before involving Codex, scan for:
- Placeholders (TBD, TODO, "figure out later")
- Contradictions between milestones
- Milestones that bundle unrelated work
- Missing dependencies (milestone N references something not delivered in 1..N-1)
- Gaps vs the source spec (requirements not covered anywhere)
- Scope creep beyond the spec

Fix inline.

### Step 5: Commit the draft

```bash
git add docs/superpowers/milestones/<file>
git commit -m "Draft milestones plan for <topic>"
```

### Step 6: Codex review

Dispatch one Codex review call via the rescue subagent. The review must be read-only — Codex returns findings, you apply them.

```
Agent({
  subagent_type: "codex:codex-rescue",
  description: "Codex review of milestones plan",
  prompt: "Review docs/superpowers/milestones/<file> against its source spec at docs/superpowers/specs/<spec-file>. This is read-only — do not modify any files. Find: (1) inconsistencies between milestones, (2) missing or wrong dependencies, (3) milestones too large to plan as a single pass or too small to be meaningful, (4) unclear or unmeasurable success criteria, (5) requirements from the source spec not covered by any milestone, (6) scope creep beyond the spec. Output a numbered findings list. Prefix every finding with one of [critical], [high], [medium], [low]. critical = blocks implementation. high = wrong order or coverage that will cause rework. medium = clarity or quality issues that should be fixed. low = style or nice-to-have. End with one sentence on whether the plan is approvable as-is or needs revision."
})
```

Notes:
- Do not pass `--write` — this is a review, not a fix run
- Leave `--model` unset (default GPT-5.4)
- The rescue subagent returns Codex's stdout verbatim

### Step 7: Apply findings by severity

For each finding:
- **critical / high / medium** → apply automatically by editing the milestones doc
- **low** → present to the user, ask whether to apply

After auto-applying critical/high/medium, show the user the resulting diff before committing.

### Step 8: Commit final

```bash
git add docs/superpowers/milestones/<file>
git commit -m "Apply Codex review findings to <topic> milestones"
```

Tell the user: "Milestones plan finalized at `<path>`. Ready to invoke `executing-milestones` when you want to start."

## Quick Reference

| Step | Owner | Output |
|------|-------|--------|
| Locate spec | opus | spec path confirmed |
| Draft milestones | opus | draft milestones doc |
| Self-review | opus | cleaned draft |
| Commit draft | opus | git commit |
| Codex review | codex-rescue (read-only) | severity-tagged findings |
| Apply findings | opus | edited milestones doc |
| Commit final | opus | git commit |

## Common Mistakes

- **Brainstorming requirements at this stage** — the spec is the source of truth; if it is incomplete, go back to brainstorming
- **Milestones too big** — if a milestone needs >5 sub-tasks or touches >10 files, split it
- **Missing out-of-scope bullets** — without them, milestones grow during implementation
- **Skipping the Codex review** — the independent pass catches blind spots; do not rationalize past it
- **Passing `--write` to the Codex review call** — review must be read-only, application is the main thread's job
- **Applying low-severity findings without asking** — keeps the user in control of nice-to-haves

## Integration

- **Input from:** `superpowers:brainstorming` (provides the design spec)
- **Output to:** `executing-milestones` (consumes the milestones plan, drives implementation)
