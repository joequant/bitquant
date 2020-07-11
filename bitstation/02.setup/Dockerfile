ARG base
FROM $base
USER root
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
RUN mkdir -p /etc/sysusers.d
COPY system.conf /etc/sysusers.d
COPY install-pkgs.sh proxy.sh 00_mpm.conf docker-setup.sh remove-build-deps.sh install-ruby.sh install-python.sh install-npm.sh install-r-pkgs.sh install-r-pkgs-sudo.sh proxy.sh setup.sh /tmp/
RUN systemd-sysusers ; source /tmp/install-pkgs.sh  ; parallel --tagstring '{}' --linebuffer source '/tmp/{}' :::  install-r-pkgs.sh install-python.sh  docker-setup.sh ; parallel --tagstring '{}' --linebuffer source '/tmp/{}' ::: install-npm.sh install-ruby.sh install-r-pkgs-sudo.sh ; source /tmp/remove-build-deps.sh ; rm -rf /tmp/*
EXPOSE 80 443
CMD ["/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh"]
