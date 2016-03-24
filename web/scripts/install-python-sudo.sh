#!/bin/bash
# sudo portion of python package installations

echo "Running python installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

#PYTHON_ARGS=--upgrade
#missing numba for now
#missing zipline since requirements installation causes issues

pip3 install --upgrade pip
for packages in \
    vispy pyalgotrade statsmodels quandl \
	    patsy beautifulsoup4 pymongo ipython_mongo seaborn \
	    toyplot ad collections-extended TA-Lib mpmath multimethods \
	    openpyxl param xray FinDates html5lib twilio plivo ggplot pygal \
	    plotly holoviews jupyter bokeh \
	    git+https://github.com/jupyter/jupyterhub.git \
	    fastcluster algobroker ib-api pandas-datareader \
	    blaze statsmodels redis redis-dump-load \
	    git+https://github.com/joequant/ethercalc-python.git \
            git+https://github.com/joequant/spyre.git \
	    git+https://github.com/joequant/cryptoexchange.git \
	    git+https://github.com/joequant/algobroker.git \
	    git+https://github.com/joequant/bitcoin-price-api.git \
	    git+https://github.com/joequant/matta.git \
            configproxy prettyplotlib mpld3 networkx \
            iminuit lmfit redis_kernel bash_kernel ; 
do pip3 install $PYTHON_ARGS $packages ;
done

cp -r /root/.local/share/jupyter/kernels/* /home/$ME/.local/share/jupyter/kernels
chown $ME:$ME -R /home/$ME/.local/share/jupyter/kernels

if [ ! -e /usr/bin/ipython ] ; then
pushd /usr/bin
ln -s ipython3 ipython
popd
fi
