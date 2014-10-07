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
  find . -exec grep -l -s $1 {} \;
  return 0
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
ff() { eval $LSLA | grep -i --color=always "$1" }

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