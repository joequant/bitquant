FROM joequant/cauldron:latest
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"

RUN mkdir -p /etc/sysusers.d 
COPY system.conf /etc/sysusers.d
COPY install-pkgs.sh /tmp
RUN systemd-sysusers && source /tmp/install-pkgs.sh ; rm /tmp/*.sh
CMD ["/bin/bash"]
