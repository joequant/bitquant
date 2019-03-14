#!/bin/bash
# Setup and configure website to use giving configuration

echo "Running r installation"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/install-r-pkgs.sh`

pushd $SCRIPT_DIR > /dev/null
. norootcheck.sh
# Without this the installation will try to put the R library in the
# system directories where it does not have permissions

R_VERSION=$(R --version | head -1 | cut -d \  -f 3 | awk -F \. {'print $1"."$2'})

LOCAL_R_DIR=/home/$ME/R/`uname -m`-mageia-linux-gnu-library/$R_VERSION
export PATH=/usr/lib64/R/bin:/usr/lib/R/bin:$PATH
mkdir -p $LOCAL_R_DIR
mkdir -p /home/$ME/attic/$$
echo "Generating new modules"
/usr/bin/R -e "install.packages(c('stringi', 'magrittr', 'devtools', 'crayon', 'pbdZMQ', 'reticulate'), repos='http://cran.r-project.org/', dependencies=TRUE)"
/usr/bin/R -e "install.packages(c('shiny','Quandl','knitr', 'rzmq'), repos='http://cran.r-project.org/')"
/usr/bin/R -e 'options(repos=c(CRAN = "http://cran.r-project.org/")); library(devtools) ; devtools::install_github("rstudio/rmarkdown")'
/usr/bin/R -e 'options(repos=c(CRAN = "http://cran.r-project.org/")); library(devtools) ; install_github("IRkernel/repr"); devtools::install_github("IRKernel/IRdisplay"); devtools::install_github("IRKernel/IRkernel")'
sudo /usr/share/bitquant/install-r-pkgs-sudo.sh $SCRIPT_DIR $ME

