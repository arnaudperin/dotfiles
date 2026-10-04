# dotfiles

Personal macOS configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/) and versioned in Git so they can be restored on a new machine in a few commands instead of being rebuilt from memory.

## What's in here

| Package    | What it configures                                      |
|------------|----------------------------------------------------------|
| `zsh`      | Shell config: `.zshenv`, PATH/`cdpath`/`fpath`, history and completion options, aliases, Starship init, plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`), `fzf`-powered `h` history search function |
| `eza`      | Color theme for `eza` (used as a drop-in `ls` replacement) |
| `starship` | Prompt configuration (`starship.toml`)                   |
| `wezterm`  | Terminal emulator configuration (`wezterm.lua`)           |
| `btop`     | System monitor config: vim-style navigation, transparent background |
| `tmux`     | Terminal multiplexer config: custom prefix, vi-style pane navigation, true color, Rose Pine Moon status bar, session persistence (`tmux-resurrect`/`tmux-continuum`) |

More packages (`nvim`, `tmux`, ...) will be added here as they get configured.

Each package's internal folder structure mirrors its target path relative to `$HOME` — that's what lets Stow create the correct symlinks automatically. For example:

```
zsh/.zshenv                    -> ~/.zshenv
zsh/.config/zsh/.zshrc         -> ~/.config/zsh/.zshrc
wezterm/.config/wezterm/wezterm.lua -> ~/.config/wezterm/wezterm.lua
```

## Requirements

- macOS on Apple Silicon (paths assume `/opt/homebrew`; adjust for Intel Macs). `install.sh` checks this and exits with an error on any other OS/architecture.
- [Homebrew](https://brew.sh) (the install script installs it automatically if missing)

## Install on a new machine

```zsh
git clone git@github.com:arnaudperin/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

This will:
1. Install Homebrew if it's not already present
2. Install the required CLI tools and apps via Homebrew (`stow`, `eza`, `starship`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `fzf`, `bat`, `btop`, `tmux`, WezTerm)
3. Create the necessary config directories
4. Symlink every package into place with Stow
5. Configure the local git `pre-commit` hook (see below) and create an empty `patterns.local` file for you to fill in
6. Clone [TPM](https://github.com/tmux-plugins/tpm) (tmux's plugin manager) if it isn't already present

Once it finishes, restart your terminal (or `source ~/.zshenv && source "$ZDOTDIR/.zshrc"`). Then open `tmux` and press `prefix + I` (capital i) to install the tmux plugins (`tmux-resurrect`, `tmux-continuum`) — TPM only clones plugin repos once you trigger this from inside tmux, `install.sh` doesn't do it automatically.

## Adding or updating a package manually

```zsh
cd ~/dotfiles
stow <package-name>
```

Stow only creates symlinks for files that don't already exist at the target path. If a real file is already sitting where a symlink should go, move it into the matching package folder first (see how existing packages are structured), then re-run `stow`.

## Git pre-commit hook

`.githooks/pre-commit` scans staged changes for common secrets (emails, API keys, private key headers) before allowing a commit, to avoid leaking anything by accident — especially important since this repo may be public.

It also loads extra, purely local patterns from `.githooks/patterns.local` (e.g. a personal work identifier) if that file exists. This file is **never committed** (it's gitignored) — recreate it on each new machine if you want machine-specific patterns blocked:

```zsh
cat > ~/dotfiles/.githooks/patterns.local << 'EOF'
# One regex pattern per line
EOF
```

`install.sh` creates an empty version of this file automatically if it's missing, so you just need to fill it in.

To bypass the hook for a deliberate false positive:
```zsh
git commit --no-verify
```

## Notable tools

- **`h` (fuzzy history search)** — a shell function (in `aliases.zsh`) that opens `fzf` over your command history instead of zsh's built-in `Ctrl+R` search. Usage:
  ```zsh
  h git      # fzf pre-filtered on "git"
  h          # fzf over the full history, no pre-filter
  ```
  Select an entry with `Enter` to load it into your command line for editing (it does not execute automatically).

- **tmux prefix is `Ctrl+a`**, not the default `Ctrl+b`. Session layout and pane contents are auto-saved every 15 minutes and restored automatically when tmux starts (via `tmux-continuum`), which matters in particular on a remote/headless machine accessed over SSH.

## Notes

- This repo is macOS-only for now; no Linux/Windows support is planned unless a real need comes up.
- Some machine-specific paths (e.g. a legacy system Python install) are intentionally kept local rather than tracked here — check `zsh/.config/zsh/path.zsh` for context if a command isn't found after installing on a new machine.
