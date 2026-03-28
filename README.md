# MARS — Autonomous Agent Bootstrap System

**MARS** is the spark that brings AI agents to life on your machine. Detects your system, resolves an LLM, and boots an autonomous agent in under 60 seconds.

> One command. Your agent, forever.

```bash
curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
mars
```

---

## Getting Started

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

| Agent | Description | Requirements |
| :--- | :--- | :--- |
| **ATLAS** | Your personal AI assistant — can build apps, write code, and automate tasks for you | None |
| **Cranberry** | A research and analysis AI — great for reading, summarising, and exploring information | None |
| **OpenClaw** | An open-source coding assistant — runs on your computer or in the cloud | None for local; AWS CLI for cloud |
| **PicoClaw** | A lightweight coding assistant — quick to start, works without any container software | None |

---

## What Happens

```
1. MARS detects your machine — hardware, OS, every capability
2. MARS finds your local Ollama — or connects to Gemini, Claude, OpenAI, Groq, or DeepSeek
3. You pick which agent to run
4. MARS installs, secures, and starts your agent automatically
5. Chat with your agent in the terminal or via its web interface
```

---

## Supported LLMs

| Type | Providers |
| :--- | :--- |
| Local | Ollama (any model — auto-detected on 8 ports) |
| Cloud | Google Gemini, Anthropic Claude, OpenAI, Groq, DeepSeek |

---

## Commands

```bash
mars                    # Full bootstrap — detect, resolve LLM, pick agent, start
mars chat atlas         # Resume ATLAS chat session
mars agent new          # Add another agent
mars agent list         # List all registered agents
mars agent status       # Show agent health
mars doctor             # Diagnose and auto-heal all agents
mars watch              # Start background watchdog — auto-restarts agents on failure
mars watch --stop       # Stop the watchdog
mars watch --status     # Check watchdog status
mars config             # Change LLM settings
mars update             # Self-update to the latest MARS binary
mars --ghost            # Bootstrap then self-erase (Ghost Protocol)
```

You can also say these things in plain English during a chat session:

```
"my agent isn't working"    → runs doctor automatically
"keep my agents running"    → starts the watchdog
"I need an agent"           → shows the agent menu
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

Download from [Releases](https://github.com/elgrhy/marsatlas/releases/latest). Each binary includes a `.sha256` checksum.

---

## Android (Termux)

```bash
pkg install curl && curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
```

---

## Security

- API keys stored in `.env` (chmod 600), never logged, hidden during input
- Each agent runs in its own isolated `.env` — your root credentials never shared
- All agent processes bind to `127.0.0.1` (localhost only)
- `.mars/` directory is chmod 700 (owner-only)
- OpenClaw cloud: API key stored in AWS Secrets Manager, not in task environment variables

---

*Source: private development repository at elgrhy/mars*
