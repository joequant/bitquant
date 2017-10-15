FROM mageia:6
MAINTAINER Joseph C Wang <joequant@gmail.com>
VOLUME [ "/sys/fs/cgroup", "/var/lib/machines" ]

# Save to temp file rather than piping because piping doesn't work
# with user switching

ARG version
RUN if [ "x$version" = "xcauldron" ] ; then dnf install -v -y \
       --setopt=install_weak_deps=False --nodocs \
     'dnf-command(config-manager)' mageia-repos-cauldron ; \
  dnf config-manager -v -y --set-disabled mageia-x86_64 ; \
  dnf config-manager -v -y --set-disabled updates-x86_64 ; \
  dnf config-manager -v -y --set-enabled cauldron-x86_64 ; \
  dnf config-manager -v -y --set-enabled cauldron-x86_64-nonfree ; \
  dnf config-manager -v -y --set-enabled cauldron-x86_64-tainted ; \
  dnf config-manager -v -y --add-repo http://mirrors.kernel.org/mageia/distrib/cauldron/x86_64/media/core/release cauldron ; \
  dnf --refresh --allowerasing --best distro-sync \
       -v -y --setopt=install_weak_deps=False --nodocs ; \
  dnf -v -y --allowerasing --best --nodocs --setopt=install_weak_deps=False upgrade ; fi


RUN dnf --setopt=install_weak_deps=False --allowerasing --best --nodocs -v -y install curl dnf python3
RUN cd /tmp ; \
  curl -O https://raw.githubusercontent.com/joequant/bitquant/master/bitstation/docker-setup.sh ; \
  chmod a+x docker-setup.sh ; \
  ./docker-setup.sh ; \
  rm docker-setup.sh
EXPOSE 80 443
CMD ["/home/user/git/bitquant/web/scripts/startup-all.sh"]
