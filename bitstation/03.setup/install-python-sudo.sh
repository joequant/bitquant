#!/bin/bash
# sudo portion of python package installations

set -v
set +o errexit

echo "Running python installation"
#PYTHON_ARGS=--upgrade
#missing zipline since requirements installation causes issues

if [[ ! -z "$http_proxy" ]] ; then
    npm config set registry http://registry.npmjs.org/
    npm install -g yarn
    yarn config set registry http://registry.yarnpkg.com/
    git config --global http.proxy $http_proxy
    if [[ ! -z "$GIT_PROXY" ]] ; then
	git config --global url."$GIT_PROXY".insteadOf https://
    fi
    git config --global http.sslVerify false

#    npm config set proxy $NPM_PROXY
#    npm config set http-proxy $NPM_PROXY
#    npm config set strict-ssl false
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
pip3 install --upgrade tensorflow torch --prefix /usr

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
pip3 install --upgrade --force-reinstall jupyter-core --prefix /usr
pip3 install --upgrade $PYTHON_ARGS entrypoints --prefix /usr


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
git+https://github.com/joequant/quantdsl.git
git+https://github.com/joequant/dynts.git
sklearn
Werkzeug
Flask
pyzmq
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
quandl
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
pymc3
emcee
ipython_mongo
seaborn
ipysheet
toyplot
ad
collections-extended
TA-Lib
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
pylantern
mpld3
nbdime
itkwidgets
jupyterlab_templates
jupyterlab_iframe
pywwt
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
pytext-nlp
sidecar
black
yapf
autopep8
beakerx
EOF

cat <<EOF > /tmp/constraints.txt
numpy
matplotlib
xarray
pandas
jupyterlab_autoversion
EOF

pip3 install --no-deps mxnet nnabla allennlp pyquickhelper ipyleaflet $SUPERSET --prefix /usr
pip3 install --upgrade mxnet allennlp nnabla pyquickhelper ipyleaflet $SUPERSET --prefix /usr -c /tmp/constraints.txt

# Set registry to non-ssl to allow caching
echo "Installing webpack"

npm install -g --unsafe webpack webpack-command

#link staging jupyterlab yarn to system yarn
pushd $(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")/jupyterlab/staging
ln -s -f ../../../../../lib/node_modules/yarn/lib/cli.js yarn.js
popd

# There are some compile errors
#jupyter labextension install jupyterlab-spreadsheet
#jupyter labextension install holmantai/xyz-extension

#node-gyp requires that python be linked to python2

cat <<EOF | xargs --max-args=1 --max-procs=1 jupyter labextension install
nbdime-jupyterlab
@jupyterlab/git
@jupyterlab/google-drive
jupyterlab_tensorboard
jupyterlab_bokeh
@jupyter-widgets/jupyterlab-manager
jupyter-matplotlib
jupyterlab_voyager
jupyterlab_templates
ipysheet
qgrid
@jupyterlab/toc
@jupyterlab/latex
jupyterlab-kernelspy
@ijmbarr/jupyterlab_spellchecker
@jupyterlab/hub-extension
@mflevine/jupyterlab_html
@pyviz/jupyterlab_holoviews
@jupyterlab/fasta-extension
@jupyterlab/geojson-extension
@jupyterlab/mathjax3-extension
@jupyterlab/katex-extension
@jupyterlab/plotly-extension
@jupyterlab/vega2-extension
@jupyterlab/vega3-extension
@jupyterlab/celltags
@candela/jupyterlab
jupyterlab-drawio
pylantern
jupyter-leaflet
bqplot
@lckr/jupyterlab_variableinspector
@oriolmirosa/jupyterlab_materialdarker
jupyterlab_iframe
jupyterlab-python-file
jupyter-video
jupyterlab_filetree
@agoose77/jupyterlab-attachments
@enlznep/jupyterlab_shell_file
@jupyter-widgets/jupyterlab-sidecar
@ryantam626/jupyterlab_code_formatter
@krassowski/jupyterlab_go_to_definition
jupyterlab-spreadsheet
@lean-data-science/jupyterlab_credentialstore
@hkjinlee/jupyterlab_gz
jupyterlab_autoversion
EOF

jupyter lab build
jupyter nbextensions_configurator enable --sys-prefix
jupyter nbextension install --py --sys-prefix jpy_video --system
jupyter nbextension enable  --py --sys-prefix jpy_video --system
jupyter serverextension enable --py jupyterlab --sys-prefix
jupyter serverextension enable --py jupyter_tensorboard --sys-prefix
jupyter serverextension enable --py jupyter_code_formatter --sys-prefix
#jupyter nbextension disable --py --sys-prefix ipysheet.renderer_nbext
#jupyter labextension disable ipysheet:renderer # for jupyter lab
jupyter serverextension enable --py jupyterlab_templates
jupyter serverextension enable --py jupyterlab_iframe

fabmanager create-admin --app superset
superset db upgrade
superset init
superset load_examples

if [ ! -e /usr/bin/ipython ] ; then
pushd /usr/bin
ln -s ipython3 ipython
popd
fi

#Create rhea user to spawn jupyterhub
useradd -r rhea -s /bin/false -M -G shadow
