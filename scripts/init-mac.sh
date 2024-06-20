#!/bin/bash
# ----------------------------------------------------------------------
# ~/.dotfiles/scripts/init-mac.sh
# Mark Spain
# ----------------------------------------------------------------------

echo ""
echo "------------------------------------------------------------------------"
echo "                 Mark Spain's bootstrap script for macs                 "
echo "------------------------------------------------------------------------"
echo "This script is designed to install all of the applications that I would "
echo "want on a new macbook computer via homebrew casks.                      "
echo ""

# make sure everything is good to go with homebrew
# --------------------------------------
echo "Running 'brew doctor'..."
brew doctor
echo "Running 'brew update'..."
brew update
echo ""

# install homebrew casks
# --------------------------------------
echo "Installing homebrew casks..."

# tap the repos
brew tap homebrew/cask
brew tap homebrew/cask-fonts

# install fonts
brew install font-source-code-pro

# install casks
casks = (
  alacritty
  appcleaner
  arduino
  bartender
  battle-net
  brave-browser
  caffeine
  docker
  dropbox
  google-chrome
  google-drive
  grandperspective
  intellij-idea
  iterm2
  istat-menus
  league-of-legends
  mqtt-explorer
  #gemini
  #onyx
  nvidia-geforce-now
  plex
  steam
  sublime-text
  the-unarchiver
  transmission
  transmit
  visual-studio-code
  vlc
  vnc-server
  vnc-viewer
  wezterm
)

for cask in ${casks[*]}; do
  brew install --cask $cask
done

echo "Finished installing brews/casks"

# cleanup
# --------------------------------------
echo "Cleaning up..."
brew update && brew cleanup && brew cask cleanup
echo "Finished cleaning up"
echo ""

echo "All done. Enjoy your new computer!"

