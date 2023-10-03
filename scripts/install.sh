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

# make a backup directory and cd to dotfiles directory
# --------------------------------------
cd $dir

# list of files/folders to symlink in homedir
# --------------------------------------
files="aliases.sh bashrc bash_load.sh bash_profile bin env.sh extras.sh functions.sh gitconfig oh-my-zsh vim zshrc"

# install homebrew if on Mac
if [[ $OS == Darwin ]]; then
  echo "Checking for homebrew..."
  if [[ ! -a /opt/homebrew/bin/brew ]]; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Finished installing homebrew"
  else
    echo "Found homebrew"
  fi
fi

# install os-agnostic packages
# --------------------------------------
packages="zsh vim neofetch htop ncdu curl wget tree"
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
  linux_packages="lsb-release apt-transport ca-certificates libcap2-bin"
  for package in $linux_packages; do
    sudo apt install -y $package
  done

  # install speedtest cli
  curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
  sudo apt install -y speedtest
fi

# install Mac-specific packages
# --------------------------------------
if [[ $OS == Darwin ]]; then
  mac_packages="bash-completion@2 cowsay fortune p7zip pianobar python3"
  for package in $mac_packages; do
    brew install $package
  done

  # install speedtest cli
  brew tap teamookla/speedtest
  brew update
  brew install speedtest --force
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

# delete old dotfiles and create symlinks to new ones
# --------------------------------------
echo "Deleting any existing dotfiles from $HOME"
for file in $files; do
  if [[ -h $HOME/.$file ]]; then
    sudo rm -f $HOME/.$file
  elif [[ -f $HOME/.file ]]; then
    sudo rm -f $HOME/.$file
  fi
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file $HOME/.$file
done

echo "...done"
echo "Please log out and back in for changes to take effect."

