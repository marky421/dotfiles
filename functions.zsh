# ----------------------------------------------------------------------
# ~/.dotfiles/functions.sh
# Mark Spain
# ----------------------------------------------------------------------

# get operating system
# --------------------------------------
OS=$(uname)

# qfind - used to quickly find files that contain a string in a directory
# --------------------------------------
qfind() {
  if [[ -z $1 ]] || [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
    echo "qfind - used to quickly find files that contain a string in a directory"
    echo "Usage: qfind DIRECTORY STRING"
    echo "  or:  qfind STRING"
    echo ""
    echo "Searches for files containing STRING recursively from DIRECTORY,"
    echo "  or the current directory if  DIRECOTRY is omitted"
    return 0
  fi
  dir=$1
  str=$2
  if [[ -z $2 ]]; then
    dir=.
    str=$1
  fi
  find $dir -type f -print0 | xargs -0 grep -l $str;
}

# loop - run 1 or more commands in a loop with a specified sleep duration
# --------------------------------------
loop() {
  if [[ -z $1 ]] || [[ -z $2 ]]; then
    echo "loop - run 1 or more commands in a loop with a specfied sleep duration"
    echo "USAGE: loop \"COMMAND\" \"SLEEP_DURATION\""
    echo ""
    echo "Runs the COMMAND (include double quotes) indefinitely every SLEEP_DURATION seconds"
    return 0;
  fi
  COMMAND=$1
  SLEEP_DURATION=$2
  while true; do eval $COMMAND; sleep $SLEEP_DURATION; done
}

# ff - search current directory for specified pattern
# --------------------------------------
unalias ff 2>/dev/null
ff() {
  fd $1 .
}

# psgrep - search for the specified process
# --------------------------------------
psgrep() {
  input=$1
  out=$(ps aux | grep -i --color=always "$input" | grep -v 'grep')
  [[ -z "$out" ]] && out="No process named $input found."
  echo $out
}

# clearfile - clear the contents of a specified file
# --------------------------------------
clearfile() {
  echo -n > $1
}

# weather - prints the day's weather forcast using wttr.in
# --------------------------------------
weather() {
  # if current number of terminal columns is greater or equal to 126
  if [[ $(tput cols) -ge 126 ]]; then
    # motd script version (long) (>= 126 cols)
    curl -m 10 'wttr.in/Edmonds,%20Washington,%20United%20States?u1qF'
  else
    # motd script version (short)
    curl -m 10 'wttr.in/Edmonds,%20Washington,%20United%20States?u1qFn'
  fi
}

# print out the current terminal colors
# --------------------------------------
palette() {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'};
  done
}

# print the escape sequence for the color code
# --------------------------------------
printc() {
  local color="%F{$1}"
  echo -E ${(qqqq)${(%)color}}
}

# update_fastfetch - installs/updates fastfetch by downloading the latest .deb from github
# --------------------------------------
update_fastfetch() {
  OS=$(uname)
  if [[ $OS == Linux ]]; then
    arch=$(arch)
    case $arch in
      "x86_64"  | "amd64") arch="amd64"   ;;
      "aarch64" | "arm64") arch="aarch64" ;;
      "armv7l"  | "armhf") arch="armv7l"  ;;
                        *) arch=""        ;;
    esac

    if [ -z $arch ]; then
      echo "Incompatible architecture: $(arch)"
    else
      echo "Installing latest version of fastfetch for architecture: $arch"
      package="fastfetch-linux-$arch.deb"
      url="https://github.com/fastfetch-cli/fastfetch/releases/latest/download/$package"
      wget -O /tmp/$package $url
      sudo apt install -y /tmp/$package
      rm -f /tmp/$package
      echo "Installed $(fastfetch --version)"
    fi
  else
    echo "Only applicable on Linux systems"
  fi
}

# update_starship - installs/updates starship
# --------------------------------------
update_starship() {
  OS=$(uname)
  if [[ $OS == Linux ]]; then
    curl -sS https://starship.rs/install.sh | sh
  else
    echo "Only applicable on Linux systems"
  fi
}

# update_fzf - updates fzf by pulling the latest and running the installation script
# --------------------------------------
update_fzf() {
  if (( $+commands[fzf] )); then
    current_dir=$(pwd)
    cd $HOME/.fzf
    git pull
    $HOME/.fzf/install --all --key-bindings --completion --no-update-rc --no-bash --no-zsh --no-fish
    cd $current_dir
  fi
}

# updatea_fzf_git - updates fzf-git.sh by pulling the latest and sourcing the file
# --------------------------------------
update_fzf_git() {
  current_dir=$(pwd)
  cd $HOME/.fzf-git.sh
  git pull
  source $HOME/.fzf-git.sh/fzf-git.sh
  cd $current_dir
}

# update_fd - installs/updates fd by downloading the latest .deb from github
# --------------------------------------
update_fd() {
 OS=$(uname)
  if [[ $OS == Linux ]]; then
    arch=$(arch)
    case $arch in
      "x86_64"  | "amd64") arch="amd64" ;;
      "aarch64" | "arm64") arch="arm64" ;;
      "armv7l"  | "armhf") arch="armhf" ;;
                        *) arch=""      ;;
    esac

    if [ -z $arch ]; then
      echo "Incompatible architecture: $(arch)"
    else
      echo "Checking latest version of fd for architecture: $arch"
      current_version=$(fd --version | cut -c4-)
      latest_version=$(curl https://api.github.com/repos/sharkdp/fd/releases/latest -s | jq .name -r | cut -c2-)
      echo "Current version is $current_version"
      echo "Lastest version is $latest_version"
      if [[ $current_version != $latest_version ]]; then
	echo "Installing latest version" 
        package="fd-musl_${latest_version}_${arch}.deb"
        url="https://github.com/sharkdp/fd/releases/latest/download/$package"
        wget -O /tmp/$package $url
        sudo apt install -y /tmp/$package
        rm -f /tmp/$package
        echo "Installed $(fd --version)"
      else
        echo "Latest version already installed"
      fi
    fi
  else
    echo "Only applicable on Linux systems"
  fi
}

# update_all - runs all the update functions in this file
# --------------------------------------
update_all() {
  update_fastfetch
  update_starship
  update_fzf
  update_fzf_git
  update_fd
}

