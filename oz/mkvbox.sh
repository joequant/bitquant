VBoxManage modifyvm Bitstation --hda none
VBoxManage closemedium disk ~/.oz/images/bit1.vdi
VBoxManage unregistervm Bitstation
rm -rf ~/VirtualBox\ VMs/Bitstation/
VBoxManage createvm --name "Bitstation" --ostype Other_64 --register
VBoxManage modifyvm  "Bitstation" --memory 2048 --nic1 bridged \
   --nictype1 virtio \
   --pae on \
   --cpus 2 \
   --accelerate3d on \
   --vrde on \
   --audio pulse \
   --rtcuseutc on \
   --mouse usbmultitouch \
   --bridgeadapter1 eth0
VBoxManage storagectl Bitstation --name "SATA Controller" --add sata
VBoxManage storageattach Bitstation --storagectl "SATA Controller" \
   --port 0 --device 0 --type hdd --medium ~/.oz/images/bit1.vdi


