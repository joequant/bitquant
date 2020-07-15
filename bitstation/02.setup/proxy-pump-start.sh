timeout 1 bash -c 'cat < /dev/null > /dev/tcp/172.17.0.1/3632'
: '
if [ $? == 0 ] ; then
    echo "running distcc pump"
    export DISTCC_HOSTS='172.17.0.1,cpp,lzo'
    eval `pump --startup`
    export PATH=/usr/lib64/distcc:$PATH
fi
'
