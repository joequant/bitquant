FROM mageia:cauldron
MAINTAINER Joseph C Wang <joequant@gmail.com>
#RUN ["urpmi", "--no-recommends", "--auto", "--auto-update"]
VOLUME [ "/sys/fs/cgroup", "/var/lib/machines" ]
RUN echo "ZONE=Asia/Hong_Kong" > /etc/sysconfig/clock
# Refresh locale and glibc for missing latin items
# needed for R to build packages

RUN urpmi.removemedia -a ;\
    urpmi.addmedia --distrib \
       --mirrorlist \
       'http://mirrors.mageia.org/api/mageia.cauldron.x86_64.list' ; \
    urpmi.addmedia \
       "Core backup" http://distro.ibiblio.org/mageia/distrib/cauldron/x86_64/media/core/release ; \
    urpmi.addmedia \
       "Core updates backup" http://distro.ibiblio.org/mageia/distrib/cauldron/x86_64/media/core/updates ; \
   urpmi --no-recommends --auto --excludedocs urpmi ; \
   urpmi --replacepkgs --excludedocs locales glibc ; \
   urpmi --auto-select --auto --no-recommends --no-md5sum --excludedocs ; \
   urpme --auto-orphans --auto 
RUN ["urpmi", "--no-recommends", "--no-md5sum", "--excludedocs", "--auto", "sudo", "git", "apache", "apache-mod_suexec", "apache-mod_proxy", "apache-mod_php", "apache-mod_authnz_external", "apache-mod_ssl", "dokuwiki", "python3-flask", "python3-pexpect"]
RUN useradd user ;\
   echo 'cubswin:)' | passwd user --stdin ; \
   echo 'cubswin:)' | passwd root --stdin ; \
   cd ~user ; mkdir git ; cd git ; \
   git clone https://github.com/joequant/bitquant.git ;\
   git clone https://github.com/joequant/algobroker.git ;\
   git clone https://github.com/joequant/cryptoexchange.git ;\	
   cd ~user/git/bitquant/web/scripts ; ./setup_vimage.sh bitstation
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/* \
rm -f /lib/systemd/system/*resolve1* \
rm -f /lib/systemd/system/*resolved* \
rm -f /lib/systemd/system/*udev* \
rm -f /lib/systemd/system/*journal* \
rm -f /lib/systemd/system/*networkd* \
rm -rf /etc/resolveconf /sbin/resolvconf /etc/rc.d/init.d/resolvconf

RUN  URPMI_OPTIONS="--excludedocs --no-md5sum --no-verify-rpm" \
   /usr/share/bitquant/install-build-deps.sh ; \
   su user -c "~user/git/bitquant/web/scripts/bootstrap.sh" ; \
   su user -c "touch ~user/git/bitquant/web/log/bootstrap.done" ; \
   ~user/git/bitquant/web/scripts/remove-build-deps.sh ; \
   cd ~user/git/cryptoexchange ; python3 setup.py install ; \
   cd ~user/git/algobroker ; python3 setup.py install ; \
   rm -rf /usr/lib64/python*/test ; \
   rm -rf /usr/lib64/python*/site-packages/pandas/tests ; \
   rm -rf /usr/lib64/python*/site-packages/pandas/io/tests ; \
   rm -rf /usr/lib64/python*/site-packages/pandas/tseries/tests ; \
   rm -rf /usr/lib64/python*/site-packages/matplotlib/tests ; \
   rm -rf /usr/lib64/python*/site-packages/mpl_toolkits/tests ; \
   rm -rf /usr/lib/python*/site-packages/flask/testsuite ; \
   rm -rf /usr/lib/python*/site-packages/jinja2/testsuite ; \
   rm -rf /usr/lib/python*/site-packages/ggplot/tests ; \
   rm -rf /usr/lib/python*/site-packages/sympy/*/tests ; \
   rm -rf /usr/share/doc ; \
   rm -rf /home/user/git/shiny-server 

EXPOSE 80 443
CMD ["/home/user/git/bitquant/web/scripts/startup-all.sh"]
