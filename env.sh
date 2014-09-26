######################################################################
# ~/.env
# Mark Spain
######################################################################

# get operating system
########################################
OS=$(uname)

# environment variables
########################################
if [[ $MY_ENVIRONMENT != yes ]]; then 
  # explicitly configured $PATH variable
  export PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/local/bin:/opt/local/sbin:/usr/X11/bin:$PATH
  
  # os-specific java and ant environment variables
  if [[ $OS == Darwin ]]; then
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home
    export ANT_HOME=/usr/local/apache-ant
  elif [[ $OS == Linux ]]; then
    export OPENDS_JAVA_HOME=/usr/lib/jvm/java-6-oracle
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
    #export JAVA_HOME=/usr/lib/jvm/java-7-oracle
    export ANT_HOME=/usr/share/ant
  fi

  # set postgres host to localhost
  export PGHOST=localhost
 
  # set EDITOR to /usr/local/bin/vim if Vim is installed,
  # otherwise set it to /usr/bin/vim if it's installed
  if [[ -f /usr/local/bin/vim ]]; then
    export EDITOR=/usr/local/bin/vim
  elif [[ -f /usr/bin/vim ]]; then
    export EDITOR=/usr/bin/vim
  fi

  export RVM_HOME=$HOME/.rvm
  export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$RVM_HOME/bin:$PATH
  
  # add custom bin folder to PATH
  export PATH=$HOME/bin:$PATH
  
  export MANPATH=/usr/local/man:$MANPATH
  
  export MY_ENVIRONMENT=yes
fi

