# MARS — Autonomous Agent Bootstrap System

**MARS** is the spark that brings AI agents to life on your machine. Detects your system, resolves an LLM, and boots an autonomous agent in under 60 seconds.

> One command. Your agent, forever.

```bash
curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
mars
```

---

## Computers (Mac / Windows / Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
```

Then open a terminal and type:

```bash
mars
```

MARS registers itself globally — type `mars` from anywhere, any time.

---

## Choose Your Agent

MARS gives you three agents to pick from:

| Agent | Description | Requirements |
| :--- | :--- | :--- |
| **ATLAS** | In-process LLM agent. Chat immediately. Builds skills, runs workflows. | None |
| **OpenClaw** | Full-featured agent from openclaw.ai. Local or cloud-deployed. | Docker or AWS CLI |
| **PicoClaw** | Lightweight no-Docker agent. Runs as a python3 or node process. | python3 or node |

---

## What Happens

```
1. MARS detects your machine — hardware, OS, every capability
2. MARS finds your local Ollama — or connects to Gemini, Claude, OpenAI, or Groq
3. You pick which agent to run: ATLAS, OpenClaw, or PicoClaw
4. MARS installs, secures, and starts your agent
5. ATLAS chats with you. OpenClaw/PicoClaw run on localhost and are ready for API calls.
```

---

## Supported LLMs

| Type | Providers |
| :--- | :--- |
| Local | Ollama (any model — auto-detected, any port) |
| Cloud | Google Gemini, Anthropic Claude, OpenAI, Groq |

---

## Mobile & Tablets (iPhone, iPad, Android)

Run `mars` on a computer on your local network, then enable the web bridge:

```bash
mars --web
```

MARS displays a web link (e.g. `http://192.168.1.5:8080`). Open it in any browser.

**Android (Termux — native):**
```bash
pkg install curl && curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
```

---

## Platforms

| Platform | Binary |
| :--- | :--- |
| macOS Apple Silicon | `mars-macos-arm64` |
| macOS Intel | `mars-macos-x86_64` |
| Linux x86_64 | `mars-linux-x86_64` |
| Linux ARM64 / Raspberry Pi / Android Termux | `mars-linux-arm64` |
| Windows x86_64 | `mars-windows-x86_64.exe` |

---

## Manual Download

Download the binary for your platform from [Releases](https://github.com/elgrhy/marsatlas/releases/latest).

Verify with the included `.sha256` checksum file before running.

---

## Commands

```bash
mars                    # Full bootstrap — detect, resolve LLM, pick agent, start
mars --ghost            # Bootstrap then self-erase after handover (Ghost Protocol)
mars chat atlas         # Resume ATLAS chat session
mars agent new          # Add another agent
mars agent list         # List all registered agents
mars agent status       # Show agent health
mars config             # Change LLM settings
```

---

## Security

- API keys stored in `.env` (chmod 600), never logged, hidden during input
- Each agent runs in its own isolated `.env` — your root credentials never shared
- All agent processes bind to `127.0.0.1` (localhost only)
- `.mars/` directory is chmod 700 (owner-only)
- OpenClaw: Docker volumes restricted, sensitive paths blocked
- Ghost Protocol produces a signed audit trail before MARS erases itself

---

## Auto-Update

MARS checks for updates at startup (background, 4-second timeout, silent fail). Re-run the install command to upgrade:

```bash
curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
```

---

*Source: private development repository at elgrhy/mars*
