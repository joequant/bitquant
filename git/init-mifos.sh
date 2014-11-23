#!/bin/bash
mkdir -p ~/tmp-mifos
pushd ~/tmp-mifos
if [ ! -d mifosplatform-1.25.1.RELEASE ] ; then
curl --location http://downloads.sourceforge.net/project/mifos/Mifos%20X/mifosplatform-1.25.1.RELEASE.zip -O mifosplatform-1.25.1.RELEASE.zip
unzip mifosplatform-1.25.1.RELEASE.zip
fi
pushd mifosplatform-1.25.1.RELEASE
mysql -uroot -pmysql mifostenant-default <  database/migrations/sample_data/load_sample_data.sql
popd
rm -rf ~/tmp-mifos

