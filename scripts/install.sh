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
OS=$(uname)
dir=$HOME/.dotfiles        # dotfiles directory
oldDir=$HOME/.dotfiles_old # old dotfiles backup directory

# make a backup directory and cd to dotfiles directory
# --------------------------------------
mkdir -p $oldDir
cd $dir

# list of files/folders to symlink in homedir
# --------------------------------------
files="aliases.sh bashrc bash_load.sh bash_profile bin env.sh extras.sh functions.sh gitconfig oh-my-zsh private vim zshrc"

# install zsh, vim
# --------------------------------------
if ! [[ -f /bin/zsh || -f /usr/bin/zsh ]]; then
  # install zsh using homebrew or apt-get depending on os
  [[ $OS == Darwin ]] && brew install zsh
  [[ $OS == Linux  ]] && sudo apt-get install zsh
fi

if ! [[ -f /bin/vim || -f /usr/bin/vim ]]; then
  # install vim using homebrew or apt-get depending on os
  [[ $OS == Darwin ]] && brew install vim
  [[ $OS == Linux  ]] && sudo apt-get install vim
fi
  
# install submodules (customization files)
git submodule update --init --recursive

# set the default shell to zsh if it isn't currently set to zsh
[[ ! $(echo $SHELL) == $(which zsh) ]] && chsh -s $(which zsh)

# backup old dotfiles and create symlinks to new ones
# --------------------------------------
echo "Moving any existing dotfiles from ~ to $oldDir"
for file in $files; do 
  if [[ -h $HOME/.$file ]]; then
    rm $HOME/.$file
  elif [[ -f $HOME/.file ]]; then
    mv $HOME/.$file $oldDir/$file
  fi
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file $HOME/.$file
done

echo "...done"
echo "Please log out and back in for changes to take effect."
