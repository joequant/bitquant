#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
GIT_DIR=$WEB_DIR/../..
LOG_DIR=/var/log/bitquant
cd $SCRIPT_DIR

mkdir -p $LOG_DIR
chmod a+w $LOG_DIR

if [ -e /usr/share/bitquant/bitquant.sh ] ; then
   source /usr/share/bitquant/bitquant.sh
   echo "Bitstation - build $build_date $commit_id"
fi
echo "Create tmpfiles"
systemd-tmpfiles --create
echo "Start redis"
sudo -u redis /usr/bin/redis-server /etc/redis.conf &
echo "Start mongo"
chown -R mongod:mongod /var/lib/mongodb
sudo -u mongod /usr/bin/mongod --quiet -f /etc/mongod.conf &
echo "Starting httpd"
if [ -z "${AUTH_NAME}" ] ; then
    if [ ! -z "${INSTANCE_NAME}" ] ; then
       export AUTH_NAME=${INSTANCE_NAME}
    else
       export AUTH_NAME="PAM Authentication"
    fi
fi

if [ ! -z "${INSTANCE_NAME}" ] ; then
    export PS1="${INSTANCE_NAME}\\$ "
fi

if [ ! -d /var/lib/dokuwiki/log ] ; then
    mkdir -p /var/lib/dokuwiki/log
    chown apache:apache /var/lib/dokuwiki/log
fi

/usr/sbin/httpd -DFOREGROUND &
if [ -f /etc/webmin/start ] ; then
    echo "Start webmin"
    /etc/webmin/start
elif [ -f /usr/share/webmin/postinstall.sh ] ; then
    echo "Installing webmin"
    /usr/share/webmin/postinstall.sh
    sed -i -e 's!ssl=1!ssl=0!' /etc/webmin/miniserv.conf
    cat <<EOF > /etc/webmin/miniserv.users
user:x:0
EOF
    cat <<EOF >> /etc/webmin/config
webprefix=/webmin
webprefixnoredir=1
EOF
    grep ^root: /etc/webmin/webmin.acl | sed -e s/root:/user:/ >> /etc/webmin/webmin.acl
    if [ -f /etc/webmin/useradmin/config ] ; then
	sed -i -e 's!base_uid=500!base_uid=1000!' /etc/webmin/useradmin/config
	sed -i -e 's!base_gid=500!base_gid=1000!' /etc/webmin/useradmin/config
    fi
    if [ -f /etc/webmin/start ] ; then
	echo "Start webmin"
	/etc/webmin/start
    fi
fi

if [ ! -f /etc/dmd.conf ] ; then
    cat <<EOF > /etc/dmd.conf
;
; dmd.conf file for dmd
;
; dmd will look for dmd.conf in the following sequence of directories:
;   - current working directory
;   - directory specified by the HOME environment variable
;   - directory dmd resides in
;   - /etc directory
;
; Names enclosed by %% are searched for in the existing environment and inserted
;
; The special name %@P% is replaced with the path to this file
;

[Environment32]
DFLAGS=-I/usr/include/dlang/dmd -L-L/usr/lib -L--export-dynamic -fPIC -defaultlib=phobos2 -debuglib=phobos2

[Environment64]
DFLAGS=-I/usr/include/dlang/dmd -L-L/usr/lib64 -L--export-dynamic -fPIC -defaultlib=phobos2 -debuglib=phobos2
EOF
fi

if [ ! -f /etc/jupyterhub ] ; then
    echo "Create jupyterhub"
    mkdir -p /etc/jupyterhub
    chown -R rhea:rhea /etc/jupyterhub
fi

if [ ! -f /etc/jupyter/jupyter_server_config.d ] ; then
    mkdir -p /etc/jupyter/jupyter_server_config.d
    echo <<EOF > /etc/jupyter/jupyter_server_config.d/jupyterlab.json
{
  "ServerApp": {
    "jpserver_extensions": {
      "jupyterlab": true
    }
  }
}
EOF
    mkdir -p /etc/jupyter
    echo <<EOF > /etc/jupyter/jupyter_server_config.py
# Extra static path for JupyROOT - start - do not remove this line
c.ServerApp.extra_static_paths.append('/usr/share/root/notebook')
# Extra static path for JupyROOT - end - do not remove this line
EOF
fi

if [ -x /usr/bin/jupyterhub ] ; then
    echo "Start jupyterhub"
    pushd /etc/jupyterhub
    rm -f jupyterhub-proxy.pid
    sudo -u rhea /usr/bin/jupyterhub --JupyterHub.spawner_class=sudospawner.SudoSpawner --JupyterHub.authenticator_class='jhub_remote_user_authenticator.remote_user_auth.RemoteUserAuthenticator' --base-url='/jupyterhub' --Spawner.default_url='/lab' --debug >> $LOG_DIR/jupyterhub.log 2>&1 &
    popd
fi

if [ -x /usr/sbin/php-fpm ] ; then
echo "Restarting php-fpm"
sudo -u apache /usr/sbin/php-fpm --nodaemonize --fpm-config /etc/php-fpm.conf >> $LOG_DIR/php-fpm.log 2>&1 &
fi

echo "Pulling git"
pushd $WEB_DIR/..
sudo -u user git config --global pull.rebase true
sudo -u user git pull
popd
sudo -u user ./startup-user.sh
while :; do sleep 20000; done
