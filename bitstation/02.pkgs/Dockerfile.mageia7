#FROM joequant/cauldron:latest
FROM mageia:7

LABEL maintainer="Joseph C Wang <joequant@gmail.com>"

RUN mkdir -p /etc/sysusers.d 
COPY system.conf /etc/sysusers.d
COPY install-pkgs.sh proxy.sh 00_mpm.conf /tmp/
RUN systemd-sysusers && source /tmp/install-pkgs.sh ; rm /tmp/*.sh
