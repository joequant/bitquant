FROM mageia:6
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"

# Save to temp file rather than piping because piping doesn't work
# with user switching

ARG version
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
COPY docker-cauldron.sh /tmp
RUN if [ "x$version" != "x6" ] ; then source /tmp/docker-cauldron.sh ; \
  rm /tmp/docker-cauldron.sh ; fi

FROM scratch
WORKDIR /
COPY --from=0 / .
