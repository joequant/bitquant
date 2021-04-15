#: '

if timeout 1 bash -c 'cat < /dev/null > /dev/tcp/172.17.0.1/3128' ; then
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
