#!/bin/bash
#######################################################################
# dotfiles/makesymlinks.sh
# Mark Spain
#
# This script creates symlinks from the home directory to any desired
# dotfiles in ~/dotfiles
#######################################################################

# variables
########################################
dir=~/dotfiles        # dotfiles directory
oldDir=~/dotfiles_old # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bash_profile bash_load aliases env functions bashrc gitconfig vim zshrc oh-my-zsh private tomcat"

# create dotfiles_old in homedir
########################################
echo "Creating $oldDir for backup of any existing dotfiles in ~"
mkdir -p $oldDir
echo "...done"

# change to the dotfiles directory
########################################
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# backup old dotfiles and create symlinks to new ones
########################################
for file in $files; do 
    echo "Moving any existing dotfiles from ~ to $oldDir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory"
    ln -s $dir/$file ~/.$file
done
echo "...done"

# install zsh customization files
########################################
install_zsh () {
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # install submodules
    git submodule init
    git submodule update
    # set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
    # clone zsh-syntax-highlighting from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/ ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $dir/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi
  else
    # get operating system
    OS=$(uname);
    # if the os is Linux, try an apt-get to install zsh and then recurse
    if [[ $OS == Linux ]]; then
        sudo apt-get install zsh
        install_zsh
    # if the os is OS X, tell the user to install zsh
    elif [[ $OS == Darwin ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
  fi
}

install_zsh

