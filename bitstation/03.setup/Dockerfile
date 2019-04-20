FROM joequant/pkgs:latest

LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
COPY install-build-deps.sh docker-setup.sh remove-build-deps.sh install-ruby.sh environment.sh bootstrap.sh install-python.sh install-npm.sh install-r-pkgs.sh install-r-pkgs-sudo.sh proxy.sh /tmp/
RUN source /tmp/install-build-deps.sh ; source /tmp/install-python.sh ; source /tmp/docker-setup.sh ; source /tmp/install-npm.sh ; source /tmp/install-ruby.sh ; source /tmp/install-r-pkgs-sudo.sh ; source /tmp/remove-build-deps.sh ; rm -rf /tmp/*
EXPOSE 80 443
CMD ["/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh"]
