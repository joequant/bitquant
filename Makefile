bitstation-vdi:
	cd oz ; ./mkimg.sh  Bitstation vdi mageia-net-x86_64

bitstation-i586:
	cd oz ; ./mkimg.sh  Bitstation vdi mageia-net-i586

local:
	cd web ; sudo ./setup.sh ; ./startup.sh

bitstation-dsk:
	cd oz ; ./mkimg.sh Bitstation dsk mageia-net-smalldsk

bitquant:
	cd oz ; ./mkimg.sh Bitquant dsk mageia-net-smalldsk

install-deps:
	cd oz ; sudo ./install-deps.sh

clean:
	cd oz ; rm -f *-*:*:* *~
