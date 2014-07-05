ME=`stat -c "%U" ${BASH_SOURCE[0]}`
MY_HOME=$(eval echo ~$ME)
# needed for building ethercalc
USERPROFILE=$MY_HOME
export HOME=$MY_HOME
GIT_DIR=$MY_HOME/git/bitquant
WEB_DIR=$MY_HOME/git/bitquant/web
LOG_DIR=$WEB_DIR/log
