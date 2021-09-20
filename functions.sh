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
