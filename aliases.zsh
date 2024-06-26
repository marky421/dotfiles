# ----------------------------------------------------------------------
# ~/.dotfiles/aliases.sh
# Mark Spain
# ----------------------------------------------------------------------

# get operating system
# --------------------------------------
OS=$(uname)

# some useful aliases
# --------------------------------------
alias mv='mv -i'                              # prompts if overwriting a file
alias cp='cp -i'                              # prompts if overwriting a file
alias vi='vim'                                # always use vim instead of vi
alias sudo='sudo '                            # autocomplete after using sudo
alias mkdir='mkdir -p'                        # create parent directories
alias path='echo -e ${PATH//:/\\n}'           # print $PATH line by line
alias ..='cd ..'                              # go up one directory
alias ...='cd ../..'                          # go uo two directories
alias c='clear'                               # clear the screen
alias tf='tail -n 1000 -f '                   # enhance tail
alias lf='less +F '                           # less with tailing on
alias tfl='less +F '                          # less with tailing on (alternate)
alias tree='tree -C'                          # always user colors
alias dush='du -hsx * 2>/dev/null | sort -hr' # list everything by size
alias ncdu='ncdu --color dark'                # ncurses du -- file size utility

# grep aliases
# --------------------------------------
alias grep='grep --color=always'              # use colors for grep
alias egrep='egrep --color=always'            # use colors for egrep

# ls aliases
# --------------------------------------
# os-specific ls options
if [[ $OS == Darwin ]]; then
  alias ls='ls -CFGh'                         # enhance ls (Mac)
elif [[ $OS == Linux ]]; then
  alias ls='ls -CFh --color=always'           # enhance ls (Linux)
fi
# if eza is installed, overwrite ls with eza
if [[ -f /usr/bin/eza || -f /opt/homebrew/bin/eza ]]; then
  # enhance eza
  alias eza='eza -ghmF --color=always --color-scale=all --color-scale-mode=gradient --icons=always --hyperlink --time-style=long-iso'
  # overwite ls with eza
  alias ls='eza'
fi
alias sl='ls'                                 # autocorrect 'ls' typo
alias al='la -a'                              # autocorrect 'ls -a' shortcut typo
alias l='ls'                                  # enable use of l for ls
alias ll='ls -l'                              # give ll desired 'ls -l' behavior
alias la='ls -a'                              # give la desired 'ls -a' behavior
alias lla='ls -la'                            # give lla desired 'ls -la' behavior
alias lal='ls -al'                            # give lal desired 'ls -al' behavior

# cd aliases
# --------------------------------------
alias cd='z' # use zoxide for cd

# git aliases
# --------------------------------------
alias gs='git status '
alias gp='git push'

# neofetch alias for macos
# --------------------------------------
if [[ $OS == Darwin && -f $HOME/.config/neofetch/config ]]; then
  alias neofetch='neofetch --config $HOME/.config/neofetch/config'
fi

# MySQL aliases
# --------------------------------------
alias mysql='mysql -u root'

# friendly version of diff
# --------------------------------------
alias ezdiff='diff -yiEZbwB --suppress-common-lines'

# shortcuts to folders
# --------------------------------------
alias dev='cd $HOME/Developer'

# docker aliases
# --------------------------------------
alias dockerips='docker ps | tail -n +2 | while read cid b; do echo -n "$cid\t"; docker inspect $cid | grep IPAddress | cut -d \" -f 4; done'
alias dockerprune='docker system prune -a --volumes'
alias dcrun='docker compose -f /opt/docker-compose.yml '
alias dclogs='docker compose -f /opt/docker-compose.yml logs -tf --tail="50" '

# WSL aliases
# --------------------------------------
alias explorer.exe='/mnt/c/Windows/explorer.exe'
alias explorer='explorer.exe'

# just for fun
# --------------------------------------
alias starwars='telnet towel.blinkenlights.nl'
alias lol='fortune | cowsay | lolcat'
alias pandora='/usr/local/bin/pianobar'

