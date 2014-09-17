#######################################################################
# ~/.extras.sh
# Mark Spain
#######################################################################

# set jboss-specific environment variables and aliases
########################################
export JBOSS_HOME=/opt/jboss
alias jboss="cd $JBOSS_HOME"
export PATH=$JOSS_HOME/bin:$PATH

# set tomcat-specific environment variables and aliases
########################################
export CATALINA_HOME=/opt/tomcat
alias tomcat="cd $CATALINA_HOME"

# set identityiq specific environment variables and aliases
########################################
export SPHOME=$HOME/identityiq
alias workspace="cd /home/mspain/Developer/workspace/TVA_IIQ" 

