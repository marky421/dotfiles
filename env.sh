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
export PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/X11/bin

# os-specific java and ant environment variables
if [[ $OS == Darwin ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export ANT_HOME=/usr/local/apache-ant
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
elif [[ $OS == Linux ]]; then
  export OPENDS_JAVA_HOME=/usr/lib/jvm/java-6-oracle
  #export JAVA_HOME=/usr/lib/jvm/java-7-oracle
  export JAVA_HOME=/usr/lib/jvm/java-8-oracle
  export ANT_HOME=/usr/share/ant
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

export RVM_HOME=$HOME/.rvm
export NVM_DIR=$HOME/.nvm
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$RVM_HOME/bin:$PATH

# add custom bin folder to PATH
export PATH=$HOME/bin:$HOME/.bin:$HOME/.local/bin:$PATH

# set the man path
export MANPATH=/usr/local/man:$MANPATH

