bitstation-nocache:

%-nocache : ARGS=--no-cache=true
%-squash : ARGS=--no-cache=true --squash=true


ifeq ($(NOCACHE),true)
ARGS="--no-cache=true"
endif

bitstation-nocache bitstation-squash: bitstation
cauldron-nocache cauldron-squash: cauldron
pkgs-nocache pkgs-squash: pkgs
setup-nocache setup-squash: setup

bitstation: cauldron pkgs setup

cauldron:
	docker build -t joequant/cauldron $(ARGS) $(EXTRA_ARGS) 01.cauldron

pkgs:
	docker build -t joequant/pkgs $(ARGS) $(EXTRA_ARGS) 02.pkgs

setup:
	docker build -t joequant/bitstation $(ARGS) $(EXTRA_ARGS) 03.setup

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

clean-vols-check:
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} == y ]

clean-vols: clean-vols-check
	docker volume rm `docker volume ls | grep -v VOLUME | grep bitstation | awk '{print $$2}'`

clean-images:
	./rm-stopped-containers.sh ; ./rm-untagged-images.sh

proxy-install:
	sudo dnf install squid python3-pip
	sudo pip3 install devpi-server
	sudo npm install -g git-cache-http-server verdaccio

proxy-start:
	devpi-server > devpi-server.log &
	git-cache-http-server > git-cache-http-server.log &
	verdaccio > verdaccio.log &

.PHONY: bitstation setup pkgs cauldron

