FROM mageia:6
MAINTAINER Joseph C Wang <joequant@gmail.com>
VOLUME [ "/sys/fs/cgroup", "/var/lib/machines" ]

# Save to temp file rather than piping because piping doesn't work
# with user switching
RUN dnf install -v -y curl
RUN cd /tmp ; curl -O https://raw.githubusercontent.com/joequant/bitquant/master/bitstation/docker-setup.sh ; chmod a+x docker-setup.sh ; ./docker-setup.sh ; rm docker-setup.sh
EXPOSE 80 443
CMD ["/home/user/git/bitquant/web/scripts/startup-all.sh"]
