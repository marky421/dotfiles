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

# os-specific ls options (for use in cdl() and cdll())
# --------------------------------------
LS="ls -CFh"
LSL="ls -CFhl"
LSA="ls -CFha"
LSLA="ls -CFhla"
if [[ $OS == Darwin ]]; then
  LS="ls -CFGh"
  LSL="ls -CFGhl"
  LSA="ls -CFGha"
  LSLA="ls -CFGhla"
elif [[ $OS == Linux ]]; then
  LS="ls -CFh --color=always"
  LSL="ls -CFhl --color=always"
  LSA="ls -CFha --color=always"
  LSLA="ls -CFhla --color=always"
fi

# cdl - change to a directory and ls its contents
# --------------------------------------
cdl() { cd $1 && eval $LS; }

# cdll - change to a directory and ls -l its contents
# --------------------------------------
cdll() { cd $1 && eval $LSL; }

# mkcd - create a directory and cd to it
# --------------------------------------
mkcd() { mkdir -p $1 && cd $1; }

# ff - search current directory for specified pattern
# --------------------------------------
unalias ff 2>/dev/null
ff() { eval $LSLA | grep -i --color=always "$1"; }

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
