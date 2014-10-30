FROM mageia:cauldron
MAINTAINER Joseph C Wang <joequant@gmail.com>
#RUN ["urpmi", "--no-suggests", "--auto", "--auto-update"]

RUN echo "ZONE=Asia/Hong_Kong" > /etc/sysconfig/clock
RUN urpmi.removemedia -a ;\
    urpmi.addmedia --distrib \
       --mirrorlist \
       'http://mirrors.mageia.org/api/mageia.cauldron.x86_64.list' ; \
   urpmi --no-suggests --auto urpmi --excludedocs ; \
   urpme --auto-orphans --auto

RUN ["urpmi", "--no-suggests", "--excludedocs", "--auto", "sudo", "git", "apache", "apache-mod_suexec", "apache-mod_proxy", "apache-mod_php", "apache-mod_authnz_external", "apache-mod_ssl", "dokuwiki", "python-flask", "python-pexpect"]
RUN useradd user ;\
   echo 'cubswin:)' | passwd user --stdin ; \
   cd ~user ; mkdir git ; cd git ; \
   git clone https://github.com/joequant/bitquant.git ;\
   cd ~user/git/bitquant/web/scripts ; ./setup_vimage.sh bitstation
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/* 
RUN  URPMI_OPTIONS="--excludedocs" /usr/share/bitquant/install-build-deps.sh ;\
su user -c "~user/git/bitquant/web/scripts/bootstrap.sh" ; \
su user -c "touch ~user/git/bitquant/web/log/bootstrap.done" ; \
~user/git/bitquant/web/scripts/remove-build-deps.sh 
RUN /usr/bin/systemctl enable httpd ; \
/usr/bin/systemctl enable bitquant ; \
/usr/bin/systemctl enable shiny-server ; \
/usr/bin/systemctl enable postgresql ; \
/usr/bin/systemctl enable ajenti

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 80
CMD ["/usr/sbin/init"]
