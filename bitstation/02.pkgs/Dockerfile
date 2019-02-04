FROM joequant/cauldron:latest
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
RUN mkdir -p /etc/sysusers.d 
COPY system.conf /etc/sysusers.d
COPY install-pkgs.sh /tmp
RUN dnf upgrade -y --best --allowerasing --nodocs -x filesystem && \
    systemd-sysusers && source /tmp/install-pkgs.sh ; rm /tmp/*.sh
