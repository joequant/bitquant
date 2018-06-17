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

#set default python to python3
pushd /usr/bin
ln -sf python3 python
popd

# Astropy is needed for tushare
# nnabla has dependence on old cython which breaks things
# install eventsourcing for dateutil

pip3 install --upgrade pip --prefix /usr
# reinstall to get jupyter executable
pip3 install --upgrade --force-reinstall jupyter-core --prefix /usr

for packages in \
    entrypoints \
    python-dateutil==2.6.1 \
    eventsourcing \
    numpy \
    matplotlib \
    pandas \
    scipy \
    astropy \
    jupyterhub \
    nbconvert \
	sudospawner \
	lightning-python \
	vispy pyalgotrade statsmodels quandl ipywidgets ipyvolume \
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
            iminuit lmfit redis_kernel bash_kernel octave_kernel \
	    jupyter_nbextensions_configurator pyfolio \
            superset VisualPortfolio empyrical qfrm tradingWithPython \
            trade pybacktest chinesestockapi bizdays \
            git+https://github.com/bashtage/arch.git ffn \
	    git+https://github.com/joequant/OrderBook.git \
	    git+https://github.com/joequant/quantdsl.git \
	    pulsar pyspark cvxopt \
	    git+https://github.com/joequant/dynts.git \
            pynance jupyterlab ipyleaflet keras mxnet nolearn \
	    theano tensorflow nltk gensim scrapy statsmodels gym milk \
	    neurolab pyrenn jupyterlab_widgets\
	    jhub_remote_user_authenticator jupyterlab-discovery \
	    dash dash_renderer dash_core_components dash_html_components ;
do pip3 install --upgrade $PYTHON_ARGS $packages --prefix /usr ;
done

jupyter contrib nbextension install --sys-prefix
jupyter declarativewidgets quick-setup
jupyter nbextensions_configurator enable --sys-prefix
jupyter serverextension enable --py jupyterlab --sys-prefix
jupyter labextension install jupyterlab_bokeh
jupyter labextension enable jupyterlab_bokeh
jupyter labextension install @jupyter-widgets/jupyterlab-manager

for extension in \
    codefolding/main search-replace/main ;
    do jupyter nbextension enable $extension --sys-prefix --system ;
done


for extension in \
    widgetsnbextension declarativewidgets vega pythreejs nbpresent \
      bqplot ipyleaflet ; 
    do jupyter nbextension install --py $extension --sys-prefix 
       jupyter nbextension enable --py $extension --sys-prefix --system ;
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

#Create rhea user to spawn jupyterhub
useradd -r rhea -s /bin/false -M -G shadow
