FROM bitstation:latest
MAINTAINER Joseph C Wang <joequant@gmail.com>

RUN /usr/bin/mysqld_safe & sleep 5; \
   cd ~user/git/bitquant ; \
   git pull ; git/init-mifos.sh 
