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

# see http://click.pocoo.org/5/python3/
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

pip3 install --upgrade pip
for packages in \
    git+https://github.com/joequant/datagramas.git \
    jupyterhub \
	vispy pyalgotrade statsmodels quandl ipywidgets \
	jupyter_declarativewidgets pythreejs vega nbpresent \
	ipyleaflet bqplot cookiecutter pyquickhelper scikit-image \
	    patsy beautifulsoup4 pymongo ipython_mongo seaborn \
	    toyplot ad collections-extended TA-Lib mpmath multimethods \
	    openpyxl param xray FinDates html5lib twilio plivo ggplot pygal \
	    plotly holoviews bokeh fastcluster ib-api pandas-datareader \
	    blaze statsmodels redis redis-dump-load \
	    git+https://github.com/joequant/ethercalc-python.git \
            git+https://github.com/joequant/spyre.git \
	    git+https://github.com/joequant/cryptoexchange.git \
	    git+https://github.com/joequant/algobroker.git \
	    git+https://github.com/joequant/bitcoin-price-api.git \
	    git+https://github.com/joequant/pythalesians.git \
	    git+https://github.com/quantopian/pyfolio.git \
            configproxy prettyplotlib mpld3 networkx qgrid \
	    git+https://github.com/joequant/IPython-notebook-extensions.git \
            iminuit lmfit redis_kernel bash_kernel \
	    jupyter_nbextensions_configurator pyfolio \
            caravel VisualPortfolio empyrical qfrm tradingWithPython \
            trade pybacktest dynts chinesestockapi bizdays \
            git+https://github.com/bashtage/arch.git ffn \
            quantdsl pynance; 
do pip3 install $PYTHON_ARGS $packages ;
done

#            

jupyter contrib nbextension install --sys-prefix
jupyter declarativewidgets quick-setup --sys-prefix
jupyter nbextensions_configurator enable --sys-prefix

for extension in \
    codefolding/main search-replace/main ;
    do jupyter nbextension enable $extension --sys-prefix
done


for extension in \
    widgetsnbextension declarativewidgets vega pythreejs nbpresent ; 
    do jupyter nbextension install --py $extension --sys-prefix 
       jupyter nbextension enable --py $extension --sys-prefix ;
done

mkdir -p /home/$ME/.local/share/jupyter/kernels
cp -r /root/.local/share/jupyter/kernels/* /home/$ME/.local/share/jupyter/kernels
chown $ME:$ME -R /home/$ME/.local/share/jupyter

fabmanager create-admin --app caravel
caravel db upgrade
caravel init
caravel load_examples

if [ ! -e /usr/bin/ipython ] ; then
pushd /usr/bin
ln -s ipython3 ipython
popd
fi
