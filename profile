# ----------------------------------------------------------------------
# ~/.dotfiles/profile
# Mark Spain
# ----------------------------------------------------------------------

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# if running bash
# --------------------------------------
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    [[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
# --------------------------------------
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
