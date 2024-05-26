# ----------------------------------------------------------------------
# ~/.dotfiles/zshrc
# Mark Spain
# ----------------------------------------------------------------------

# Path to your oh-my-zsh installation
# --------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Set the theme to my custom (old) theme
# --------------------------------------
#ZSH_THEME="markspain"

# OMZ update configuration
# --------------------------------------
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(colored-man-pages command-not-found common-aliases docker git sudo fast-syntax-highlighting ohmyzsh-full-autoupdate zsh-autosuggestions)

# history setup
# --------------------------------------
HIST_STAMPS='yyyy-mm-dd'

# activate oh-my-zsh
# --------------------------------------
source $ZSH/oh-my-zsh.sh

# setup iterm2 shell integration
# --------------------------------------
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# source other configuration files
# --------------------------------------
# load alias definitions
[[ -a $HOME/.aliases.sh ]] && . $HOME/.aliases.sh

# load environment variables
[[ -a $HOME/.env.sh ]] && . $HOME/.env.sh

# load functions
[[ -a $HOME/.functions.sh ]] && . $HOME/.functions.sh

# load extras file
[[ -a $HOME/.extras.sh ]] && . $HOME/.extras.sh

# load nvm
[[ -a $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh # This loads nvm

# initialize starship
# --------------------------------------
[[ ! -v ZSH_THEME ]] && eval "$(starship init zsh)"

