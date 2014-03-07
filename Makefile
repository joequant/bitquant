bitstation-vdi:
	cd oz ; ./mkimg.sh  Bitstation vdi mageia-net

bitstation-dsk:
	cd oz ; ./mkimg.sh Bitstation dsk mageia-net-smalldsk

bitquant:
	cd oz ; ./mkimg.sh Bitquant dsk mageia-net-smalldsk

install-deps:
	cd oz ; sudo ./install-deps.sh

clean:
	cd oz ; rm -f *-*:*:* *~
