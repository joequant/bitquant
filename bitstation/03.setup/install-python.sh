#!/bin/bash
# sudo portion of python package installations

set -v
set +o errexit

echo "Running python installation"
#PYTHON_ARGS=--upgrade
#missing zipline since requirements installation causes issues

if [[ ! -z "$http_proxy" ]] ; then
    git config --global http.proxy $http_proxy
    if [[ ! -z "$GIT_PROXY" ]] ; then
	git config --global url."$GIT_PROXY".insteadOf https://
    fi
    git config --global http.sslVerify false
fi

# Pypi Tensorflow will fail on noavx
if [[ ! -z "$NOAVX" ]] ; then
    export TENSORFLOW=http://github.com/evdcush/TensorFlow-wheels/releases/download/tf-1.13.1-py37-cpu-westmere/tensorflow-1.13.1-cp37-cp37m-linux_x86_64.whl
else
    export TENSORFLOW=tensorflow==2.0.0
fi

# see http://click.pocoo.org/5/python3/
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ONNX_ML=1

SUPERSET=git+https://github.com/apache/incubator-superset.git

# Astropy is needed for tushare
# nnabla has dependence on old cython which breaks things
# install eventsourcing for dateutil

echo "pip_index_url=" $PIP_INDEX_URL

pip3 install --upgrade pip --prefix /usr
#remove to avoid attribute error
pip3 uninstall numpy -y
pip3 install --upgrade numpy requests six python-dateutil \
     matplotlib pandas scipy numpy pythreejs --prefix /usr

pip3 install --upgrade $TENSORFLOW --prefix /usr
pip3 install --upgrade mxnet --prefix /usr
pip3 install --upgrade torch --prefix /usr

# Fix for eventsourcing
pip3 install --upgrade pycryptodome --prefix /usr
cat <<EOF > /tmp/constraints.es.txt
six
requests
pycrypto
pycryptodome
python-dateutil
EOF

pip3 install --no-deps eventsourcing --prefix /usr
pip3 install --upgrade eventsourcing --prefix /usr -c /tmp/constraints.es.txt

# reinstall to get jupyter executable
# force 4.4.0 to work around ijavascript install issue
# https://github.com/n-riesco/ijavascript/issues/200
pip3 install --upgrade --force-reinstall jupyter-core --prefix /usr
pip3 install --upgrade $PYTHON_ARGS entrypoints --prefix /usr

# get fix for libpacke
pip3 install --upgrade git+https://github.com/ntucllab/libact.git --prefix /usr

PYCURL_SSL_LIBRARY=openssl pip3 install pycurl --prefix /usr

#Use tf-nightly-gpu instead of tensorflow to get python 3.7

# run cytoolz for python 3.8 for cython
pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir \
     https://github.com/pytoolz/cytoolz/tarball/master

#install first
cat <<EOF | xargs --max-args=1 --max-procs=2 pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir
ccxt
ipyleaflet
beakerx
h5py
vispy
itk-meshtopolydata
itkwidgets
ipygraphql
ipycanvas
ipydatetime

https://github.com/joequant/ethercalc-python/tarball/master
https://github.com/joequant/spyre/tarball/master
https://github.com/joequant/cryptoexchange/tarball/master
https://github.com/joequant/algobroker/tarball/master
https://github.com/joequant/bitcoin-price-api/tarball/master
https://github.com/joequant/pythalesians/tarball/master
https://github.com/quantopian/pyfolio/tarball/master
https://github.com/ematvey/pybacktest/tarball/master
https://github.com/bashtage/arch/tarball/master
https://github.com/joequant/OrderBook/tarball/master
https://github.com/joequant/bitcoin-etl/tarball/master
https://github.com/joequant/dynts/tarball/master
https://github.com/pymc-devs/pymc3/tarball/master
statsmodels
sklearn
Werkzeug
dgl
Flask
pyzmq
jupyterlab
ipympl
import-ipynb
astropy
sudospawner
jupyterhub
nbconvert
circuits
dask
xarray
networkx
lightning-python
vispy 
pyalgotrade 
ipywidgets 
ipyvolume
jupyter_declarativewidgets 
vega
nbpresent
jupyter_latex_envs
jupyterlab_latex
bqplot
cookiecutter
scikit-image
patsy
beautifulsoup4
pymongo
emcee
ipython_mongo
seaborn
ipysheet
toyplot
ad
arviz
collections-extended
mpmath
multimethods
openpyxl
param
xray
FinDates
html5lib
twilio
plivo
ggplot
pygal
plotly
holoviews
bokeh
fastcluster
ib-api
pandas-datareader
blaze
statsmodels
redis
redis-dump-load
picos
ecos
swiglpk
smcp
optlang
smcp
configproxy
prettyplotlib
mpld3
networkx
qgrid
iminuit
lmfit
redis_kernel
bash_kernel
octave_kernel
jupyter_nbextensions_configurator
pyfolio
VisualPortfolio
empyrical
qfrm
trade
chinesestockapi
bizdays
ffn
pulsar
pyspark
cvxopt
pynance
keras
nolearn
theano
nltk
gensim
scrapy
statsmodels
gym
milk
neurolab
pyrenn
jupyterlab_widgets
jhub_remote_user_authenticator
dash
dash_renderer
dash_core_components
dash_html_components
py4j
xgboost
catboost
lightgbm
tensorly
pyro-ppl
torchvision
gpytorch
horovod
skflow
pyomo
jupyter-tensorboard
flake8
vega_datasets
altair
Candela
web3
py-solc
opencv-python
dm-sonnet
tributary
mpld3
itkwidgets

Jupyter-Video-Widget
pybrain
ipyparallel
astroml
ffn
pyfin
vollib
FRB
folium
pattern
onnx
tzlocal
mypy
sidecar
black
yapf
autopep8
beakerx
jupyterlab_code_formatter
cppyy-cling
modAL
alipy
mglearn
ipymesh
bitcoin-tools
jupyter_dashboards
tributary
jupyter-git
cryptocompare
coinmarketcap
bitfinex-tencars
cryptowatch-client
voila
RISE
lolviz
papermill
ipytree
apache-airflow
jupyterlab-git
cryptofeed
jupyterlab-hdf
jupyterthemes
perspective-python
pulp
tsfresh
jupyterlab_code_formatter
scaleogram
pycwt
enigma-catalyst
quandl
kaggle
wget
TA-Lib
algorithmx
ipyevents
ipycanvas
PyPortfolioOpt
FinQuant
pyswarm
EOF

#broken for jupyterlab 2.0
:'
jupyterlab_templates
jupytext>=1.0.1
'

python3 -m bash_kernel.install --sys-prefix

#broken
#pylantern
#pytext-nlp
#jupyterlab_iframe

#broken
# can't install cboe
#tradingWithPython 

# eventsourcing
#git+https://github.com/joequant/quantdsl.git 

#not instaled
#pywwt
#nbdime

#jupytext 1.0.1 fixes issue #185
# https://github.com/mwouts/jupytext/issues/185

"""
cat <<EOF > /tmp/constraints.txt
numpy
matplotlib
xarray
pandas
jupyterlab_autoversion
ipyaggrid
EOF

# Skip for llvm9
# numba

pip3 install --no-deps mxnet nnabla allennlp pyquickhelper ipyleaflet $SUPERSET --prefix /usr
pip3 install --upgrade mxnet allennlp nnabla pyquickhelper ipyleaflet $SUPERSET --prefix /usr -c /tmp/constraints.txt
"""

# Set registry to non-ssl to allow caching
echo "Installing webpack"

npm install -g --unsafe webpack webpack-command

#link staging jupyterlab yarn to system yarn
#pushd $(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")/jupyterlab/staging
#ln -s -f ../../../../../lib/node_modules/yarn/lib/cli.js yarn.js
#popd

# There are some compile errors
#jupyter labextension install jupyterlab-spreadsheet
#jupyter labextension install holmantai/xyz-extension

#node-gyp requires that python be linked to python2

if [[ ! -z "$http_proxy" ]] ; then
    pushd $(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")/jupyterlab/staging
    cp .yarnrc .yarnrc.dist
    cat >> .yarnrc <<EOF
registry "http://registry.npmjs.org"
EOF
    popd
fi

#while read line; do echo $line ; jupyter labextension install --dev-build=False $line ; done <<EOF
cat <<EOF | xargs --max-args=15 --max-procs=1 jupyter labextension install --no-build
jupyter-matplotlib
ipysheet
jupyterlab-python-file
@jupyterlab/latex
@jupyter-widgets/jupyterlab-manager
bqplot-jupyterlab
@jupyterlab/mathjax3-extension
@ryantam626/jupyterlab_code_formatter
@jupyterlab/fasta-extension
@jupyterlab/geojson-extension
@jupyterlab/htmlviewer-extension
@jupyter-widgets/jupyterlab-sidecar
ipyevents
ipycanvas
@jupyterlab/celltags-extension
@jupyterlab/debugger
EOF

jupyter lab build --dev-build=False

# broken packages for jupyterlab 2.0
:'
jupyterlab_templates
@jupyterlab/git
jupyterlab_tensorboard
jupyterlab-drawio
jupyterlab-spreadsheet
@jupyterlab/toc
jupyterlab_filetree
@mflevine/jupyterlab_html
jupyterlab_autoversion
@oriolmirosa/jupyterlab_materialdarker
@jupyterlab/katex-extension
@jupyterlab/vega4-extension
jupyterlab_bokeh
@jupyter-voila/jupyterlab-preview
ipytree
@jupyterlab/commenting-extension
@jupyterlab/google-drive
@jupyterlab/dataregistry-extension
@finos/perspective-jupyterlab
@lckr/jupyterlab_variableinspector
@krassowski/jupyterlab_go_to_definition
@jupyterlab/plotly-extension
@jupyterlab/hdf5
@illumidesk/jupyter-lti
@hadim/jupyter-archive
@aquirdturtle/collapsible_headings
beakerx-jupyterlab
jupyterlab-datawidgets
itkwidgets
@frontierkz/jupyterlab-attachments
'



# does not support current version of JupyterLab
# @enlznep/jupyterlab_shell_file

:'
@agoose77/jupytreextlab-attachments
jupyter-leaflet
nbdime-jupyterlab
jupyterlab_voyager
qgrid
jupyterlab-kernelspy
@ijmbarr/jupyterlab_spellchecker
@jupyterlab/hub-extension
@pyviz/jupyterlab_holoviews
@candela/jupyterlab
jupyterlab_iframe
@lean-data-science/jupyterlab_credentialstore
@hkjinlee/jupyterlab_gz
@jupyterlab/vega2-extension
@jupyterlab/vega3-extension
'

# broken packages
# pylantern
#ipyaggrid

#jupyter lab build --dev-build=False
jupyter dashboards quick-setup --sys-prefix
jupyter nbextensions_configurator enable --sys-prefix
#jupyter nbextension install --py --sys-prefix jpy_video --system
#jupyter nbextension enable  --py --sys-prefix jpy_video --system
#jupyter labextension install jupyter-video
jupyter serverextension enable --py jupyterlab --sys-prefix
jupyter serverextension enable --py jupyter_tensorboard --sys-prefix
jupyter serverextension enable --py jupyterlab_code_formatter --sys-prefix
jupyter serverextension enable --py jupyterlab_git --sys-prefix
#jupyter nbextension disable --py --sys-prefix ipysheet.renderer_nbext
#jupyter labextension disable ipysheet:renderer # for jupyter lab
#jupyter serverextension enable --py jupyterlab_templates
#jupyter serverextension enable --py jupyterlab_iframe

:'
fabmanager create-admin --app superset
superset db upgrade
superset init
superset load_examples
'

if [ ! -e /usr/bin/ipython ] ; then
pushd /usr/bin
ln -s ipython3 ipython
popd
fi

#Create rhea user to spawn jupyterhub
useradd -r rhea -s /bin/false -M -G shadow

if [[ ! -z "$http_proxy" ]] ; then
    pushd $(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")/jupyterlab/staging
    mv -f .yarnrc.dist .yarnrc
    popd
fi
