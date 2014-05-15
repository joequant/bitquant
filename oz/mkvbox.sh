VBoxManage modifyvm Bitstation --hda none
VBoxManage unregistervm Bitstation
rm -rf ~/VirtualBox\ VMs/Bitstation/
VBoxManage dhcpserver remove --ifname vboxnet0
VBoxManage hostonlyif remove vboxnet0
VBoxManage hostonlyif create
VBoxManage hostonlyif ipconfig vboxnet0 --dhcp
VBoxManage dhcpserver add --ifname vboxnet0 \
   --ip 192.168.56.100 \
   --netmask 255.255.255.0 \
   --lowerip 192.168.56.101 \
   --upperip 192.168.56.255 --enable

VBoxManage createvm --name "Bitstation" --ostype Other_64 --register
VBoxManage modifyvm  "Bitstation" --memory 2048 \
   --nic1 nat \
   --nic2 hostonly \
   --nictype1 virtio \
   --nictype2 virtio \
   --pae on \
   --cpus 2 \
   --accelerate3d on \
   --vrde on \
   --audio pulse \
   --rtcuseutc on \
   --mouse usbmultitouch \
   --hostonlyadapter2 vboxnet0
VBoxManage storagectl Bitstation --name "SATA Controller" --add sata
VBoxManage storageattach Bitstation --storagectl "SATA Controller" \
   --port 0 --device 0 --type hdd --medium ~/.oz/images/bit1.vdi


