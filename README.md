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

## Prerequisites

Install sudo and git in order to clone this repo and run the server initialization script (scripts/init-server.sh). It would also be a good time to harden the ssh configuration.

```
# become root, install sudo and git, and add mark to the sudo group
$ su -
$ apt install sudo git
$ usermod -aG mark sudo
```

```
# harden ssh config
$ sudo tee -a /etc/ssh/sshd_config.d/hardened.conf > /dev/null <<EOT
# $(hostname)-specific ssh configuration
PrintMotd no
PrintLastLog no
AddressFamily inet
PermitRootLogin no
PasswordAuthentication no
AllowUsers mark
AllowAgentForwarding yes
AllowTcpForwarding yes
EOT
$ sudo chmod 644 /etc/ssh/sshd_config.d/hardened.conf
```

Now is the time to copy ssh keys, verify they work via a separate session, and only then restart the system. Do NOT restart before copying ssh keys! Otherwise the hardened ssh config  will prevent remote login. If you end your session before copying ssh keys then you will need physical access to this machine in order to login.

## Installation

```
$ git clone https://github.com/marky421/dotfiles.git ~/.dotfiles && ~/.dotfiles/scripts/install.sh
```

If using ConEmu on windows, import the 'ConEmu_Mark_Spain.xml' file to get my configuration.
This assume that the Source Code Variable fonts from Adobe (open source) have been installed.
My ConEmu configuration uses zsh on wsl via bash! zsh is launched via bash in order to 
get around an issue with colors when using vim, particularly when scrolling.
