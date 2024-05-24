# ----------------------------------------------------------------------
# ~/.dotfiles/zlogout
# Mark Spain
# ----------------------------------------------------------------------

# Kill the ssh-agent process
# --------------------------------------
# Only kill the process if this is the last logon session, which means
# there will be 2 zsh instances (the one we're logging out of plus the one
# that gets temporarily instantiated to run the 'ps -ef' command in the
# below if-statement
if [ -n "$SSH_AGENT_PID" ] && [ $(ps -ef | grep "[\-]zsh" | wc -l) -eq 2 ]; then
  echo "Killing the ssh-agent process..."
  eval "$(/usr/bin/ssh-agent -k)"
  unset SSH_AUTH_SOCK
  unset SSH_AGENT_PID
  echo "Done killing the ssh-agent process"
  sleep 5
else
  echo "Nothing to kill"
  sleep 5
fi
