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

# install zsh, vim, neofetch, htop, ncdu, curl
# --------------------------------------
packages="zsh vim neofetch htop ncdu curl"
for package in $packages; do
  if ! [[ -f /bin/$package || -f /usr/bin/$package || -f /usr/local/bin/$package ]]; then
    # install using homebrew or apt dpending on OS
    [[ $OS == Darwin ]] && brew install $package
    [[ $OS == Linux  ]] && sudo apt install -y $package
  fi
done

# install linux-specific packages
# --------------------------------------
if [[ $OS == Linux ]]; then
  linux_packages="lsb-release apt-transport ca-certificates libcap2-bin gnupg"
  for package in $linux_packages; do
    sudo apt install -y $package
  done
  
  # install speedtest cli
  curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
  sudo apt install speedtest

  # install docker
  sudo mkdir -m 0755 -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# install java if on a Mac 
# --------------------------------------
if [[ $OS == Darwin &&  $(java -version 2>&1) != *openjdk* ]]; then
  brew install java
  if ! [[ -f /Library/Java/JavaVirtualMachines/openjdk.jdk ]]; then
    sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
  fi
fi

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
