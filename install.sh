#!/usr/bin/env bash
# install.sh — installs Homebrew packages and recreates symlinks (Stow)
# Run from the root of the cloned dotfiles repo: ./install.sh
set -euo pipefail

# --- 0. OS / architecture guard ---
# This repo assumes macOS on Apple Silicon (hardcoded /opt/homebrew paths
# in the zsh config). Fail early with a clear message instead of limping
# along with half-broken paths.
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Error: this repo only supports macOS. Detected OS: $(uname -s)" >&2
  exit 1
fi

if [[ "$(uname -m)" != "arm64" ]]; then
  echo "Error: this repo only supports Apple Silicon (arm64) Macs." >&2
  echo "Detected architecture: $(uname -m)" >&2
  echo "Homebrew and the zsh config assume /opt/homebrew paths, which" >&2
  echo "don't apply on Intel Macs (/usr/local instead)." >&2
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "==> Dotfiles install from $DOTFILES_DIR"

# --- 1. Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "==> Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already present"
fi

# --- 2. Homebrew packages ---
# CLI formulae
BREW_FORMULAE=(
  stow
  eza
  starship
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# GUI apps (casks)
BREW_CASKS=(
  wezterm
)

echo "==> Installing Homebrew formulae"
for pkg in "${BREW_FORMULAE[@]}"; do
  if brew list --formula "$pkg" &>/dev/null; then
    echo "  - $pkg already installed"
  else
    echo "  - installing $pkg"
    brew install "$pkg"
  fi
done

echo "==> Installing Homebrew casks"
for pkg in "${BREW_CASKS[@]}"; do
  if brew list --cask "$pkg" &>/dev/null; then
    echo "  - $pkg already installed"
  else
    echo "  - installing $pkg"
    brew install --cask "$pkg"
  fi
done

# --- 3. Directories needed before creating symlinks ---
mkdir -p "$HOME/.config"
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# --- 4. Symlinks via Stow ---
# Add each new package here as it becomes ready
# (e.g. once nvim/tmux configs exist: STOW_PACKAGES+=(nvim tmux))
STOW_PACKAGES=(
  zsh
  eza
  starship
  wezterm
)

echo "==> Creating symlinks with Stow"
for pkg in "${STOW_PACKAGES[@]}"; do
  if [[ -d "$pkg" ]]; then
    echo "  - stow $pkg"
    stow -v -t "$HOME" "$pkg"
  else
    echo "  - package '$pkg' not found in repo, skipping"
  fi
done

# --- 5. Git pre-commit hook ---
if [[ -d .githooks ]]; then
  echo "==> Configuring pre-commit hook"
  git config core.hooksPath .githooks
  chmod +x .githooks/pre-commit 2>/dev/null || true

  if [[ ! -f .githooks/patterns.local ]]; then
    cat > .githooks/patterns.local << 'PATTERNS_EOF'
# Personal patterns to block before commit (one per line, regex).
# This file is never committed (see .gitignore).
PATTERNS_EOF
    echo "  - created empty .githooks/patterns.local: add your personal patterns there"
  fi
fi

echo ""
echo "==> Done."
echo "    Restart your terminal, or run:"
echo "    source ~/.zshenv && source \"\$ZDOTDIR/.zshrc\""
