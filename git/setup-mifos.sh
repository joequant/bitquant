#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.40-4.b02.4.mga5.x86_64/jre
export TOMCAT_HOME=/var/lib/tomcat
mysqladmin -uroot -pmysql create 'mifosplatform-tenants'
mysqladmin -uroot -pmysql create 'mifostenant-default'
if [ ! -d mifosplatform-1.25.1.RELEASE ] ; then
curl --location http://downloads.sourceforge.net/project/mifos/Mifos%20X/mifosplatform-1.25.1.RELEASE.zip -O mifosplatform-1.25.1.RELEASE.zip
unzip mifosplatform-1.25.1.RELEASE.zip
fi
pushd mifosplatform-1.25.1.RELEASE
mysql -uroot -pmysql mifosplatform-tenants < database/mifospltaform-tenants-first-time-install.sql
mysql -uroot -pmysql mifostenant-default <  database/migrations/sample_data/load_sample_data.sql

sudo mkdir $TOMCAT_HOME/logs
sudo mkdir $TOMCAT_HOME/lib

sudo cp mifosng-provider.war $TOMCAT_HOME/webapps
sudo mkdir $TOMCAT_HOME/webapps/ROOT
sudo cp -r api-docs $TOMCAT_HOME/webapps/ROOT
sudo cp -r apps/community-app $TOMCAT_HOME/webapps/ROOT
popd
sudo cp server.xml /etc/tomcat



