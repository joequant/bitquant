bitstation:
	sudo docker build -t bitstation .

bitstation-clean-docker:
	sudo docker build -rm=true - < Dockerfile

mageia-import: rootfs-systemd.tar.xz
	sudo cat rootfs-systemd.tar.xz | sudo docker import - mageia:systemd

mageia-image: rootfs-systemd.tar.xz

rootfs-systemd.tar.xz:
	sudo ./mkimage-urpmi.sh --rootfs=`pwd` --with-systemd

clean:
	rm rootfs-systemd.tar.xz
	sudo docker rmi bitstation

refresh-script:
	rm mkimage-urpmi.sh .febootstrap-minimize
	wget https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/mkimage-urpmi.sh
	wget https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/.febootstrap-minimize
	chmod a+x mkimage-urpmi.sh .febootstrap-minimize
