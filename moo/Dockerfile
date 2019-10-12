FROM mageia:7
COPY install.sh install-user.sh proxy.sh startup.sh /tmp/
RUN source /tmp/install.sh
RUN sudo -u user /tmp/install-user.sh
