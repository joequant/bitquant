
#skip libvirt 
export LIBGUESTFS_BACKEND=direct

if [ "$1" != "" ] ; then
file=$1
else
file=~/.oz/images/Bitstation-mageia-cauldron-x86_64.vdi
fi

echo "Creating vm from $file"
cp $file ~/.oz/images/bit1.vdi

VBoxManage hostonlyif create
VBoxManage dhcpserver add --ifname vboxnet0 \
   --ip 192.168.56.1 \
   --netmask 255.255.255.0 \
   --lowerip 192.168.56.100 \
   --upperip 192.168.56.254 --enable
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
VBoxManage storagectl Bitstation --name "SATA Controller" --add sata --portcount 4
VBoxManage storageattach Bitstation --storagectl "SATA Controller" \
   --port 0 --device 0 --type hdd --medium ~/.oz/images/bit1.vdi
#rm -f bitstation.ova
#VBoxManage export Bitstation --output bitstation.ova \
#   --vsys 0 \
#   --product "Bitstation" \
#   --vendor "Bitquant Research Laboratories" \
#   --vendorurl "http://www.bitquant.com.hk/"
#source ./rmvbox.sh
