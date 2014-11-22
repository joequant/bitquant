#!/bin/bash
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR=$1
ME=$2

. $ROOT_SCRIPT_DIR/rootcheck.sh
# Mifos set up
if [ -e /bin/mysqladmin ] ; then
sed -i -e s/^skip-networking/#skip-networking/ /etc/my.cnf
/usr/sbin/mysqld-prepare-db-dir
/usr/bin/mysqld_safe &
sleep 10
systemctl enable mysqld
mysqladmin password mysql
fi
usermod -a -G tomcat $ME
if [ ! -e /usr/share/tomcat/.keystore ] ; then 
echo "" | keytool -genkey -alias mifostom -keyalg RSA \
  -storepass changeit -noprompt \
  -dname "CN=Unknown, OU=Unknown, O=Unknown, L=Unknown,S=Unknown, C=Unknown" \
  -keystore /usr/share/tomcat/.keystore
fi
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.40-4.b02.4.mga5.x86_64/jre
export TOMCAT_HOME=/var/lib/tomcat
mkdir -p /home/$ME/tmp-mifos

pushd /home/$ME/tmp-mifos
echo "Unzipping mifos database in "`pwd`
if [ ! -d mifosplatform-1.25.1.RELEASE ] ; then
curl --location http://downloads.sourceforge.net/project/mifos/Mifos%20X/mifosplatform-1.25.1.RELEASE.zip -O mifosplatform-1.25.1.RELEASE.zip
unzip mifosplatform-1.25.1.RELEASE.zip
fi
pushd mifosplatform-1.25.1.RELEASE

echo "Installing mifos application in tomcat"
cp mifosng-provider.war $TOMCAT_HOME/webapps
mkdir -p $TOMCAT_HOME/webapps/ROOT
cp -r api-docs $TOMCAT_HOME/webapps/ROOT
cp -r apps/community-app $TOMCAT_HOME/webapps/ROOT
popd
cp $SCRIPT_DIR/server.xml /etc/tomcat
popd
echo "Done with sudo install of mifos"
chmod a+rw -R /home/$ME/tmp-mifos

