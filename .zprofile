eval "$(/opt/homebrew/bin/brew shellenv)"

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
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#############################################################
#                           Dot Net                         #
#############################################################
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

#############################################################
#                            Ruby                           #
#############################################################
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

#############################################################
#                             GO                            #
#############################################################
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

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

#############################################################
#                          Composer                         #
#############################################################
# Allow Composer to use almost as much RAM as Chrome.
export COMPOSER_MEMORY_LIMIT=-1
