FROM joequant/cauldron

LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
COPY install.sh startup.sh proxy.sh config.php nextcloud.inc nextcloud.conf 00_mpm.conf /tmp/
RUN source /tmp/install.sh
EXPOSE 80 443
CMD ["/root/startup.sh"]
