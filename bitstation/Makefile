bitstation cauldron pkgs setup : ARGS="--no-cache=true"
bitstation: bitstation-cache

ifeq ($(NOCACHE),true)
ARGS="--no-cache=true"
endif

bitstation-cache: cauldron pkgs setup

cauldron: cauldron-cache
pkgs: pkgs-cache
setup: setup-cache

cauldron-cache:
	docker build -t cauldron $(ARGS) -f Dockerfile.01.cauldron .

pkgs-cache:
	docker build -t pkgs $(ARGS) -f Dockerfile.02.pkgs .

setup-cache:
	docker build -t joequant/bitstation $(ARGS) -f Dockerfile.03.setup .

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

clean-vols:
	docker volume rm `docker volume ls | grep -v VOLUME | grep bitstation | awk '{print $2}'`

.PHONY: bitstation



