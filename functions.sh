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

# os-specific ls options
# --------------------------------------
LS="ls -CFh"
LSL="ls -CFhl"
if [[ $OS == Darwin ]]; then
  LS="ls -CFGh"
  LSL="ls -CFGhl"
elif [[ $OS == Linux ]]; then
  LS="ls -CFh --color=always"
  LSL="ls -CFhl --color=always"
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

