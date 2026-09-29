# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ~="cd ~"
alias home="cd ~"

# git
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

# system
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias top="htop"  # Si tu as installé htop via brew

# files
alias ls="eza --icons --group-directories-first"
alias l="eza -lah --icons --git --group-directories-first --time-style=long-iso"
alias la="eza -la --icons --git --group-directories-first --time-style=long-iso"
alias ll="eza -l --icons --git --group-directories-first --time-style=long-iso"
alias lt="eza -la --tree --level=2 --icons --group-directories-first --time-style=long-iso"
alias tree="eza --tree --icons --group-directories-first"

alias rm="rm -i"  # Demande confirmation avant suppression
alias mv="mv -i"
alias cp="cp -i"

# homebrew
alias brewup="brew update && brew upgrade && brew cleanup"

# network
alias myip="curl ifconfig.me"

# bat
alias cat="bat --paging=never --style=plain"

# reload conf 
alias reload="source $ZDOTDIR/.zshrc"
