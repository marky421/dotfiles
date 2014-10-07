#!/bin/bash
# ----------------------------------------------------------------------
# ~/.dotfiles/scripts/install.sh
# Mark Spain
#
# This script creates symlinks from the home directory to any desired
# dotfiles in ~/.dotfiles
# ----------------------------------------------------------------------

echo "Running install.sh"

# variables
# --------------------------------------
dir=$HOME/.dotfiles        # dotfiles directory
oldDir=$HOME/.dotfiles_old # old dotfiles backup directory

# make a backup directory and cd to dotfiles directory
# --------------------------------------
mkdir -p $oldDir
cd $dir

# list of files/folders to symlink in homedir
# --------------------------------------
files="aliases.sh bashrc bash_load.sh bash_profile bin env.sh extras.sh functions.sh gitconfig oh-my-zsh private vim zshrc"

# install zsh customization files
# --------------------------------------
install_zsh() {
  if ! [[ -f /bin/zsh || -f /usr/bin/zsh ]]; then
    # install zsh using homebrew or apt-get depending on os
    OS=$(uname)
    [[ $OS == Darwin ]] && brew install zsh
    [[ $OS == Linux  ]] && sudo apt-get install zsh
  else
    # install submodules
    git submodule update --init --recursive
    # set the default shell to zsh if it isn't currently set to zsh
    [[ ! $(echo $SHELL) == $(which zsh) ]] && chsh -s $(which zsh)
  fi
}

install_zsh

# backup old dotfiles and create symlinks to new ones
# --------------------------------------
echo "Moving any existing dotfiles from ~ to $oldDir"
for file in $files; do 
    mv $HOME/.$file $oldDir/$file
    echo "Creating symlink to $file in home directory"
    ln -s $dir/$file $HOME/.$file
done
echo "...done"
