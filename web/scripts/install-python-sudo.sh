#!/bin/bash
# sudo portion of python package installations

echo "Running python installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

#PYTHON_ARGS=--upgrade
#missing numba for now

for packages in \
    zipline vispy pyalgotrade statsmodels quandl \
	    patsy beautifulsoup4 pymongo sympy ipython_mongo seaborn \
	    toyplot ad collections-extended TA-Lib mpmath multimethods \
	    openpyxl param xray FinDates html5lib twilio plivo ggplot pygal \
	    plotly holoviews ipython[notebook] bokeh jupyterhub \
	    fastcluster  algobroker ib-api pandas-datareader \
	    ethercalc-python blaze ;
do pip3 install $PYTHON_ARGS $packages ;
done

if [ ! -e /usr/bin/ipython ] ; then
pushd /usr/bin
ln -s ipython3 ipython
popd
fi
