FROM joequant/bitstation:latest
#ENV HTTP_PROXY http://192.168.1.102:3128/
#ENV http_proxy http://192.168.1.102:3128/
#ENV https_proxy http://192.168.1.102:3128/
#ENV PIP_INDEX_URL http://localhost:3141/root/pypi/+simple/
#ENV GIT_PROXY http://localhost:8080/

LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
COPY install-noavx.sh /tmp/
RUN source /tmp/install-noavx.sh ; rm -rf /tmp/*
EXPOSE 80 443
CMD ["/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh"]
