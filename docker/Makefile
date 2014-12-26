bitstation-nocache: NOCACHE=true 
bitstation-nocache: bitstation

bitstation-example-nocache: NOCACHE=true
bitstation-example-nocache: bitstation-example

bitstation-prod-nocache: NOCACHE=true
bitstation-prod-nocache: bitstation-prod

ifdef NOCACHE
	ARGS="--no-cache=true"
endif

bitstation:
	 docker build -t bitstation $(ARGS) bitstation 

bitstation-example:
	 docker build -t bitstation-example $(ARGS) bitstation-example

bitstation-prod:
	 docker build -t bitstation-prod $(ARGS) bitstation-prod


bitstation-clean-docker:
	 docker build -rm=true - < bitstation/Dockerfile

mageia-import: rootfs-systemd.tar.xz
	 cat rootfs-systemd.tar.xz |  docker import - mageia:systemd

mageia-image: rootfs-systemd.tar.xz

rootfs-systemd.tar.xz:
	 ./mkimage-urpmi.sh --rootfs=`pwd` --with-systemd

clean:
	rm rootfs-systemd.tar.xz
	docker rmi bitstation

refresh-script:
	rm mkimage-urpmi.sh .febootstrap-minimize
	wget https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/mkimage-urpmi.sh
	wget https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/.febootstrap-minimize
	chmod a+x mkimage-urpmi.sh .febootstrap-minimize

.PHONY: bitstation bitstation-example bitstation-prod


