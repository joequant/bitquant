FROM mageia:cauldron
MAINTAINER Joseph C Wang <joequant@gmail.com>
RUN ["urpmi", "--no-suggests", "--auto", "--auto-update"]
RUN ["urpme", "--auto-orphans", "--auto"]
RUN ["urpmi", "--no-suggests", "--auto", "sudo", "openssh-server", "git", "apache", "apache-mod_suexec", "apache-mod_proxy", "apache-mod_php", "apache-mod_authnz_external", "apache-mod_ssl", "dokuwiki", "python-flask", "python-pexpect"]
RUN ["useradd", "user"]
RUN echo 'cubswin:)' | passwd user --stdin
RUN cd ~user ; mkdir git ; cd git ; git clone https://github.com/joequant/bitquant.git
RUN cd ~user/git/bitquant/web/scripts ; ./setup_vimage.sh bitquant >> /var/log/oz_setup.log 2>&1

