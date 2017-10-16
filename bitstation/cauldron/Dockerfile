FROM mageia:6
MAINTAINER Joseph C Wang <joequant@gmail.com>
VOLUME [ "/sys/fs/cgroup", "/var/lib/machines" ]

# Save to temp file rather than piping because piping doesn't work
# with user switching

ARG version
RUN dnf --setopt=install_weak_deps=False --allowerasing --best \
   --nodocs -v -y install curl dnf python3

RUN if [ "x$version" != "x6" ] ; then cd /tmp ; \
  curl -O https://raw.githubusercontent.com/joequant/bitquant/master/bitstation/docker-cauldron.sh ; \
  chmod a+x docker-cauldron.sh ; \
  ./docker-cauldron.sh ; \
  rm docker-cauldron.sh ; fi

RUN cd /tmp ; \
  curl -O https://raw.githubusercontent.com/joequant/bitquant/master/bitstation/docker-setup.sh ; \
  chmod a+x docker-setup.sh ; \
  ./docker-setup.sh ; \
  rm docker-setup.sh
EXPOSE 80 443
CMD ["/home/user/git/bitquant/web/scripts/startup-all.sh"]
