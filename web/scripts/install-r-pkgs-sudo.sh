#!/bin/bash
# sudo portion of r package installations

echo "Running r installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh

SCRIPT_DIR=$1
ME=$2
R_PKGS="base64enc brew curl git2r IRkernel magrittr repr roxygen2 rzmq stringi xml2 \
BH crayon devtools IRdisplay knitr Quandl rmarkdown rversions shiny testthat \
R6      caTools   highr      jsonlite  rstudioapi xtable \
digest    htmltools  markdown  stringr xts \
Rcpp    evaluate  httpuv     memoise   uuid yaml \
bitops  formatR   httr mime whisker zoo"
if [ `uname -m` = "x86_64" -o `uname -m` = " x86-64" ]; then
LIBDIR="lib64"
else
LIBDIR="lib"
fi

# Without this the installation will try to put the R library in the
# system directories where it does not have permissions

R_VERSION=$(R --version | head -1 | cut -d \  -f 3 | awk -F \. {'print $1"."$2'})
pushd $SCRIPT_DIR > /dev/null
LOCAL_R_DIR=/home/$ME/R/`uname -m`-mageia-linux-gnu-library/$R_VERSION

echo "Installing new modules"
for i in $R_PKGS ; do
  rm -rf /usr/$LIBDIR/R/library/$i;
  mv -f $LOCAL_R_DIR/$i /usr/$LIBDIR/R/library ;
done
popd > /dev/null

if [ -d /home/$ME/git/shiny-server ]
then echo "Installing shiny server"
pushd /home/$ME/git/shiny-server 
sed -i -e s!bin/node!! -e s!bin/npm!! CMakeLists.txt
sed -i -e s!add_subdirectory\(external/node\)!! CMakeLists.txt
popd
make -C /home/$ME/git/shiny-server install
ln -s -f  ../lib/shiny-server/bin/shiny-server /usr/bin/shiny-server
#Create shiny user. On some systems, you may need to specify the full path to 'useradd'
useradd -r shiny -s /bin/false -M

# Create log, config, and application directories
mkdir -p /var/log/shiny-server
mkdir -p /var/www/shiny-server
mkdir -p /var/lib/shiny-server
chown shiny /var/log/shiny-server
mkdir -p /etc/shiny-server
cp -r /usr/$LIBDIR/R/library/shiny/examples/*  /var/www/shiny-server
fi

