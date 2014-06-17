#!/bin/bash
# Setup and configure website to use giving configuration

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/install-r-pkgs.sh`
R_PKGS="bitops caTools digest htmltools httpuv Rcpp RJSONIO xtable shiny"

pushd $SCRIPT_DIR > /dev/null
. norootcheck.sh
# Without this the installation will try to put the R library in the
# system directories where it does not have permissions

if [ `uname -m` = "x86_64" -o `uname -m` = " x86-64" ]; then
LIBDIR="lib64"
else
LIBDIR="lib"
fi

LOCAL_R_DIR=/home/$ME/R/`uname -m`-mageia-linux-gnu-library/3.0
mkdir -p $LOCAL_R_DIR
mkdir -p /home/$ME/attic/$$


for i in $R_PKGS ; do
  sudo mv /usr/$LIBDIR/R/library/$i /home/$ME/attic/$$ 2>/dev/null
done
/usr/bin/R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"

for i in $R_PKGS ; do
  sudo mv -f $LOCAL_R_DIR/$i /usr/$LIBDIR/R/library 2>/dev/null
done
popd > /dev/null

