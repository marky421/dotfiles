# ----------------------------------------------------------------------
# ~/.dotfiles/zshrc
# Mark Spain
# ----------------------------------------------------------------------

# activate powerlevel10k instant prompt
# --------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
# --------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# set the theme
# --------------------------------------
#ZSH_THEME=markspain
ZSH_THEME=powerlevel10k/powerlevel10k

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
plugins=(colored-man-pages command-not-found common-aliases docker sudo fzf fzf-tab fast-syntax-highlighting ohmyzsh-full-autoupdate zsh-autosuggestions)

# history setup
# --------------------------------------
HIST_STAMPS='yyyy-mm-dd'

# activate oh-my-zsh
# --------------------------------------
source $ZSH/oh-my-zsh.sh
# unalias "fd" so we use the actual fd package
unalias fd 2>/dev/null

# explicitly configure $PATH variable
# --------------------------------------
#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin # default path for Mac OSX
export PATH=/usr/local/git/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/X11/bin:/snap/bin

# fzf configuration
# --------------------------------------
# add fzf bin directory to PATH before activating oh-my-zsh
if [[ ! "$PATH" == $HOME/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# load fzf-git
source $HOME/.fzf-git.sh/fzf-git.sh

# eza options to use for fzf
eza_opts="-ghmF --level=2 --color=always --color-scale=all --color-scale-mode=gradient --icons=always --hyperlink --time-style=long-iso"
show_file_or_dir_preview="if [ -d {} ]; then eza $eza_opts --tree {} ; else bat -n --color=always {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza $eza_opts --tree {}'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "eza $eza_opts --tree {}"   "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"          "$@" ;;
    ssh)          fzf --preview 'dig {}'                    "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# fzf-tab configuration
# --------------------------------------
# disable the default zsh completion menu
zstyle ':completion:*' menu no
# enable a border around the fzf window
zstyle ':fzf-tab:*' fzf-flags --border=rounded --layout=reverse-list --info=inline
# enable fzf-tab tmux popup
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# set the minimum height
zstyle ':fzf-tab:*' fzf-min-height 40
# set the minimum tmux popup size
zstyle ':fzf-tab:*' popup-min-size 156 40
# set the tmux popup padding really big so it takes up the entire terminal window
zstyle ':fzf-tab:*' popup-pad 80 20
# use eza when tab-completing a cd command
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza '$eza_opts' --tree $realpath'

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# show file contents
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'   # in general
zstyle ':fzf-tab:complete:vim:*' fzf-preview 'less ${(Q)realpath}' # for vim specifically
export LESSOPEN="|$HOME/.lessfilter %s"

# setup iterm2 shell integration
# --------------------------------------
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# source other configuration files
# --------------------------------------
# load alias definitions
[[ -a $HOME/.aliases.zsh ]] && source $HOME/.aliases.zsh

# load environment variables
[[ -a $HOME/.env.zsh ]] && source $HOME/.env.zsh

# load functions
[[ -a $HOME/.functions.zsh ]] && source $HOME/.functions.zsh

# load extras file
[[ -a $HOME/.extras.zsh ]] && source $HOME/.extras.zsh

# load nvm
[[ -a $NVM_DIR/nvm.sh ]] && source $NVM_DIR/nvm.sh # This loads nvm

# initialize starship
# --------------------------------------
[[ ! -v ZSH_THEME ]] && eval "$(starship init zsh)"

# initialize powerlevel10k
# --------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
