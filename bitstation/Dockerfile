FROM mageia:cauldron
MAINTAINER Joseph C Wang <joequant@gmail.com>
VOLUME [ "/sys/fs/cgroup", "/var/lib/machines" ]
# Refresh locale and glibc for missing latin items
# needed for R to build packages
RUN curl https://raw.githubusercontent.com/joequant/bitquant/master/bitstation/docker-setup.sh | bash
EXPOSE 80 443
CMD ["/home/user/git/bitquant/web/scripts/startup-all.sh"]
