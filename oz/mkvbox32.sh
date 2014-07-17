
#skip libvirt 
export LIBGUESTFS_BACKEND=direct

if [ "$1" != "" ] ; then
file=$1
else
file=~/.oz/images/Bitstation-mageia-net-i586.vdi
fi

echo "Creating vm from $file"
cp $file ~/.oz/images/bit1-32.vdi

VBoxManage hostonlyif create
VBoxManage dhcpserver add --ifname vboxnet0 \
   --ip 192.168.56.1 \
   --netmask 255.255.255.0 \
   --lowerip 192.168.56.100 \
   --upperip 192.168.56.254 --enable
VBoxManage createvm --name "Bitstation32" --ostype Other --register
VBoxManage modifyvm  "Bitstation32" --memory 4096 \
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
VBoxManage storagectl Bitstation32 --name "SATA Controller" --add sata --portcount 4
VBoxManage storageattach Bitstation32 --storagectl "SATA Controller" \
   --port 0 --device 0 --type hdd --medium ~/.oz/images/bit1-32.vdi
#VBoxManage export Bitstation32 --output Bitstation-v.0.0.3-32bit.ova \
#   --vsys 0 \
#   --product "Bitstation32" \
#   --vendor "Bitquant Research Laboratories" \
#   --vendorurl "http://www.bitquant.com.hk/"
#source ./rmvbox.sh
