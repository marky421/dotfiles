######################################################################
# ~/.bash_load
# Mark Spain
#######################################################################

# alias definitions
########################################
[[ -a ~/.aliases.sh ]] && . ~/.aliases.sh

# load environment variables
########################################
[[ -a ~/.env.sh ]] && . ~/.env.sh

# load functions
########################################
[[ -a ~/.functions.sh ]] && . ~/.functions.sh

# load extras file
########################################
[[ -a ~/.extras.sh ]] && . ~/.extras.sh

# load bash_completion only if installed via node and in bash shell
########################################
if [[ -n "$BASH_VERSION" ]]; then
  [[ -a $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi

# load nvm
########################################
[[ -a $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads nvm

# load rvm into a shell session *as a function*
########################################
[[ -a $HOME/.rvm/scripts/rvm ]] && . $HOME/.rvm/scripts/rvm

