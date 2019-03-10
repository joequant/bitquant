FROM joequant/cauldron:latest
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
#ENV http_proxy http://172.17.0.1:3128/
#ENV https_proxy http://172.17.0.1:3128/
#ENV ftp_proxy http://172.17.0.1:3128/
#ENV HTTP_PROXY http://172.17.0.1:3128/
#ENV PIP_INDEX_URL http://localhost:3141/root/pypi/+simple/
#ENV GIT_PROXY http://localhost:8080/

RUN mkdir -p /etc/sysusers.d 
COPY system.conf /etc/sysusers.d
COPY install-pkgs.sh /tmp
RUN systemd-sysusers && source /tmp/install-pkgs.sh ; rm /tmp/*.sh
CMD ["/bin/bash"]
