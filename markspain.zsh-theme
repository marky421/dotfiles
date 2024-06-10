# ----------------------------------------------------------------------
# ~/dotfiles/markspain.zsh-theme
# Mark Spain
# ----------------------------------------------------------------------

PROMPT='%B$fg[white][$fg[magenta]%n$fg[white]@$fg[green]%m$fg[white]: $fg[cyan]%~$(parse_git_branch)$fg[white]]
$%b$reset_color '

ZSH_THEME_GIT_PROMPT_PREFIX=" $fg[yellow]⚡ "
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg[white]"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

parse_git_branch() {
  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$current_branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
