#!/usr/bin/env bash
# MARS Installer — https://github.com/elgrhy/marsatlas
# Usage: curl -fsSL https://raw.githubusercontent.com/elgrhy/marsatlas/main/install.sh | bash
set -e

REPO="elgrhy/marsatlas"
BINARY_NAME="mars"
INSTALL_DIR="$HOME/.local/bin"

# ── Colours ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'
ok()   { echo -e "${GREEN}✓${RESET} $*"; }
info() { echo -e "${CYAN}→${RESET} $*"; }
warn() { echo -e "${YELLOW}⚠${RESET} $*"; }
die()  { echo -e "${RED}✗ $*${RESET}" >&2; exit 1; }

echo ""
echo -e "${BOLD}  MARS — Autonomous Bootstrap System${RESET}"
echo -e "  ${CYAN}https://github.com/elgrhy/marsatlas${RESET}"
echo ""

# Detect upgrade vs fresh install
if command -v mars >/dev/null 2>&1; then
  CURRENT_VERSION="$(mars --version 2>/dev/null | awk '{print $NF}' || echo "unknown")"
  echo -e "  ${YELLOW}Existing installation detected (${CURRENT_VERSION}) — upgrading...${RESET}"
  echo ""
fi

# ── Detect OS ──────────────────────────────────────────────────────────────────
OS="$(uname -s 2>/dev/null || echo "unknown")"
ARCH="$(uname -m 2>/dev/null || echo "unknown")"

case "$OS" in
  Darwin)
    case "$ARCH" in
      arm64)  TARGET="mars-macos-arm64" ;;
      x86_64) TARGET="mars-macos-x86_64" ;;
      *)      die "Unsupported macOS architecture: $ARCH" ;;
    esac
    ;;
  Linux)
    case "$ARCH" in
      x86_64)          TARGET="mars-linux-x86_64" ;;
      aarch64|arm64)   TARGET="mars-linux-arm64" ;;
      *)               die "Unsupported Linux architecture: $ARCH" ;;
    esac
    ;;
  MINGW*|MSYS*|CYGWIN*|Windows_NT)
    TARGET="mars-windows-x86_64.exe"
    BINARY_NAME="mars.exe"
    ;;
  *)
    # Termux (Android) reports Linux; iSH reports Linux x86
    die "Unsupported OS: $OS. See https://openclaw.ai for manual install."
    ;;
esac

info "Detected: $OS / $ARCH → $TARGET"

# ── Find latest release ─────────────────────────────────────────────────────────
RELEASE_URL="https://api.github.com/repos/${REPO}/releases/latest"
info "Fetching latest release..."

if command -v curl >/dev/null 2>&1; then
  RELEASE_JSON="$(curl -fsSL "$RELEASE_URL")"
elif command -v wget >/dev/null 2>&1; then
  RELEASE_JSON="$(wget -qO- "$RELEASE_URL")"
else
  die "curl or wget is required. Install one and retry."
fi

VERSION="$(echo "$RELEASE_JSON" | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/')"
[ -z "$VERSION" ] && die "Could not determine latest version. Check https://github.com/${REPO}/releases"
ok "Latest version: $VERSION"

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${VERSION}/${TARGET}"
CHECKSUM_URL="${DOWNLOAD_URL}.sha256"

# ── Download ────────────────────────────────────────────────────────────────────
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

BINARY_PATH="$TMP_DIR/$BINARY_NAME"
info "Downloading $TARGET..."

if command -v curl >/dev/null 2>&1; then
  curl -fsSL --progress-bar "$DOWNLOAD_URL" -o "$BINARY_PATH"
  curl -fsSL "$CHECKSUM_URL" -o "$BINARY_PATH.sha256" 2>/dev/null || warn "Could not fetch checksum (skipping verification)"
else
  wget -q --show-progress "$DOWNLOAD_URL" -O "$BINARY_PATH"
  wget -q "$CHECKSUM_URL" -O "$BINARY_PATH.sha256" 2>/dev/null || warn "Could not fetch checksum (skipping verification)"
fi

# ── Verify checksum ─────────────────────────────────────────────────────────────
if [ -f "$BINARY_PATH.sha256" ]; then
  info "Verifying checksum..."
  EXPECTED="$(cat "$BINARY_PATH.sha256" | awk '{print $1}')"
  if command -v shasum >/dev/null 2>&1; then
    ACTUAL="$(shasum -a 256 "$BINARY_PATH" | awk '{print $1}')"
  elif command -v sha256sum >/dev/null 2>&1; then
    ACTUAL="$(sha256sum "$BINARY_PATH" | awk '{print $1}')"
  else
    warn "No SHA256 tool found — skipping checksum verification"
    ACTUAL="$EXPECTED"
  fi
  [ "$EXPECTED" = "$ACTUAL" ] && ok "Checksum verified" || die "Checksum mismatch! Download may be corrupted."
fi

# ── Install ─────────────────────────────────────────────────────────────────────
chmod +x "$BINARY_PATH"

# Choose install dir: prefer /usr/local/bin if writable, else ~/.local/bin
if [ -w "/usr/local/bin" ]; then
  INSTALL_DIR="/usr/local/bin"
elif command -v sudo >/dev/null 2>&1 && [ "$OS" != "Darwin" ]; then
  INSTALL_DIR="/usr/local/bin"
  USE_SUDO=1
fi

mkdir -p "$INSTALL_DIR"

if [ "${USE_SUDO:-0}" = "1" ]; then
  sudo mv "$BINARY_PATH" "$INSTALL_DIR/$BINARY_NAME"
  ok "Installed to $INSTALL_DIR/$BINARY_NAME (with sudo)"
else
  mv "$BINARY_PATH" "$INSTALL_DIR/$BINARY_NAME"
  ok "Installed to $INSTALL_DIR/$BINARY_NAME"
fi

# ── PATH check ──────────────────────────────────────────────────────────────────
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  warn "$INSTALL_DIR is not in your PATH"
  echo ""
  echo "  Add this to your shell profile:"
  echo "  ${BOLD}export PATH=\"\$HOME/.local/bin:\$PATH\"${RESET}"
  echo ""
  echo "  Then restart your terminal or run:"
  echo "  ${BOLD}source ~/.zshrc${RESET}  (or ~/.bashrc)"
  echo ""
fi

# ── Done ────────────────────────────────────────────────────────────────────────
echo ""
echo -e "  ${GREEN}${BOLD}Installation complete!${RESET}"
echo ""
echo -e "  Run ${BOLD}mars${RESET} to start."
echo -e "  MARS will set up your autonomous ATLAS agent."
echo ""

# Auto-run if in an interactive terminal
if [ -t 0 ] && [ -t 1 ]; then
  read -r -p "  Run mars now? [Y/n] " REPLY
  case "$REPLY" in
    [Nn]*) echo "  Run mars whenever you're ready." ;;
    *)     exec "$INSTALL_DIR/$BINARY_NAME" ;;
  esac
fi
