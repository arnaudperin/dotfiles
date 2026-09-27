# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# conf
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

