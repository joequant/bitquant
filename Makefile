docker:
	cd docker ; sudo make | tee make.log
.PHONY: docker

bitstation-cauldron:
	cd oz ; ./mkimg.sh  Bitstation vdi mageia-cauldron-x86_64

bitstation-i586-cauldron:
	cd oz ; ./mkimg.sh  Bitstation vdi mageia-cauldron-i586

bitstation:
	cd oz ; ./mkimg.sh  Bitstation vdi mageia-net-x86_64

bitstation-i586:
	cd oz ; ./mkimg.sh  Bitstation vdi mageia-net-i586

local:
	cd web ; sudo ./setup.sh ; ./startup.sh

bitstation-dsk:
	cd oz ; ./mkimg.sh Bitstation dsk mageia-cauldron-smalldsk

bitquant:
	cd oz ; ./mkimg.sh Bitquant dsk mageia-cauldron-x64_64

install-deps:
	cd oz ; sudo ./install-deps.sh

clean:
	cd oz ; rm -f *-*:*:* *~
