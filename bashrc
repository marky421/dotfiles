#######################################################################
# ~/.bashrc
# Mark Spain
#######################################################################

# load bash configuration files
[[ -a $HOME/.bash_load ]] && . $HOME/.bash_load

# customize command prompt
[[ -n "$BASH_VERSION" ]] && export PS1='\[\e[1;37m\][\[\e[1;35m\]\u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;37m\]: \[\e[1;36m\]\w\[\e[1;33m\]$(git_branch)\[\e[1;37m\]]\n$ \[\e[0m\]'
function git_branch() {
 git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ ⚡\ \1/' 
}

# enable completion if shell is bash
if [ -n "$BASH_VERSION" ]; then
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
fi
