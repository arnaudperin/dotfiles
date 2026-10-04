# history 
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# navigation 
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# completion 
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# color
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export BAT_THEME="Rose-Pine-Moon"
