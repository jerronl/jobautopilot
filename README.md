# Job Autopilot

**Job Autopilot** is a three-agent pipeline that takes you from job discovery to submitted application — automatically.

Instead of spending hours searching, rewriting your resume, and filling out forms, you run three skills in sequence and let OpenClaw do the work.

---

## How it works

```
jobautopilot/search  ──►  jobautopilot/tailor  ──►  jobautopilot/submit
   Find jobs               Tailor your resume          Fill & submit forms
   Filter & track          Write cover letter          Verify & confirm
```

Each skill hands off to the next via a shared tracker file. You stay in control — review the tracker at any stage before proceeding.

---

## The three skills

### 🔍 Search (`jobautopilot/search`)
Reads your resume pool to build a candidate profile — your skills, past titles, and target industries. Then searches LinkedIn, Indeed, Glassdoor, ZipRecruiter, Google Jobs, and company career pages for matching roles. No keyword config needed. Filters by role, location, salary, and recency, then writes results to a tracker.

### 📄 Tailor (`jobautopilot/tailor`)
Reads each shortlisted job, fetches the full job description, and rewrites your resume bullet points to match. Produces a tailored `.docx` resume and cover letter for each role — using only your real experience, nothing made up.

### 🚀 Submit (`jobautopilot/submit`)
Opens the application page, fills out multi-step forms (work history, education, EEOC, dropdowns), uploads your tailored resume and cover letter, and confirms the submission went through. Builds a platform knowledge base so it gets smarter with each application.

---

## Your resume pool

The resume pool is a folder on your computer where you keep all your career documents. Job Autopilot reads this folder before doing anything else.

```
~/Documents/jobs/          ← your resume pool (set during setup)
├── Resume_2026.docx       ← your master resume
├── Resume_Finance.docx    ← a domain-specific version (optional)
├── skills.md              ← extra skills, certifications, side projects
├── bio.txt                ← short bio or personal statement (optional)
└── tailored/              ← generated files go here automatically
    ├── Acme_QuantDev_Resume_2026.docx
    └── Acme_QuantDev_Cover_Letter_2026.docx
```

**The Search agent** reads your pool at the start of every session to build a candidate profile — your skills, past titles, industries, and seniority level. It uses this to derive search keywords and filter out roles that don't fit, without you having to configure anything manually.

**The Tailor agent** reads your pool as raw material. Every bullet point it writes comes from something already in your files — a past achievement, a tool you listed, a metric you documented. Nothing is invented.

**Tips for a strong pool:**
- Keep a master resume with your full history, even items you'd normally cut for length — the agent picks the most relevant ones per role
- Add a `skills.md` for certifications, tools, and side projects that don't fit neatly into a resume
- Older tailored versions are useful too — the agent learns phrasing that worked for similar roles

To change your pool location after setup, edit `~/.openclaw/users/<you>/config.sh` and update `RESUME_DIR`.

---

## Quickstart

### 1. Install

```bash
clawhub install jerronl/jobautopilot-bundle
bash skills/jobautopilot-bundle/install.sh
```

This installs all three skills at once. Or install them individually if you only need part of the pipeline:

```bash
clawhub install jerronl/jobautopilot-search
clawhub install jerronl/jobautopilot-tailor
clawhub install jerronl/jobautopilot-submitter
```

### 2. Set up

```bash
bash setup.sh
```

Setup asks for your name, email, phone, LinkedIn, resume folder, job search preferences, and EEOC defaults. It writes your config, copies scripts, and creates the workspace. Takes about 2 minutes.

### 3. Run

Just tell OpenClaw what you want:

> *"Search for quant developer jobs in New York"*

> *"Tailor my resume for the shortlisted jobs"*

> *"Submit applications for all resume-ready jobs"*

---

## Tracker status flow

The tracker is a markdown file that records every job and its current stage:

| Status | Meaning |
|--------|---------|
| `shortlist` | Found by Search, ready for tailoring |
| `md_ready` | Resume draft written, converting to docx |
| `resume_ready` | Docx files ready, ready to submit |
| `applied` | Application submitted and confirmed |
| `rejected` | Filtered out during search |
| `error` | Something went wrong — check the notes column |

---

## Your local TOOLS.md

After setup, create a `TOOLS.md` file in your OpenClaw workspace to record your personal environment details. Skills are shared — your setup is yours.

```markdown
# TOOLS.md - Local Notes

### Resume tools

- **md_to_docx.py** (at `~/.openclaw/workspace/resumes/`)
  - Usage: `python3 md_to_docx.py <resume.md> <template.docx> <output.docx>`
  - Template: `~/.openclaw/workspace/resumes/sample_placeholders.docx`

- **Cover letter tool**
  - Uses python-docx directly, no template needed
  - Default: Calibri 11pt

### Paths

- Resume pool:    /path/to/your/Documents/jobs/
- Output folder:  ~/.openclaw/workspace/resumes/
- Tracker:        ~/.openclaw/workspace/job_search/job_application_tracker.md
```

Keep this file next to your config. It's your cheat sheet — add anything environment-specific (SSH hosts, device names, preferred voices, etc.).

## Requirements

- OpenClaw >= 2026.2.0
- Browser tool enabled — `setup.sh` creates the two required profiles automatically:
  - `search` profile for the Search agent
  - `apply` profile for the Submit agent
- `pip install python-docx`

---

## Source & license

GitHub: [github.com/jerronl/jobautopilot](https://github.com/jerronl/jobautopilot)

MIT-0 — free to use, modify, and redistribute. No attribution required.

## Support

If Job Autopilot saved you time, a coffee is always appreciated ☕

[![PayPal](./qr-paypal.png)](https://paypal.me/ZLiu308)

[paypal.me/ZLiu308](https://paypal.me/ZLiu308)
