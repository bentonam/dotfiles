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
