VBoxManage modifyvm Bitstation --hda none
VBoxManage unregistervm Bitstation
rm -rf ~/VirtualBox\ VMs/Bitstation/
VBoxManage dhcpserver remove --ifname vboxnet0
VBoxManage hostonlyif remove vboxnet0
