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

# Enable plugins.
plugins=(git wd docker zsh-autosuggestions zsh-syntax-highlighting kubectl history-substring-search)

# Custom $PATH with extra locations.
export PATH=$HOME/Library/Python/3.9/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/go/bin:/usr/local/git/bin:$HOME/.composer/vendor/bin:$PATH

# Bash-style time output.
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

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
source ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Completions.
autoload -Uz compinit && compinit

# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

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
