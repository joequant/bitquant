FROM joequant/pkgs:latest
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
COPY install-build-deps.sh docker-setup.sh remove-build-deps.sh install-ruby.sh /tmp/
RUN source /tmp/docker-setup.sh ; source /tmp/install-ruby.sh ; source /tmp/remove-build-deps.sh ; rm /tmp/*.sh
EXPOSE 80 443
CMD ["/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh"]
