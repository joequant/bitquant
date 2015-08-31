FROM mageia:cauldron
MAINTAINER Joseph C Wang <joequant@gmail.com>
#RUN ["urpmi", "--no-recommends", "--auto", "--auto-update"]

RUN echo "ZONE=Asia/Hong_Kong" > /etc/sysconfig/clock
# Refresh locale and glibc for missing latin items
# needed for R to build packages

RUN urpmi.removemedia -a ;\
    urpmi.addmedia --distrib \
       --mirrorlist \
       'http://mirrors.mageia.org/api/mageia.cauldron.x86_64.list' ; \
    urpmi.addmedia \
       "Core backup" http://ftp.sunet.se/pub/Linux/distributions/mageia/distrib/cauldron/x86_64/media/core/release ; \
    urpmi.addmedia \
       "Core updates backup" http://ftp.sunet.se/pub/Linux/distributions/mageia/distrib/cauldron/x86_64/media/core/updates ; \
   urpmi --no-recommends --auto --excludedocs urpmi ; \
   urpmi --replacepkgs --excludedocs locales glibc ; \
   urpme --auto-orphans --auto
RUN ["urpmi", "--no-recommends", "--no-md5sum", "--excludedocs", "--auto", "sudo", "git", "apache", "apache-mod_suexec", "apache-mod_proxy", "apache-mod_php", "apache-mod_authnz_external", "apache-mod_ssl", "dokuwiki", "python3-flask", "python3-pexpect"]
RUN useradd user ;\
   echo 'cubswin:)' | passwd user --stdin ; \
   echo 'cubswin:)' | passwd root --stdin ; \
   cd ~user ; mkdir git ; cd git ; \
   git clone https://github.com/joequant/bitquant.git ;\
   git clone https://github.com/joequant/algobroker.git ;\
   cd ~user/git/bitquant/web/scripts ; ./setup_vimage.sh bitstation 
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/* 
RUN  URPMI_OPTIONS="--excludedocs --no-md5sum --no-verify-rpm" \
   /usr/share/bitquant/install-build-deps.sh ; \
   su user -c "~user/git/bitquant/web/scripts/bootstrap.sh" ; \
   su user -c "touch ~user/git/bitquant/web/log/bootstrap.done" ; \
   ~user/git/bitquant/web/scripts/remove-build-deps.sh ; \
   urpmi --auto-select ; \
   rm -rf /usr/lib64/python*/test ; \
   rm -rf /usr/lib64/python*/site-packages/pandas/tests ; \
   rm -rf /usr/lib64/python*/site-packages/pandas/io/tests ; \
   rm -rf /usr/lib64/python*/site-packages/pandas/tseries/tests ; \
   rm -rf /usr/lib64/python*/site-packages/matplotlib/tests ; \
   rm -rf /usr/lib64/python*/site-packages/mpl_toolkits/tests ; \
   rm -rf /home/user/git/shiny-server 
RUN /usr/bin/systemctl enable bitquant
VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 80 443
CMD ["/usr/sbin/init"]
