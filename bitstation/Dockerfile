FROM mageia:6
MAINTAINER Joseph C Wang <joequant@gmail.com>
VOLUME [ "/sys/fs/cgroup", "/var/lib/machines" ]

# Save to temp file rather than piping because piping doesn't work
# with user switching

#RUN dnf install -v -y \
#       --setopt=install_weak_deps=False --nodocs \
#      mageia-repos-cauldron \
#     'dnf-command(config-manager)' ; \
#  dnf config-manager -v -y --set-enabled cauldron-x86_64-nonfree ; \
#  dnf config-manager -v -y --set-enabled cauldron-x86_64-tainted ; \
#  dnf --refresh distro-sync \
#     -v -y --setopt=install_weak_deps=False --nodocs ; \
#  dnf -v -y --nodocs --setopt=install_weak_deps=False upgrade
RUN dnf --setopt=install_weak_deps=False --best --nodocs -v -y install curl dnf
RUN cd /tmp ; \
  curl -O https://raw.githubusercontent.com/joequant/bitquant/master/bitstation/docker-setup.sh ; \
  chmod a+x docker-setup.sh ; \
  ./docker-setup.sh ; \
  rm docker-setup.sh
EXPOSE 80 443
CMD ["/home/user/git/bitquant/web/scripts/startup-all.sh"]
