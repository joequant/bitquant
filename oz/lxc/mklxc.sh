if [ ! -d vdi1 ] ; then
sudo cp -r vdi vdi1
fi

sudo lxc-create -f myvm.conf -n bitstation
sudo lxc-start -n bitstation
