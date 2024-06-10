# ----------------------------------------------------------------------
# ~/.dotfiles/env.sh
# Mark Spain
# ----------------------------------------------------------------------

# get operating system
# --------------------------------------
OS=$(uname)

# default path for Mac OSX
#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# environment variables
# --------------------------------------
# explicitly configured $PATH variable
export PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/X11/bin:/snap/bin

# os-specific environment variables
if [[ $OS == Darwin ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  if [[ -a /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
elif [[ $OS == Linux ]]; then
  export JAVA_HOME=/usr/lib/jvm/default-java
  # Auto-start the ssh agent and add necessary keys once per reboot. 
  # See: https://github.com/ElectricRCAircraftGuy/eRCaGuy_dotfiles/tree/master/home/.ssh#auto-starting-the-the-ssh-agent-on-a-remote-ssh-based-development-machine
  # and this stackexchange answer: https://unix.stackexchange.com/a/686110/114401
  # Note that a corresponding entry has been added to .bash_logout (called by .zlogout) to kill ssh-agent on session close
  # echo statements can be uncommented for troubleshooting
  if ! ps -ef | grep "[s]sh-agent" &>/dev/null; then
    #echo "'ssh-agent' is not currently running. Starting SSH Agent. Starting 'ssh-agent' now."
    eval $(ssh-agent -s)
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  else
    #echo "'ssh-agent' already started. Nothing to do."
    export SSH_AGENT_PID=$(ps -ef | grep "[s]sh-agent" | awk '{ print $2 }')
  fi
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
  #echo "SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
  #echo "SSH_AGENT_PID: $SSH_AGENT_PID"
fi

# WSL-specific environment variables
if [[ $(uname -a | grep --color=never -io microsoft | head -1 | tr '[:upper:]' '[:lower:]') == microsoft ]]; then
  export PATH=$PATH:/mnt/c/Windows/System32
fi

# set postgres host to localhost
export PGHOST=localhost

# set default text editor
if [[ -f /usr/local/bin/vim ]]; then
  # set to /usr/local/bin/vim if Vim is manually installed,
  export EDITOR=/usr/local/bin/vim
elif [[ -f /usr/bin/vim ]]; then
  # otherwise set to /usr/bin/vim if default Vim exists
  export EDITOR=/usr/bin/vim
fi

export NVM_DIR=$HOME/.nvm
export CARGO_HOME=$HOME/.cargo
export RUSTUP_HOME=$HOME/.rustup
export GO_HOME=/usr/local/go
export GOPATH=/opt/go
export PATH=$JAVA_HOME/bin:$CARGO_HOME/bin:$GO_HOME/bin:$GOPATH/bin:$PATH

# add custom bin folder to PATH
export PATH=$HOME/bin:$HOME/.bin:$HOME/.local/bin:$PATH

# set the man path
export MANPATH=/usr/local/man:$MANPATH

