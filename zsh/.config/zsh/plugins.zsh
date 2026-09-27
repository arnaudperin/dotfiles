# confg for zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[path]='underline'
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# config for zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_USE_ASYNC=1

source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# config for zsh-history-substring-search
#source "/opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

#zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down

#HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#585b70,fg=#f9e2af,bold'
#HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#585b70,fg=#f38ba8,bold'

# always last
source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
