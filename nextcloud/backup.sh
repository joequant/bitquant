#/bin/bash -f
DATE=$(date -u +'%Y%m%d.%H%M%S')
IMAGE=$($SUDO docker ps | tail -n +2 | grep nextcloud_db | awk '{print $NF}' )

docker run -v nextcloud_lib:/volume --rm loomchild/volume-backup backup -c xz - > nextcloud_lib.$DATE.tar.xz
docker run -v nextcloud_db:/volume --rm loomchild/volume-backup backup -c xz - > nextcloud_db.$DATE.tar.xz
