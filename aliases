######################################################################
# ~/.aliases
# Mark Spain
#######################################################################

# get operating system
########################################
OS=$(uname)

# some useful aliases
########################################
alias mv='mv -i'                        # prompts if overwriting a file
alias cp='cp -i'                        # prompts if overwriting a file
alias vi='vim'                          # always use vim instead of vi
alias sudo='sudo '                      # autocomplete after using sudo
alias mkdir='mkdir -p'                  # create parent directories
alias path='echo -e ${PATH//:/\\n}'     # print $PATH line by line
alias ..='cd ..'                        # go up one directory
alias ...='cd ../..'                    # go uo two directories
alias c='clear'                         # clear the screen

# grep aliases
########################################
alias grep='grep --color=always'        # use colors for grep
alias egrep='egrep --color=always'      # use colors for egrep

# ls aliases
########################################
# os-specific ls options
if [[ $OS == Darwin ]]; then
  alias ls='ls -CFGh'                   # enhance ls (Mac)
elif [[ $OS == Linux ]]; then
  alias ls='ls -CFh --color=always'     # enhance ls (Linux)
fi
alias sl='ls'                           # autocorrect 'ls' typo
alias al='la -a'                        # autocorrect 'ls -a' shortcut typo
alias l='ls'                            # enable use of l for ls
alias ll='ls -l'                        # give ll desired 'ls -l' behavior
alias la='ls -a'                        # give la desired 'ls -a' behavior
alias lla='ls -la'                      # give lla desired 'ls -la' behavior
alias lal='la -al'                      # give lal desired 'ls -al' behavior

# git aliases
########################################
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias got='git '
alias get='git '

# MySQL aliases
########################################
alias mysql='mysql -u root'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

