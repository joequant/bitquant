ME=`stat -c "%U" ${BASH_SOURCE[0]}`
GROUP=`stat -c "%G" ${BASH_SOURCE[0]}`
if [[ $ME == "root" ]] ; then
echo "Owner of environment.sh should not be root"
exit 1
fi
MY_HOME=$(eval echo ~$ME)
# needed for building ethercalc
USERPROFILE=$MY_HOME
export HOME=$MY_HOME
GIT_DIR=$MY_HOME/git/bitquant
WEB_DIR=$MY_HOME/git/bitquant/web
LOG_DIR=$WEB_DIR/log
