#!/bin/zsh
#
# .zprofile
#
# @author Aaron Benton
#

# Initialize Homebrew environment (Apple Silicon or Intel).
# This should run early in the login process so the rest of your shell config
# can rely on `brew` + correct PATH/MANPATH/INFOPATH.
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Note: Most environment variables are in .zshrc
# But essential ones needed early in the login process should remain here
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Note: Other environment variables and PATH modifications are in .zshrc
