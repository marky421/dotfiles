# ----------------------------------------------------------------------
# ~/.dotfiles/bash_load.sh
# Mark Spain
# ----------------------------------------------------------------------

# alias definitions
# --------------------------------------
[[ -a $HOME/.aliases.sh ]] && . $HOME/.aliases.sh

# load environment variables
# --------------------------------------
[[ -a $HOME/.env.sh ]] && . $HOME/.env.sh

# load functions
# --------------------------------------
[[ -a $HOME/.functions.sh ]] && . $HOME/.functions.sh

# load extras file
# --------------------------------------
[[ -a $HOME/.extras.sh ]] && . $HOME/.extras.sh

# load bash_completion only if installed via node and in bash shell
# --------------------------------------
if [[ -n "$BASH_VERSION" ]]; then
  [[ -a $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi

# load nvm
# --------------------------------------
[[ -a $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh # This loads nvm
