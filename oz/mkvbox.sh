VBoxManage modifyvm  Bitstation --hda none
VBoxManage unregistervm Bitstation --delete
VBoxManage createvm --name "Bitstation" --ostype Other_64 --register
VBoxManage modifyvm  "Bitstation" --memory 2048 --nic1 bridged \
   --nictype1 virtio \
   --pae on \
   --cpus 2 \
   --accelerate3d on \
   --vrde on \
   --audio pulse \
   --rtcuseutc on \
   --mouse usbmultitouch
VBoxManage storagectl Bitstation --name "SATA Controller" --add sata
VBoxManage storageattach Bitstation --storagectl "SATA Controller" \
   --port 0 --device 0 --type hdd --medium ~/.oz/images/bit1.vdi


