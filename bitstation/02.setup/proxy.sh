#: '
timeout 1 bash -c 'cat < /dev/null > /dev/tcp/172.17.0.1/3128'
if [ $? == 0 ] ; then
    echo "running proxy"
export http_proxy=http://172.17.0.1:3128/
export https_proxy=http://172.17.0.1:3128/
export ftp_proxy=http://172.17.0.1:3128/
export HTTP_PROXY=http://172.17.0.1:3128/
#cache with devpi-server
export PIP_INDEX_URL=http://127.0.0.1:3141/root/pypi/+simple/
#cache with git-cache-http-server
export GIT_PROXY=http://127.0.0.1:8080/
#cache with verdacchio
export NPM_CONFIG_REGISTRY=http://127.0.0.1:4873/
export YARN_REGISTRY=http://127.0.0.1:4873/
#'
fi
timeout 1 bash -c 'cat < /dev/null > /dev/tcp/172.17.0.1/3632'
if [ $? == 0 ] ; then
    echo "running distcc"
    export PATH=/usr/lib64/distcc:$PATH
    export DISTCC_HOSTS='172.17.0.1'
fi

: '
if [ $? == 0 ] ; then
    echo "running distcc"
    export PATH=/tmp/pump:/usr/lib64/distcc:$PATH
    ln -sf  ../../bin/pump /tmp/pump/pump
    export DISTCC_HOSTS='172.17.0.1,cpp,lzo'
    mkdir -p /tmp/pump
    for i in pip3 R ; do
	cat <<EOF > /tmp/pump/$i
#/bin/bash -f
export PATH=/tmp/pump:/usr/lib64/distcc:/usr/bin
exec /tmp/pump/pump /bin/$i "\$@"
EOF
	chmod a+x /tmp/pump/$i
    done
    for i in c++ c89 c99 cc clang clang++ g++ \
		 g++-10 gcc gcc-10 \
		 x86_64-mageia-linux-gnu-g++ \
		 x86_64-mageia-linux-gnu-gcc \
		 x86_64-mageia-linux-gnu-gcc-10 ; do
	ln -sf  ../../bin/distcc /tmp/pump/$i
    done
fi
'
