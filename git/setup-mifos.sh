#!/bin/bash

mysqladmin -uroot -pmysql create 'mifosplatform-tenants'
mysqladmin -uroot -pmysql create 'mifosplatform-default'
curl --location http://downloads.sourceforge.net/project/mifos/Mifos%20X/mifosplatform-1.25.1.RELEASE.zip -O mifosplatform-1.25.1.RELEASE.zip
unzip mifosplatform-1.25.1.RELEASE.zip
cd mifosplatform-1.25.1.RELEASE
mysql -uroot -pmysql mifosplatform-tenants < database/mifospltaform-tenants-first-time-install.sql
mysql -uroot -pmysql mifosplatform-default <  database/migrations/sample_data/load_sample_data.sql
