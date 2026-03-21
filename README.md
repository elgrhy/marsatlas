# MARS ATLAS

**MARS** is the spark that brings **ATLAS** to life — an autonomous AI agent that runs on your machine, builds its own environment, and keeps working long after MARS is gone.

> One command. Your agent, forever.

---

## Computers (Mac / Windows / Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
```

Then open a terminal and type:

```bash
mars
```

Pre-flight complete. MARS registers itself globally — type `mars` from anywhere, any time.

---

## Mobile & Tablets (iPhone, iPad, Android)

1. Run `mars` on a computer on your local network (Mac, Linux, Windows, Raspberry Pi)
2. When asked, enable the web bridge: `mars --web`
3. MARS displays a **web link** (e.g. `http://192.168.1.5:8080`)
4. Open that link in your phone or tablet browser
5. You are now connected to ATLAS

**Android (Termux — native):**
```bash
pkg install curl && curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
```

---

## What Happens

```
1. MARS detects your machine — hardware, OS, every running capability
2. MARS finds or installs a local LLM (or connects to cloud)
3. You talk to the LLM to shape your ATLAS — define what it can do
4. ATLAS is born. MARS verifies it, signs a handshake, erases itself.
5. ATLAS runs forever on your device, in its own interface.
```

ATLAS builds its own UI — chatbox, CLI, Telegram bot, web dashboard, or mobile app — based on what you asked for during setup.

---

## Platforms

| Platform | Method |
| :--- | :--- |
| macOS (Apple Silicon) | `curl ... \| bash` |
| macOS (Intel) | `curl ... \| bash` |
| Linux x86_64 | `curl ... \| bash` |
| Linux ARM64 / Raspberry Pi | `curl ... \| bash` |
| Windows | Download binary from Releases |
| Android (Termux) | `pkg install curl && curl ... \| bash` |
| iPhone / iPad / any mobile browser | Connect via web link from a nearby computer |

---

## Manual Download

Download the binary for your platform from [Releases](https://github.com/elgrhy/marsatlas/releases/latest).

Verify with the included `.sha256` checksum file before running.

---

## Security

- MARS never phones home — runs entirely on your machine
- API keys live in `.env`, gitignored, deleted when MARS exits
- Ghost Protocol produces a signed audit trail (`~/.mars_audit/`) before MARS erases itself
- Binary checksums (SHA256) published with every release

---

*ATLAS: Autonomous System Builder — source is private during early development.*
