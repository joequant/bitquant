#/bin/bash -f
DATE=$(date -u +'%Y%m%d.%H%M%S')
ID=nextcloud

docker run -v ${ID}_lib:/volume --rm loomchild/volume-backup backup -c xz - > ${ID}_lib.$DATE.tar.xz
docker run -v ${ID}_db:/volume --rm loomchild/volume-backup backup -c xz - > ${ID}_db.$DATE.tar.xz
docker run -v ${ID}_etc:/volume --rm loomchild/volume-backup backup -c xz - > ${ID}_etc.$DATE.tar.xz
