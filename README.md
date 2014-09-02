# Dotfiles

This repository contains my custom dotfiles. The included setup script creates
symlinks from your home directory (wherever `$HOME` points) to the files
located in `~/dotfiles`.

The setup script will back up your existing dotfiles to `~/dotfiles_old` if you
have any dotfiles of the same name as the symlinks being created.

I prefer `zsh` as my shell of choice, so the setup script will check if it's
installed and if it isn't, will install it for you on Linux (using `apt-get`)
or prompt you to install it manually on OS X. It will then clone my fork of the
`oh-my-zsh` repository from my GitHub.

If `zsh` was already installed, if it was not already configured as the default
shell, the setup script will execute `chsh -s $(which zsh)`. This changes the
default shell to zsh. You will have to either spawn a new login shell, or
simply log out and back in for the changes to take effect.

Here's a quick breakdown of what happens when you run the setup script:

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old`
2. Create symlinks to the dotfiles in `~/dotfiles` in your home directory
3. Clone my fork of the `oh-my-zsh` repository from GitHub (to use with `zsh`)
4. Check to see if `zsh` is installed and try to install it if it isn't
5. If zsh is installed, execute `chsh -s` to set it as the default shell

## Installation

```
$ git clone https://github.com/marky421/dotfiles ~/dotfiles && ~/dotfiles/install.sh
```
