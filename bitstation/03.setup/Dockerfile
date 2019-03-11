FROM joequant/pkgs:latest
#ENV http_proxy http://172.17.0.1:3128/
#ENV https_proxy http://172.17.0.1:3128/
#ENV ftp_proxy http://172.17.0.1:3128/
#ENV HTTP_PROXY http://172.17.0.1:3128/
#ENV PIP_INDEX_URL http://localhost:3141/root/pypi/+simple/
#ENV GIT_PROXY http://localhost:8080/

LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
COPY install-build-deps.sh docker-setup.sh remove-build-deps.sh install-ruby.sh environment.sh bootstrap.sh install-python-sudo.sh /tmp/
RUN source /tmp/install-build-deps.sh ; source /tmp/install-python-sudo.sh ; source /tmp/docker-setup.sh ; source /tmp/install-ruby.sh ; source /tmp/remove-build-deps.sh ; rm -rf /tmp/*
EXPOSE 80 443
CMD ["/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh"]
