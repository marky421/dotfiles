#!/bin/bash

echo "Initializing new Debian server..."

dir=$HOME/.dotfiles       # dotfiles directory

# install docker
# --------------------------------------
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# configure docker completions for zsh
# --------------------------------------
docker completion zsh > $HOME/.oh-my-zsh/plugins/docker/_docker

# configure neofetch
# --------------------------------------
sudo apt install -y neofetch
echo "Copying neofetch config file"
sudo mkdir /opt/neofetch
sudo chown root:root /opt/neofetch
sudo chmod 755 /opt/neofetch
mkdir -p $HOME/.config/neofetch
cp $dir/config/neofetch/config $HOME/.config/neofetch/config
chmod -R 755 $HOME/.config/neofetch/
sudo ln -s $HOME/.config/neofetch/config /opt/neofetch/config
echo "Edit custom neofetch config at your ealiest convenience"

# configure sshd
# --------------------------------------
server_specifc_sshd_conf="/etc/ssh/sshd_config.d/10-$(hostname)-sshd.conf"
sudo touch $server_specifc_sshd_conf
sudo chown root:root $server_specifc_sshd_conf
sudo chmod 644 $server_specifc_sshd_conf
sudo tee -a $server_specifc_sshd_conf > /dev/null <<EOT
# $(hostname)-specific ssh configuration
Port 22221
PrintMotd no
PrintLastLog no
AddressFamily inet
PermitRootLogin no
PasswordAuthentication no
AllowUsers mark
AllowAgentForwarding no
AllowTcpForwarding yes
ChallengeResponseAuthentication no
KbdInteractiveAuthentication no
KerberosAuthentication no
GSSAPIAuthentication no
PermitEmptyPasswords no
X11Forwarding no
MaxAuthTries 3
LoginGraceTime 20
PermitUserEnvironment no
PermitTunnel no
EOT

# motd stuff
# --------------------------------------
# See https://web.archive.org/web/20220701000000*/https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/

# cleanup default motd
# --------------------------------------
sudo rm -f /etc/motd
sudo sed -i "s/pam_motd.so noupdate/pam_motd.so/g" /etc/pam.d/login > /dev/null
sudo sed -i "s/pam_motd.so noupdate/pam_motd.so/g" /etc/pam.d/sshd > /dev/null
[[ -a /etc/update-motd.d/10-help-text ]] && sudo chmod 644 /etc/update-motd.d/10-help-text    # disable thje default 10-help-text
[[ -a /etc/update-motd.d/50-motd-news ]] && sudo chmod 644 /etc/update-motd.d/50-motd-news    # disable the default 50-motd-news

# configure motd scripts
# --------------------------------------
sudo touch /etc/update-motd.d/10-uname
sudo touch /etc/update-motd.d/20-logo
sudo touch /etc/update-motd.d/30-neofetch
sudo touch /etc/update-motd.d/logo.txt
sudo chmod 755 /etc/update-motd.d/10-uname
sudo chmod 755 /etc/update-motd.d/20-logo
sudo chmod 755 /etc/update-motd.d/30-neofetch
sudo chmod 644 /etc/update-motd.d/logo.txt

# 10-uname -- don't append this one, it may already be there on Debian systems
# --------------------------------------
sudo tee /etc/update-motd.d/10-uname > /dev/null <<EOT
#!/bin/sh
uname -snrvm
EOT

# 20-logo
# --------------------------------------
sudo tee -a /etc/update-motd.d/20-logo > /dev/null <<EOT
#!/bin/sh
# -----------------------------------------------------------------------
# Go to this site, create a logo for this machine's hostname,
# and then copy it into /etc/update-mot.d/logo.txt
#   https://patorjk.com/software/taag/#p=display&f=Larry%203D&t=hostname
# -----------------------------------------------------------------------
cat /etc/update-motd.d/logo.txt
EOT
sudo docker run --quiet --rm node:18 bash -c "npm install &> '/dev/null' -g figlet-cli && echo '' && figlet -f 'Larry 3D' '$(hostname)'" | sudo tee -a /etc/update-motd.d/logo.txt &> '/dev/null' && docker image rm node:18 &> '/dev/null'

# 30-neofetch
# --------------------------------------
sudo tee -a /etc/update-motd.d/30-neofetch > /dev/null <<EOT
#!/bin/sh
# DO NOT DO THIS HERE! It will run as root instead of the logged in user.
# Instead, run this under /etc/profile.d/motd.sh
#
# ex:
#    +--------------------------------------------------------+
#    | $ sudo touch /etc/profile.d/motd.sh                    |
#    | $ sudo chown root:root /etc/profile.d/motd.sh          |
#    | $ sudo chmod 644 /etc/profile.d/motd.sh                |
#    | $ sudo bash -c 'cat > /etc/profile.d/motd.sh << EOF    |
#    |   #!/bin/sh                                            |
#    |   neofetch --config /opt/neofetch/config               |
#    |   EOF'                                                 |
#    +--------------------------------------------------------+
#
# If using zsh (I am), then need to update /etc/zsh/zprofile
# as /etc/profile is only invoked for bash login shells.
# Add this to the end of /etc/zsh/zprofile
#
# ex:
#    +--------------------------------------------------------+
#    | # mark's customization                                 |
#    | # ---------------------------------------------        |
#    | # Source /etc/profile, and in turn all scripts         |
#    | # in /etc/profile.d, akin to what is done for          |
#    | # bash login shells.                                   |
#    | emulate sh -c 'source /etc/profile'                    |
#    +--------------------------------------------------------+
#
# DO NOT UNCOMMENT THIS!
#neofetch --config /opt/neofetch/config
EOT
sudo touch /etc/profile.d/motd.sh
sudo chown root:root /etc/profile.d/motd.sh
sudo chmod 644 /etc/profile.d/motd.sh
sudo bash -c 'cat > /etc/profile.d/motd.sh << EOF
#!/bin/sh
echo ""
neofetch --config /opt/neofetch/config
EOF'
sudo tee -a /etc/zsh/zprofile > /dev/null <<EOT
# mark's customization
# ---------------------------------------------
# Source /etc/profile, and in turn all scripts
# in /etc/profile.d, akin to what is done for
# bash login shells.
emulate sh -c 'source /etc/profile'
EOT

echo ""
echo "ATTENTION!! Do not log out without first adding an ssh public key to ~/.ssh/authorized_keys or else you will need to connect a keyboard and display in order to log in!"
echo ""

echo ""
echo "After adding an ssh public key to ~/.ssh/authorized_keys, reboot the system to reload the ssh daemon."
echo ""

echo ""
echo "...done!"
echo ""
