# use ls because stat causes error on dockerhub
ME=$(ls -ld ${BASH_SOURCE[0]} | awk '{print $3}')
GROUP=$(ls -ld ${BASH_SOURCE[0]} | awk '{print $4}')

if [[ $ME == "root" ]] ; then
echo "Owner of environment.sh should not be root"
exit 1
fi
MY_HOME=$(eval echo ~$ME)
# needed for building ethercalc
USERPROFILE=$MY_HOME
export HOME=$MY_HOME
GIT_DIR=$MY_HOME/git/bitquant
WEB_DIR=$MY_HOME/git/bitquant/bitstation/web
LOG_DIR=$WEB_DIR/log
INSTALL_MIFOS=false
INSTALL_OPENGAMMA=false
