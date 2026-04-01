---
name: jobautopilot-bundle
description: Installs the full Job Autopilot pipeline — search jobs, tailor resumes, and submit applications. Convenience bundle that installs jobautopilot-search, jobautopilot-tailor, and jobautopilot-submitter in one place.
author: jerronl
version: "1.1.0"
homepage: https://github.com/jerronl/jobautopilot
funding: https://paypal.me/ZLiu308
tags:
  - job-search
  - resume
  - career
  - automation
metadata:
  clawdbot:
    emoji: "🤖"
    requires:
      bins: []
    files:
      - install.sh
---

# Job Autopilot — Full Bundle

Install all three Job Autopilot skills and run the full end-to-end pipeline:
**search → tailor → submit**.

## Install all three skills

```bash
clawhub install jobautopilot-search
clawhub install jobautopilot-tailor
clawhub install jobautopilot-submitter
```

## Then run setup

`setup.sh` is included in the `jobautopilot-bundle` skill folder after install:

```bash
bash skills/jobautopilot-bundle/setup.sh
```

Setup takes about 2 minutes — it asks for your name, email, resume folder location, and job search preferences, then writes your config and copies scripts.

## How it works

```
jobautopilot/search  ──►  jobautopilot/tailor  ──►  jobautopilot-submitter
   Find jobs               Tailor resume              Fill & submit forms
   Filter & track          Write cover letter         Verify & confirm
```

Just tell OpenClaw what you want:

> *"Search for software engineer jobs in New York"*

> *"Tailor my resume for the shortlisted jobs"*

> *"Submit applications for all resume-ready jobs"*

## Privacy & data storage

Setup collects the following personal information and stores it **locally only**:

| Data | Stored at |
|------|-----------|
| Name, email, phone, LinkedIn | `~/.openclaw/users/<you>/config.sh` |
| Resume files | Your existing folder (you choose during setup) |
| Tailored resumes & cover letters | `~/.openclaw/workspace/resumes/` |
| Job tracker | `~/.openclaw/workspace/job_search/job_application_tracker.md` |

No data is sent to any third party. Browser automation uses two isolated profiles (`search` and `apply`) created locally. Credentials for job sites are stored only in your browser profile cookies — never in config files.

## Requirements

- OpenClaw >= 2026.2.0
- Browser tool enabled
- `pip install python-docx`

## Support

[![PayPal](https://github.com/jerronl/jobautopilot/raw/main/qr-paypal.png)](https://paypal.me/ZLiu308)

[paypal.me/ZLiu308](https://paypal.me/ZLiu308)
