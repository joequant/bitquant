if [ ! -d vdi1 ] ; then
sudo cp -r -a vdi vdi1
sudo rm -f vdi1/etc/systemd/system/getty.target.wants/console-shell.service
fi

sudo lxc-create -f myvm.conf -n bitstation
sudo lxc-start -n bitstation
