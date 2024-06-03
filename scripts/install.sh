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
files="aliases.sh bin env.sh extras.sh functions.sh gitconfig gitconfig-work vim zlogout zshrc"

# install homebrew if on Mac
# --------------------------------------
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

# update linux packages before installing new things
# --------------------------------------
if [[ $OS == Linux ]]; then
  sudo apt update
  sudo apt upgrade -y
fi

# install os-agnostic packages
# --------------------------------------
packages="zsh vim neofetch htop ncdu curl wget tree bat btop"
for package in $packages; do
  if ! [[ -f /bin/$package || -f /usr/bin/$package || -f /usr/local/bin/$package || -f /opt/homebrew/bin/$package ]]; then
    # install using homebrew or apt dpending on OS
    [[ $OS == Darwin ]] && brew install $package
    [[ $OS == Linux  ]] && sudo apt install -y $package
  fi
done

# install linux-specific packages
# --------------------------------------
if [[ $OS == Linux ]]; then
  linux_packages="lsb-release apt-transport-https ca-certificates libcap2-bin pass gpg unzip"
  for package in $linux_packages; do
    sudo apt install -y $package
  done

  # install speedtest cli
  curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
  sudo apt install -y speedtest

  # install eza
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt update
  sudo apt install -y eza

  # install fastfetch
  source $dir/functions.sh
  update_fastfetch

fi

# install Mac-specific packages
# --------------------------------------
if [[ $OS == Darwin ]]; then
  mac_packages="bash-completion@2 cowsay fortune p7zip pianobar python3 eza fastfetch"
  for package in $mac_packages; do
    brew install $package
  done

  # install speedtest cli
  brew tap teamookla/speedtest
  brew update
  brew install speedtest --force
fi

# copy neofetch config if on Mac
# --------------------------------------
if [[ $OS == Darwin ]]; then
  sudo rm -rf $HOME/.config/neofetch
  mkdir -p $HOME/.config/neofetch
  cp -r $dir/config/neofetch/* $HOME/.config/neofetch
fi

# copy fastfetch config
# --------------------------------------
mkdir -p $HOME/.config/fastfetch
cp -r $dir/config/fastfetch/* $HOME/.config/fastfetch

# symlink bat -> batcat if on Linux
# --------------------------------------
if [[ $OS == Linux ]]; then
  mkdir -p $HOME/.local/bin
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

# install java if on a Mac 
# --------------------------------------
if [[ $OS == Darwin && $(java -version 2>&1) != *openjdk* ]]; then
  brew install java
  if ! [[ -f /Library/Java/JavaVirtualMachines/openjdk.jdk ]]; then
    sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
  fi
fi

# install nerd font (SauceCodePro -- derived from Source-Code-Pro)
# --------------------------------------
if [[ $OS == Darwin ]]; then
  brew install --cask font-sauce-code-pro-nerd-font
fi
if [[ $OS == Linux ]]; then
  wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip
  cd ~/.local/share/fonts
  unzip SourceCodePro.zip
  rm SourceCodePro.zip
  fc-cache -fv
  cd $dir
fi

# install submodules (customization files)
# --------------------------------------
git submodule update --init --recursive

# set the default shell to zsh if it isn't currently set to zsh
# --------------------------------------
[[ ! $(echo $SHELL) == $(which zsh) ]] && sudo usermod -s $(which zsh) $USER

# install oh-my-zsh and its plugins
# -------------------------------------
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate

# copy custom (old) zsh theme in case we want to use it again
cp $dir/markspain.zsh-theme ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/markspain.zsh-theme

# install starship
# --------------------------------------
if [[ $OS == Darwin ]]; then
  brew install starship
fi
if [[ $OS == Linux ]]; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
mkdir -p $HOME/.config
ln -s $dir/config/starship.toml $HOME/.config/starship.toml

# delete old dotfiles and create symlinks to new ones
# --------------------------------------
echo "Deleting any existing dotfiles from $HOME"
for file in $files; do
  if [[ -h $HOME/.$file ]]; then
    sudo rm -f $HOME/.$file
  elif [[ -f $HOME/.$file ]]; then
    sudo rm -f $HOME/.$file
  fi
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file $HOME/.$file
done

echo "...done"
echo "Please log out and back in for changes to take effect."

