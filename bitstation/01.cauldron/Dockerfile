FROM mageia:7
LABEL maintainer="Joseph C Wang <joequant@gmail.com>"

# Save to temp file rather than piping because piping doesn't work
# with user switching

COPY docker-cauldron.sh proxy.sh /tmp/
RUN source /tmp/docker-cauldron.sh ; rm /tmp/docker-cauldron.sh
FROM scratch
WORKDIR /
COPY --from=0 / .
