VBoxManage modifyvm Bitstation32 --hda none
VBoxManage unregistervm Bitstation32
rm -rf ~/VirtualBox\ VMs/Bitstation32/
VBoxManage dhcpserver remove --ifname vboxnet0
VBoxManage hostonlyif remove vboxnet0
