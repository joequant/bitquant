bitstation-cauldron: ARGS="--no-cache=true"
bitstation-cauldron: bitstation-cauldron-cache

bitstation: ARGS="--no-cache=true"
bitstation: bitstation-cache

ifeq ($(NOCACHE),true)
ARGS="--no-cache=true"
endif

bitstation-cache:
	 docker build -t joequant/bitstation $(ARGS) .

bitstation-cauldron-cache:
	 docker build -t joequant/bitstation $(ARGS) . --build-arg version=cauldron

bitstation-clean-docker:
	 docker build -rm=true - < Dockerfile

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

.PHONY: bitstation



