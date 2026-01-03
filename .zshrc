#!/bin/zsh
#
# .zshrc
#
# @author Aaron Benton
#

# Colors.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Nicer prompt.
export PS1=$'\n'"%F{green} %*%F %3~ %F{white}"$'\n'"$ "

# IMPORTANT: .zprofile should initialize Homebrew (via `brew shellenv`).
# Here we only *augment* PATH in a safe, idempotent way.
path_prepend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Bash-style time output.
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

#############################################################
#                         ZSH                               #
#############################################################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Keep this list to built-in / known plugins.
# (We source zsh-autosuggestions, zsh-syntax-highlighting, and history-substring-search
# from Homebrew below.)
plugins=(git wd docker kubectl)

source "$ZSH/oh-my-zsh.sh"

# Determine a share path for Homebrew-installed shell helpers.
if command -v brew >/dev/null 2>&1; then
  share_path="$(brew --prefix)/share"
else
  arch_name="$(uname -m)"
  if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
  else
    share_path="/opt/homebrew/share"
  fi
fi

# Allow history search via up/down keys.
if [ -f "${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
  source "${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

if [ -f "${share_path}/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "${share_path}/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -f "${share_path}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "${share_path}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completions.
autoload -Uz compinit && compinit

# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

#############################################################
#                          Aliases                          #
#############################################################
# Possible alias file names
alias_names=(".aliases" ".zaliases" ".zsh_aliases" ".bash_aliases")

for n in "${alias_names[@]}"; do
  # look for a file in $HOME/ that has one of the alias names (i.e. .aliases), if found source it
  if [ -f "$HOME/$n" ]; then
    source "$HOME/$n"
  fi
  # look for a directory in $HOME/ that has one of the alias names .d, (i.e. aliases.d), if found
  # loop all of the *.alias files in that directory and source each one
  if [ -d "$HOME/$n.d" ]; then
    for f in "$HOME/$n.d/"*.alias; do
      if [ -f "$f" ]; then
        source "$f"
      fi
    done
  fi
done
unset alias_names
unset n
unset f

#############################################################
#                        Functions                          #
#############################################################
# Possible alias file names
function_names=(".functions" ".zfunctions" ".zsh_functions" ".bash_functions")

for n in "${function_names[@]}"; do
  # look for a file in $HOME/ that has one of the alias names (i.e. .functions), if found source it
  if [ -f "$HOME/$n" ]; then
    source "$HOME/$n"
  fi
  # look for a directory in $HOME/ that has one of the alias names .d, (i.e. functions.d), if found
  # loop all of the *.func files in that directory and source each one
  if [ -d "$HOME/$n.d" ]; then
    for f in "$HOME/$n.d/"*.func; do
      if [ -f "$f" ]; then
        source "$f"
      fi
    done
  fi
done
unset function_names
unset n
unset f

# Properly source the gin autocomplete setup
GIN_AC_ZSH_SETUP_PATH="$HOME/Library/Caches/gin/autocomplete/zsh_setup"
if [ -f "$GIN_AC_ZSH_SETUP_PATH" ]; then
  source "$GIN_AC_ZSH_SETUP_PATH"  # gin autocomplete setup
fi

# Source z command for quick navigation (Homebrew).
if [ -f "/opt/homebrew/etc/profile.d/z.sh" ]; then
  source "/opt/homebrew/etc/profile.d/z.sh"
elif [ -f "/usr/local/etc/profile.d/z.sh" ]; then
  source "/usr/local/etc/profile.d/z.sh"
fi

autoload -U +X bashcompinit && bashcompinit
if command -v grr >/dev/null 2>&1; then
  _grr_path="$(command -v grr)"
  complete -o nospace -C "${_grr_path}" grr
  unset _grr_path
fi

export GPG_TTY=$(tty)
if [ -f "$HOME/.config/op/plugins.sh" ]; then
  source "$HOME/.config/op/plugins.sh"
fi

#############################################################
#                        Paths                              #
#############################################################
# DO NOT reset PATH to empty string - this was causing issues
# Instead, ensure paths are properly appended/prepended

# Homebrew binaries (if not already set by .zprofile)
path_prepend "/opt/homebrew/bin"
path_prepend "/opt/homebrew/sbin"
path_prepend "/System/Cryptexes/App/usr/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/go/bin"
path_prepend "$HOME/.composer/vendor/bin"
path_prepend "/usr/local/git/bin"

# Ruby
if [[ ! "$PATH" =~ "/opt/homebrew/opt/ruby/bin" ]]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
fi

# Golang
if [[ ! "$PATH" =~ "$HOME/go/bin" ]]; then
  export PATH="$HOME/go/bin:$PATH"
fi

# Composer
if [[ ! "$PATH" =~ "$HOME/.composer/vendor/bin" ]]; then
  export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# Krew (Kubernetes plugins)
if [[ ! "$PATH" =~ "${KREW_ROOT:-$HOME/.krew}/bin" ]]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# Python user bin directory
if command -v python3 >/dev/null 2>&1; then
  _py_userbase="$(python3 -m site --user-base 2>/dev/null)"
  if [ -n "$_py_userbase" ]; then
    path_prepend "${_py_userbase}/bin"
  fi
  unset _py_userbase
fi

# System paths - ensure they're in the PATH
if [[ ! "$PATH" =~ ":/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" ]]; then
  export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
fi

#############################################################
#                  .zprofile settings                       #
#############################################################
# These settings were moved from .zprofile to ensure proper loading

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Make vim the default editor
export EDITOR=vim
export GIT_EDITOR=vim

export MANPAGER="less -X" # Don't clear the screen after quitting a manual page

export LESS_TERMCAP_md="$ORANGE" # Highlight section titles in manual pages

export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help" # Make some commands not show up in history

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # certain ansible roles will fail if this is not set

#############################################################
#                         Node / NVM                        #
#############################################################
export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
fi
if [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]; then
  . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

#############################################################
#                           Dot Net                         #
#############################################################
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

#############################################################
#                            Ruby                           #
#############################################################
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

#############################################################
#                             GO                            #
#############################################################
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

#############################################################
#                          Homebrew                         #
#############################################################
# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

#############################################################
#                          Composer                         #
#############################################################
# Allow Composer to use almost as much RAM as Chrome.
export COMPOSER_MEMORY_LIMIT=-1

#############################################################
#                      Google Cloud SDK                     #
#############################################################
# Add Google Cloud SDK bin to path if not already there
if [[ ! "$PATH" =~ "/opt/homebrew/share/google-cloud-sdk/bin" ]]; then
  export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
fi

# Source Google Cloud SDK scripts if they exist
if [ -f "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc" ]; then
  source "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc" ]; then
  source "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"
fi
