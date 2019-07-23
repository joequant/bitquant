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
    export TENSORFLOW=tensorflow==2.0.0-beta1
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
     matplotlib pandas scipy pythreejs --prefix /usr

pip3 install --upgrade $TENSORFLOW --prefix /usr

"""
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
"""

# reinstall to get jupyter executable
# force 4.4.0 to work around ijavascript install issue
# https://github.com/n-riesco/ijavascript/issues/200
pip3 install --upgrade --force-reinstall jupyter-core --prefix /usr
pip3 install --upgrade $PYTHON_ARGS entrypoints --prefix /usr

# get fix for libpacke
pip3 install --upgrade git+https://github.com/joequant/libact.git --prefix /usr

PYCURL_SSL_LIBRARY=openssl pip3 install pycurl --prefix /usr

#Use tf-nightly-gpu instead of tensorflow to get python 3.7

cat <<EOF | xargs --max-args=12 --max-procs=$(nproc) pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir
git+https://github.com/joequant/ethercalc-python.git
git+https://github.com/joequant/spyre.git
git+https://github.com/joequant/cryptoexchange.git
git+https://github.com/joequant/algobroker.git
git+https://github.com/joequant/bitcoin-price-api.git
git+https://github.com/joequant/pythalesians.git
git+https://github.com/quantopian/pyfolio.git
git+https://github.com/ematvey/pybacktest.git
git+https://github.com/bashtage/arch.git
git+https://github.com/joequant/OrderBook.git
git+https://github.com/joequant/bitcoin-etl.git
git+https://github.com/joequant/dynts.git
git+https://github.com/pymc-devs/pymc3
sklearn
Werkzeug
dgl
Flask
pyzmq
ccxt
jupyterlab
numba
ipympl
import-ipynb
astropy
jupyterhub
nbconvert
sudospawner
circuits
dask
xarray
networkx
lightning-python
vispy 
pyalgotrade 
statsmodels
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
tradingWithPython
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
jupyterlab_templates
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
jupytext>=1.0.1
jupyterlab_code_formatter
cppyy-cling
modAL
alipy
mglearn
bitcoin-tools
jupyter_dashboards
tributary
jupyter-git
EOF

python3 -m bash_kernel.install --sys-prefix

#broken
#TA-Lib
#pylantern
#pytext-nlp
#quandl
#jupyterlab_iframe
#ipyleaflet

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

cat <<EOF | xargs --max-args=12 --max-procs=1 jupyter labextension install --dev-build=False
@jupyterlab/git
jupyterlab_tensorboard
jupyter-matplotlib
jupyterlab_templates
ipysheet
jupyterlab-drawio
jupyterlab-python-file
jupyterlab-spreadsheet
jupyterlab_filetree
@jupyterlab/toc
@jupyterlab/latex
@jupyter-widgets/jupyterlab-manager
bqplot-jupyterlab
@mflevine/jupyterlab_html
@jupyterlab/mathjax3-extension
jupyterlab_autoversion
@oriolmirosa/jupyterlab_materialdarker
@ryantam626/jupyterlab_code_formatter
@jupyterlab/fasta-extension
@jupyterlab/geojson-extension
@jupyterlab/katex-extension
@jupyterlab/plotly-extension
@jupyterlab/vega4-extension
@jupyterlab/celltags
@jupyterlab/git
EOF

:'
@enlznep/jupyterlab_shell_file
@lckr/jupyterlab_variableinspector
@agoose77/jupyterlab-attachments
jupyter-leaflet
@jupyterlab/google-drive
nbdime-jupyterlab
jupyterlab_bokeh
jupyterlab_voyager
qgrid
jupyterlab-kernelspy
@ijmbarr/jupyterlab_spellchecker
@jupyterlab/hub-extension
@pyviz/jupyterlab_holoviews
@candela/jupyterlab
jupyterlab_iframe
@jupyter-widgets/jupyterlab-sidecar
@krassowski/jupyterlab_go_to_definition
@lean-data-science/jupyterlab_credentialstore
@hkjinlee/jupyterlab_gz
@jupyterlab/vega2-extension
@jupyterlab/vega3-extension
'

# broken packages
# pylantern
#ipyaggrid


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
