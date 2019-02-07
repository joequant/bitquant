FROM joequant/pkgs:latest
#ENV HTTP_PROXY http://192.168.1.102:3128/
#ENV http_proxy http://192.168.1.102:3128/
#ENV PIP_INDEX_URL http://localhost:3141/root/pypi/+simple/
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
COPY install-build-deps.sh docker-setup.sh remove-build-deps.sh install-ruby.sh environment.sh bootstrap.sh install-python-sudo.sh /tmp/
RUN source /tmp/install-build-deps.sh ; source /tmp/install-python-sudo.sh ; source /tmp/docker-setup.sh ; source /tmp/install-ruby.sh ; source /tmp/remove-build-deps.sh ; rm -rf /tmp/*
EXPOSE 80 443
CMD ["/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh"]
