#/bin/bash -f
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DATE=$(date -u +'%Y%m%d.%H%M%S')
CMD=docker
dir=`pwd`
while getopts 'c:d:' OPTION; do
  case "$OPTION" in
    c)
      CMD="$OPTARG"
      ;;
    d)
	dir="$OPTARG"
	if [ ! -d $dir ] ; then
	    echo "cannot find directory $dir"
	    exit 1
	fi
	;;
    ?)
      echo "script usage: -c cmd image" >&2
      exit 1
      ;;
  esac
done

pushd $dir
$SCRIPT_DIR/../../bitstation/utils/shell-server.sh -c $CMD moodle_mariadb 'mysqldump -A -u root --single-transaction' | xz > moodle-db.$DATE.dmp.xz
$CMD run -v moodle_moodle_data:/volume --rm loomchild/volume-backup backup -c xz - > moodle-data.$DATE.tar.xz
popd
