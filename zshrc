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

# use case-sensitive completion
# --------------------------------------
#CASE_SENSITIVE="true"

# disable weekly auto-update checks
# --------------------------------------
#DISABLE_AUTO_UPDATE="true"

# disable autosetting terminal title
# --------------------------------------
#DISABLE_AUTO_TITLE="true"

# display red dots while waiting for completion
# --------------------------------------
COMPLETION_WAITING_DOTS="true"

# load plugins (plugins can be found in ~/.oh-my-zsh/plugins/*)
# --------------------------------------
plugins=(npm python sublime sudo web-search zsh-syntax-highlighting)

# activate oh-my-zsh
# --------------------------------------
source $ZSH/oh-my-zsh.sh

# source other configuration files
# --------------------------------------
[[ -a $HOME/.private ]] && . $HOME/.private
[[ -a $HOME/.profile ]] && . $HOME/.profile  # Read Mac .profile, if present.
[[ -a $HOME/.bashrc ]] && . $HOME/.bashrc

