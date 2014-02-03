rm ~/.oz/images/Mageia.vdi
oz-install -a MageiaStack.auto mageia-net.tdl -c oz-vdi.cfg  -d3 -t 3600
pushd ~/.oz/images
mv Mageia.vdi MageiaStack.vdi
popd
