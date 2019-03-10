FROM mageia:6
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"
#ENV HTTP_PROXY http://172.17.0.1:3128/
#ENV http_proxy http://172.17.0.1:3128/
#ENV https_proxy http://172.17.0.1:3128/
#ENV ftp_proxy http://172.17.0.1:3128/
#ENV PIP_INDEX_URL http://localhost:3141/root/pypi/+simple/
#ENV GIT_PROXY http://localhost:8080/

# Save to temp file rather than piping because piping doesn't work
# with user switching

ARG version
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
COPY docker-cauldron.sh /tmp
RUN if [ "x$version" != "x6" ] ; then source /tmp/docker-cauldron.sh ; \
  rm /tmp/docker-cauldron.sh ; fi
