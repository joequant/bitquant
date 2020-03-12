ME=user
GROUP=user
MY_HOME=$(eval echo ~$ME)
# needed for building ethercalc
USERPROFILE=$MY_HOME
export HOME=$MY_HOME
GIT_DIR=$MY_HOME/git/bitquant
WEB_DIR=$MY_HOME/git/bitquant/bitstation/web
LOG_DIR=$WEB_DIR/log
INSTALL_MIFOS=false
INSTALL_OPENGAMMA=false
