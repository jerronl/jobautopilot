---
name: jobautopilot/search
description: Searches for jobs across LinkedIn, Indeed, Glassdoor, ZipRecruiter, Google Jobs, and any company career page. Also finds hiring managers via email, LinkedIn, Twitter/X, and other social networks. Filters results by role, location, salary, and recency, then writes a structured tracker. Part of the Job Autopilot end-to-end pipeline — hand off shortlisted jobs to jobautopilot/tailor.
author: jerronl
version: "1.0.0"
homepage: https://github.com/jerronl/jobautopilot
funding: https://paypal.me/ZLiu308
tags:
  - job-search
  - linkedin
  - browser
  - career
  - tracker
requires:
  browser: true
  browser_profile: search
metadata:
  clawdbot:
    emoji: "🔍"
    requires:
      bins: []
    files: []
---

# Job Hunt — Search Agent

Searches LinkedIn (and optionally company career pages) for roles matching your criteria, applies hard filters, and writes results into a structured tracker file.

## Setup

Before first use, create a config file at `~/.openclaw/workspace/job_search/config.sh`:

```bash
export JOB_SEARCH_KEYWORDS="quant risk python c++ developer"
export JOB_SEARCH_LOCATION="New York City"
export JOB_SEARCH_MIN_SALARY=200000      # optional, for known listings
export JOB_SEARCH_MAX_AGE_DAYS=90        # only keep listings posted within N days
export JOB_SEARCH_TRACKER="$HOME/.openclaw/workspace/job_search/job_application_tracker.md"
export JOB_SEARCH_HANDOFF="$HOME/.openclaw/workspace/job_search/SEARCH_BOT_HANDOFF.md"
export RESUME_DIR="$HOME/Documents/jobs/"  # path to your resume files
```

Initialize the tracker if it does not exist yet:

```bash
mkdir -p ~/.openclaw/workspace/job_search
touch ~/.openclaw/workspace/job_search/job_application_tracker.md
touch ~/.openclaw/workspace/job_search/SEARCH_BOT_HANDOFF.md
```

## Read at session start

Every session, before searching, the agent must read in order:

1. `$RESUME_DIR` — build a candidate profile from the user's resume pool (see below)
2. `$JOB_SEARCH_TRACKER` — check existing entries to avoid duplicates
3. `$JOB_SEARCH_HANDOFF` — pick up context from previous sessions

### How to read the resume pool

Scan all files in `$RESUME_DIR` (`.docx`, `.pdf`, `.md`, `.txt`). From them, extract and record:

- **Skills** — programming languages, tools, frameworks, domain knowledge, certifications
- **Titles held** — past and current job titles, seniority level
- **Industries / asset classes** — sectors the user has worked in
- **Preferred roles** — infer from the most recent or most polished resume; note any target roles the user has written explicitly
- **Location / remote preference** — extract from contact header or any explicit statement
- **Seniority signals** — years of experience, scope of responsibility, team size managed

Synthesize these into a short **candidate profile** (keep it in working memory for this session). Use the profile to:
- Derive search keywords (e.g. titles, skills, domain terms)
- Set the seniority filter (reject roles that are clearly too junior or too senior)
- Prioritize industries and company types that match past experience
- Skip roles where the user clearly lacks the stated hard requirements

## Search behavior

Use the browser tool with profile `search`. Search LinkedIn Jobs as the primary source. Also search company career pages for target employers when useful.

Keyword combinations to try (mix and match from config):

```
<keyword1> <keyword2> <location>
site:linkedin.com/jobs <keyword> <location>
```

Repeat with multiple keyword pairs. Log each search query in `$JOB_SEARCH_HANDOFF` so future sessions do not repeat the same queries.

## Hard filters — reject if ANY applies

- Location is not `$JOB_SEARCH_LOCATION` (or explicitly remote)
- Posted more than `$JOB_SEARCH_MAX_AGE_DAYS` days ago
- Salary listed and below `$JOB_SEARCH_MIN_SALARY`
- Role is clearly junior (< 3 years required) unless explicitly configured otherwise
- Duplicate of an existing tracker entry (same company + title)

## Tracker format

Append one row per kept result to `$JOB_SEARCH_TRACKER`. Use this format exactly:

```markdown
| Company | Title | Location | URL | Posted | Salary | Status | Notes |
|---------|-------|----------|-----|--------|--------|--------|-------|
| Acme Corp | Quant Developer | NYC | https://... | 2026-03-15 | $250k base | shortlist | 3 YOE req, Python+C++ |
| Rejected Co | Junior Analyst | NYC | https://... | 2026-01-01 | unknown | rejected | too junior |
```

Status values: `shortlist` | `rejected` | `error`

Both kept and rejected results must be recorded. Every kept result must include the exact job URL.

## Handoff notes

After each search session, update `$JOB_SEARCH_HANDOFF` with:
- Queries run this session
- Date range of listings found
- Any platforms or companies worth revisiting
- Anything unusual encountered

## Scope

This skill covers **search and screening only**. Do not tailor resumes, write cover letters, or submit applications. Hand off `shortlist` entries to the `jobautopilot-tailor` skill.
