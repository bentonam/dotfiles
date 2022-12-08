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

# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# DOT Net
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# Go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
