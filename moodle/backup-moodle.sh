#/bin/bash -f
DATE=$(date -u +'%Y-%m-%d.%H:%M:%S')

../../../tools/docker/shell-server.sh mariadb 'mysqldump -A -u root --single-transaction' > moodle-db.$DATE.dmp
docker run -v moodle_moodle_data:/volume --rm loomchild/volume-backup backup -c xz - > moodle-data.$DATE.tar.xz
