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
export PS1=$'\n'"%F{green} %*%F %3~ %F{white}"$'\n'"$ "

# Custom $PATH with extra locations.
export PATH=$HOME/Library/Python/3.9/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/go/bin:/usr/local/git/bin:$HOME/.composer/vendor/bin:$PATH

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
# DISABLE_MAGIC_FUNCTIONS="true"

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
plugins=(git wd docker zsh-autosuggestions zsh-syntax-highlighting kubectl history-substring-search)

source "$ZSH/oh-my-zsh.sh"

# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
    share_path="/opt/homebrew/share"
else
    echo "Unknown architecture: ${arch_name}"
fi

# Allow history search via up/down keys.
source "${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

source "${share_path}/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${share_path}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completions.
autoload -Uz compinit && compinit

# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Z
. /opt/homebrew/etc/profile.d/z.sh

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
      source "$HOME/$n"
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
      source "$HOME/$n"
    done
  fi
done
unset function_names
unset n
unset f


#############################################################
#                          Homebrew                         #
#############################################################
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800


# Allow Composer to use almost as much RAM as Chrome.
export COMPOSER_MEMORY_LIMIT=-1
