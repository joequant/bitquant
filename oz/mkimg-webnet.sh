rm ~/.oz/images/MageiaWeb.vdi
oz-install -a MageiaWeb.auto mageia-net.tdl -c oz-vdi.cfg  -d3 -t 3600
pushd ~/.oz/images
mv Mageia.vdi MageiaWeb.vdi
popd
