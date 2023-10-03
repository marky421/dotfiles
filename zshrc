# ----------------------------------------------------------------------
# ~/.dotfiles/zshrc
# Mark Spain
# ----------------------------------------------------------------------

# path to my oh-my-zsh configuration
# --------------------------------------
ZSH=$HOME/.oh-my-zsh

# set name of the theme to load
# --------------------------------------
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme
# each time that oh-my-zsh is loaded.
#ZSH_THEME="xiong-chiamiov-plus"
#ZSH_THEME="robbyrussell"
ZSH_THEME="markspain"

# display red dots while waiting for completion
# --------------------------------------
COMPLETION_WAITING_DOTS="true"

# load plugins (plugins can be found in ~/.oh-my-zsh/plugins/*)
# --------------------------------------
plugins=(npm python sublime sudo web-search common-aliases colored-man-pages command-not-found zsh-syntax-highlighting docker docker-compose)

# activate oh-my-zsh
# --------------------------------------
source $ZSH/oh-my-zsh.sh

# unset partial line indicators (mainly for Windows)
unsetopt prompt_cr prompt_sp

# source other configuration files
# --------------------------------------
[[ -a $HOME/.bashrc  ]] && . $HOME/.bashrc
