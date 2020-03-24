#/bin/bash -f
DATE=$(date -u +'%Y%m%d.%H%M%S')
IMAGE=$($SUDO docker ps | tail -n +2 | grep nextcloud_db | awk '{print $NF}' )
docker exec -it $IMAGE pg_dumpall -U postgres | xz - > nextcloud_db.$DATE.dmp.xz
docker run -v nextcloud_lib:/volume --rm loomchild/volume-backup backup -c xz - > nextcloud_lib.$DATE.tar.xz
