FROM mageia:cauldron
MAINTAINER Joseph C Wang <joequant@gmail.com>
RUN ["urpmi", "--no-suggests", "--auto", "--auto-update"]
RUN ["urpme", "--auto-orphans", "--auto"]
RUN ["urpmi", "--no-suggests", "--auto", "sudo", "git", "apache", "apache-mod_suexec", "apache-mod_proxy", "apache-mod_php", "apache-mod_authnz_external", "apache-mod_ssl", "dokuwiki", "python-flask", "python-pexpect"]
RUN ["useradd", "user"]
RUN echo 'cubswin:)' | passwd user --stdin
RUN cd ~user ; mkdir git ; cd git ; git clone https://github.com/joequant/bitquant.git
RUN cd ~user/git/bitquant/web/scripts ; ./setup_vimage.sh bitstation >> /var/log/oz_setup.log 2>&1
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*
USER user
RUN ~user/git/bitquant/web/scripts/bootstrap.sh
USER root
RUN  /usr/bin/systemctl enable httpd.service ; \
/usr/bin/systemctl enable bitquant ; \
/usr/bin/systemctl enable shiny-server ; \
/usr/bin/systemctl enable postgresql ; \
/usr/bin/systemctl enable ajenti
VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 80
CMD ["/usr/sbin/init"]
