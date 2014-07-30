#!/bin/bash
# Setup and configure website to use giving configuration

echo "Running r installation"
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
echo "backing up old modules"
for i in $R_PKGS ; do
  sudo mv /usr/$LIBDIR/R/library/$i /home/$ME/attic/$$ 
done
echo "Generating new modules"
/usr/bin/R -e "install.packages(c('shiny', 'Quandl', 'knitr'), repos='http://cran.rstudio.com/')"

echo "Installing new modules"
for i in $R_PKGS ; do
  sudo mv -f $LOCAL_R_DIR/$i /usr/$LIBDIR/R/library ;
done
popd > /dev/null

echo "Installing shiny server"
sudo make -C /home/$ME/git/shiny-server install
sudo ln -s  ../lib/shiny-server/bin/shiny-server /usr/bin/shiny-server
#Create shiny user. On some systems, you may need to specify the full path to 'useradd'
sudo useradd -r shiny -s /bin/false -M

# Create log, config, and application directories
sudo mkdir -p /var/log/shiny-server
sudo mkdir -p /var/www/shiny-server
sudo mkdir -p /var/lib/shiny-server
sudo chown shiny /var/log/shiny-server
sudo mkdir -p /etc/shiny-server
sudo cp -r /usr/$LIBDIR/R/library/shiny/examples/*  /var/www/shiny-server

