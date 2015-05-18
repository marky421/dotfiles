# ----------------------------------------------------------------------
# ~/.dotfiles/extras.sh
# Mark Spain
# ----------------------------------------------------------------------

# set jboss-specific environment variables and aliases
# --------------------------------------
export JBOSS_HOME=/opt/jboss
alias jboss="cd $JBOSS_HOME"
export PATH=$JOSS_HOME/bin:$PATH

# set tomcat-specific environment variables and aliases
# --------------------------------------
export CATALINA_BASE=/opt/tomcat
export CATALINA_HOME=/opt/tomcat
alias tomcat="cd $CATALINA_HOME"

# set identityiq specific environment variables and aliases
# --------------------------------------
export SPHOME=$CATALINA_HOME/webapps/identityiq
alias workspace="cd ~/Developer/workspace"
BUILD_SCRIPT_DIR="~/Developer/workspace/IIQ"
BUILD_SCRIPT="./build.sh"
alias build="cd $BUILD_SCRIPT_DIR && $BUILD_SCRIPT war && cd -"
alias buildall="cd $BUILD_SCRIPT_DIR && $BUILD_SCRIPT deploy && $BUILD_SCRIPT cycle && $BUILD_SCRIPT importdynamic && cd -"
alias buildxml="cd $BUILD_SCRIPT_DIR && $BUILD_SCRIPT war && $BUILD_SCRIPT importdynamic && cd -"
alias deploy="cd $BUILD_SCRIPT_DIR && $BUILD_SCRIPT deploy && cd -"
alias bounce="cd $BUILD_SCRIPT_DIR && $BUILD_SCRIPT cycle && cd -"
alias clean="cd $BUILD_SCRIPT_DIR && $BUILD_SCRIPT clean && cd -"
alias tfl="less +F /var/log/iiq/sailpoint.log"
alias vimlog="vim + /var/log/iiq/sailpoint.log"
