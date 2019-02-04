FROM joequant/pkgs:latest
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
COPY install-build-deps.sh docker-setup.sh remove-build-deps.sh /tmp/
RUN source /tmp/docker-setup.sh ; rm /tmp/*.sh
EXPOSE 80 443
CMD ["/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh"]
