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

# install zsh, vim, neofetch, htop
# --------------------------------------
packages="zsh vim neofetch htop"
for package in $packages; do
  if ! [[ -f /bin/$package || -f /usr/bin/$package || -f /usr/local/bin/$package ]]; then
    # install using homebrew or apt dpending on OS
    [[ $OS == Darwin ]] && brew install $package
    [[ $OS == Linux  ]] && sudo apt install -y $package
  fi
done

#if ! [[ -f /bin/zsh || -f /usr/bin/zsh || -f /usr/local/bin/zsh ]]; then
#  # install zsh using homebrew or apt depending on OS
#  [[ $OS == Darwin ]] && brew install zsh
#  [[ $OS == Linux  ]] && sudo apt install -y zsh
#fi
#
#if ! [[ -f /bin/vim || -f /usr/bin/vim || -f usr/local/bin/vim ]]; then
#  # install vim using homebrew or apt depending on OS
#  [[ $OS == Darwin ]] && brew install vim
#  [[ $OS == Linux  ]] && sudo apt install -y vim
#fi
#
#if ! [[ -f /bin/neofetch || -f /usr/bin/neofetch || -f /usr/local/bin/neofetch ]]; then
#  # install neofetch using homebrew or apt depending on OS
#  [[ $OS == Darwin ]] && brew install neofetch
#  [[ $OS == Linux  ]] && sudo apt install -y neofetch
#fi
#
#if ! [[ -f /bin/htop || -f /usr/bin/htop || -f /usr/local/bin/htop ]]; then
#  # install htop using homebrew or apt depending on OS
#  [[ $OS == Darwin ]] && brew install htop
#  [[ $OS == Linux  ]] && sudo apt install -y htop
#fi
  
# install submodules (customization files)
git submodule update --init --recursive

# set the default shell to zsh if it isn't currently set to zsh
[[ ! $(echo $SHELL) == $(which zsh) ]] && sudo usermod -s $(which zsh) $USER

# backup old dotfiles and create symlinks to new ones
# --------------------------------------
echo "Moving any existing dotfiles from ~ to $oldDir"
for file in $files; do 
  if [[ -h $HOME/.$file ]]; then
    sudo rm -f $HOME/.$file
  elif [[ -f $HOME/.file ]]; then
    cp $HOME/.$file $oldDir/$file
    sudo rm -f $HOME/.$file
  fi
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file $HOME/.$file
done

echo "...done"
echo "Please log out and back in for changes to take effect."
