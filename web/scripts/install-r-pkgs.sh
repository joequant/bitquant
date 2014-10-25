#!/bin/bash
# Setup and configure website to use giving configuration

echo "Running r installation"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/install-r-pkgs.sh`
R_PKGS="bitops caTools devtools digest evaluate formatR highr jsonlite knitr htmltools httpuv memoise mime Rcpp RJSONIO rmarkdown stringr testthat whisker xtable shiny yaml"

pushd $SCRIPT_DIR > /dev/null
. norootcheck.sh
# Without this the installation will try to put the R library in the
# system directories where it does not have permissions

R_VERSION=$(R --version | head -1 | cut -d \  -f 3 | awk -F \. {'print $1"."$2'})

LOCAL_R_DIR=/home/$ME/R/`uname -m`-mageia-linux-gnu-library/$R_VERSION
mkdir -p $LOCAL_R_DIR
mkdir -p /home/$ME/attic/$$
echo "Generating new modules"
/usr/bin/R -e "install.packages(c('shiny', 'Quandl', 'knitr', 'devtools', 'yaml'), repos='http://cran.rstudio.com/')"
/usr/bin/R -e 'options(repos=c(CRAN = "http://cran.rstudio.com/")); library(devtools) ; devtools::install_github("rstudio/rmarkdown")'
sudo /usr/share/bitquant/install-r-pkgs-sudo.sh $SCRIPT_DIR $ME

