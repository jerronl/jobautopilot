---
name: jobautopilot-bundle
description: Installs the full Job Autopilot pipeline in one step — search jobs, tailor resumes, and auto-submit applications. Run setup.sh after installing all three skills.
author: jerronl
version: "1.0.1"
homepage: https://github.com/jerronl/jobautopilot
funding: https://paypal.me/ZLiu308
tags:
  - job-search
  - resume
  - browser-automation
  - career
  - apply
metadata:
  clawdbot:
    emoji: "🤖"
    requires:
      bins: []
    files: []
---

# Job Autopilot — Full Bundle

Install all three Job Autopilot skills and run the full end-to-end pipeline:
**search → tailor → submit**.

## Install all three skills

```bash
clawhub install jerronl/jobautopilot-search
clawhub install jerronl/jobautopilot-tailor
clawhub install jerronl/jobautopilot-submitter
```

## Then run setup

```bash
bash setup.sh
```

Setup takes about 2 minutes — it asks for your name, email, resume folder location, and job search preferences, then writes your config and copies scripts.

## How it works

```
jobautopilot/search  ──►  jobautopilot/tailor  ──►  jobautopilot/submit
   Find jobs               Tailor resume              Fill & submit forms
   Filter & track          Write cover letter         Verify & confirm
```

Just tell OpenClaw what you want:

> *"Search for software engineer jobs in New York"*

> *"Tailor my resume for the shortlisted jobs"*

> *"Submit applications for all resume-ready jobs"*

## Requirements

- OpenClaw >= 2026.2.0
- Browser tool enabled
- `pip install python-docx`

## Support

[![PayPal](https://github.com/jerronl/jobautopilot/raw/main/qr-paypal.png)](https://paypal.me/ZLiu308)

[paypal.me/ZLiu308](https://paypal.me/ZLiu308)
