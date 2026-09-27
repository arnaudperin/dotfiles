typeset -U path

path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  "$HOME/.local/bin"
  /usr/local/bin
  "$HOME/bin"
  $path
)

# cdpath — shorcuts for navigation, used by `cd`
typeset -U cdpath
cdpath=(
  # ADD DIRECTORY PATH HERE
  $cdpath
)

# fpath — directory to find functions for auload and completion scripts.
typeset -U fpath
fpath=(
  /opt/homebrew/share/zsh/site-functions
  $fpath
)
