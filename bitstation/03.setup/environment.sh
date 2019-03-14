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

#export http_proxy=http://172.17.0.1:3128/
#export https_proxy=http://172.17.0.1:3128/
#export ftp_proxy=http://172.17.0.1:3128/
#export HTTP_PROXY=http://172.17.0.1:3128/
#export PIP_INDEX_URL=http://localhost:3141/root/pypi/+simple/
#export GIT_PROXY=http://localhost:8080/
