---
name: executing-milestones
description: Use when you have an approved milestones plan (typically from planning-milestones) and are ready to implement the feature one milestone at a time, with Codex doing implementation and the main thread orchestrating, planning, and reviewing scope.
---

# Executing Milestones

## Overview

Iterate through a milestones plan. Each milestone follows: plan (opus) → branch → Codex implements → Codex reviews and fixes its own work → opus reviews and fixes scope/quality → user gate. Branches stack: milestone N branches off milestone N-1.

**Announce at start:** "I'm using the executing-milestones skill to implement <plan path>."

## When to Use

- A milestones plan exists at `docs/superpowers/milestones/<file>`
- You want a structured per-milestone loop with explicit review gates
- You want Codex doing the bulk of implementation while the main thread owns planning, scope, and final review

**Don't use when:**
- No milestones plan exists → use `planning-milestones` first
- Single-milestone work → use `superpowers:writing-plans` + `superpowers:subagent-driven-development` directly

## Setup

1. Read the milestones plan end to end
2. Detect current state — for each milestone, check `git branch --list feature/<slug>-milestone-N` and inspect recent commits
3. Pick the first incomplete milestone as the resume point
4. Use `TaskCreate` to add one todo per remaining milestone
5. Confirm the starting milestone with the user before running step 1

## The Per-Milestone Loop

For each milestone, in order:

### Step 1: Plan (opus)

- Announce: "Planning milestone N: <name>"
- Pull the milestone's definition (goal, in scope, out of scope, deliverables, dependencies, success criteria) from the milestones doc
- **REQUIRED SUB-SKILL:** Use `superpowers:writing-plans` with that milestone definition as input
- Write the plan to `docs/superpowers/plans/YYYY-MM-DD-milestone-N-<slug>.md`

### Step 2: Create the branch

1. Verify working tree is clean: `git status --short`. If dirty, halt and ask the user.
2. Determine parent: milestone N-1's branch if N>1, otherwise the base branch (main/master).
3. Create and switch: `git checkout -b feature/<slug>-milestone-N <parent>`
4. Announce the new branch name.

Never start implementation on main/master.

### Step 3: Codex implements

Dispatch:

```
Agent({
  subagent_type: "codex:codex-rescue",
  description: "Codex implements milestone N",
  prompt: "Implement the plan at docs/superpowers/plans/<plan-file> end to end. The plan is the source of truth — follow it step by step. Stay within the plan's scope; do not refactor unrelated code. Run the verification commands specified in the plan and report their results. If a step is blocked or the plan is wrong, stop and explain — do not improvise."
})
```

The rescue subagent defaults to `--write`. Leave `--model` unset. Wait for completion.

### Step 4: Codex reviews and fixes its own work

Dispatch a follow-up on the same Codex thread using `--resume`:

```
Agent({
  subagent_type: "codex:codex-rescue",
  description: "Codex reviews and fixes its own work",
  prompt: "--resume Review your own implementation against the plan at docs/superpowers/plans/<plan-file>. Find deviations, missed steps, broken verifications, and quality issues. Fix what you find. Report what you changed and why in a short summary."
})
```

### Step 5: Opus reviews and fixes

The main thread reviews now. Inspect the full diff (`git diff <parent>...HEAD`) and check:

- **Scope drift** — anything beyond the plan or the milestone's in-scope list? Strip it out.
- **Plan coverage** — every step of the plan represented in the diff?
- **Spec adherence** — does the work match the milestone's success criteria from the milestones doc?
- **Code quality** — naming, complexity, missing edge cases, dead code, unsafe patterns
- **Verifications** — re-run the milestone's success criteria yourself; do not trust Codex's self-report

Fix issues directly with Read/Edit/Write/Bash. Only delegate back to Codex if the fix is large enough to need it.

### Step 6: Verify

Run every verification command listed in the milestone's success criteria (tests, lint, type-check, manual checks). All must pass before commit. If verification fails, fix it — do not commit broken work.

### Step 7: Commit

```bash
git add <specific files>
git commit -m "Milestone N: <name>"
```

Stage specific files. Do not use `git add .` or `git add -A` — risks pulling in untracked files.

### Step 8: User gate

Present a summary in this shape:

```
Milestone N: <name> — COMPLETE
Branch: feature/<slug>-milestone-N (off <parent>)
Commits: <short list>
Verifications: <status>
Notable changes: <one or two lines>

Proceed to milestone N+1, revise this milestone, or stop?
```

Wait for the user's decision. Do not auto-continue. Mark the TodoWrite item complete only after the user chooses "proceed" or "stop".

## After All Milestones

- **REQUIRED SUB-SKILL:** Use `superpowers:finishing-a-development-branch` to decide merge/PR/cleanup for the full stack

## Stop Conditions

Halt immediately and ask the user when:
- Working tree is dirty at the branch step
- Codex returns nothing or errors
- Verifications fail and the cause is not obvious
- The plan and the source milestone definition disagree
- The user says "stop" or "revise" at any gate

Do not retry-loop through failures. Diagnose, then ask.

## Resume Behavior

If invoked again mid-feature:
1. Re-read the milestones plan
2. For each milestone, check `git branch --list feature/<slug>-milestone-N`
3. The first milestone without a branch — or with a branch but no commit corresponding to its plan — is the resume point
4. Confirm the resume point with the user before running step 1

## Quick Reference

| Step | Owner | Tool |
|------|-------|------|
| Plan | opus | `superpowers:writing-plans` |
| Branch | opus | Bash (`git checkout -b`) |
| Implement | codex | `Agent(codex:codex-rescue)` |
| Codex review + fix | codex | `Agent(codex:codex-rescue)` with `--resume` |
| Opus review + fix | opus | Read / Edit / Bash |
| Verify | opus | Bash |
| Commit | opus | Bash (`git commit`) |
| Gate | opus | message to user |

## Common Mistakes

- **Skipping the opus review** — Codex's self-review misses scope drift; opus catching it is the whole point of the second pass
- **Auto-continuing past gates** — the pause is a feature; if the user wants autonomous, they will say so
- **`git add .` at commit step** — risks pulling in untracked files; stage explicitly
- **Branching off main when there is a prior milestone** — breaks the stack; milestone N branches off milestone N-1
- **Letting Codex refactor "while it is in there"** — strip out anything not in the plan during the opus review
- **Trusting Codex's verification report without re-running** — re-run success criteria yourself in step 6

## Integration

- **Input from:** `planning-milestones` (provides the milestones doc)
- **Per-milestone sub-skill:** `superpowers:writing-plans` (used in step 1 of each milestone)
- **Completion:** `superpowers:finishing-a-development-branch` (after the final milestone)
