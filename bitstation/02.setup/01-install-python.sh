#!/bin/bash
# sudo portion of python package installations

set -v
set -o errexit

source $rootfsDir/tmp/proxy.sh
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
    export TENSORFLOW=tensorflow
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

#needed to remove requests to reinstall with requests
rm -rf /usr/lib/python3.8/site-packages/requests*

pip3 install --upgrade python-dateutil requests \
     matplotlib scipy --prefix /usr

pip3 install --upgrade $TENSORFLOW --prefix /usr
pip3 install --upgrade mxnet --prefix /usr
pip3 install --upgrade torch --prefix /usr

# Fix for eventsourcing
pip3 install --upgrade pycryptodome --prefix /usr
cat <<EOF > /tmp/constraints.es.txt
six
pycrypto
pycryptodome
python-dateutil
EOF

pip3 install --no-deps eventsourcing --prefix /usr
pip3 install --upgrade eventsourcing --prefix /usr -c /tmp/constraints.es.txt

# reinstall to get jupyter executable
pip3 install --upgrade jupyter-core --prefix /usr
pip3 install --upgrade $PYTHON_ARGS entrypoints --prefix /usr

# get fix for libpacke
# don't install because it needs old scikit-learn
#pip3 install --prefix /usr --global-option=build_ext --global-option="-I/usr/include/lapacke" libact

PYCURL_SSL_LIBRARY=openssl pip3 install pycurl --prefix /usr

#Use tf-nightly-gpu instead of tensorflow to get python 3.7

# run cytoolz for python 3.8 for cython
pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir \
     https://github.com/pytoolz/cytoolz/tarball/master

#pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir \
#     "git+https://github.com/cchuang2009/PySDE.git#subdirectory=Python3&egg=PyS3DE"

#https://github.com/maartenbreddels/ipyvolume/issues/295
#https://github.com/conda-forge/ipyvolume-feedstock/pull/34

#https://github.com/maartenbreddels/ipyvolume/issues/324
npm install -g source-map
pip3 install bqplot --prefix /usr --no-cache-dir
pip3 install ipyvolume==0.6.0a6 --prefix /usr --no-cache-dir

#install first
# install special version of jupyterlab-sql that is built for v2

#install perspective-python - need pyarrow 0.16
pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir \
     pyarrow==0.16.0
pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir \
     perspective-python

pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir beakerx

#https://github.com/joequant/gmaps/tarball/master
#pyspark
npm install -g webpack webpack-cli
parallel --halt 2 -j1 -n1 --linebuffer --tagstring '{}' "pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir '{}'" ::: <<EOF
nbformat
ml-python
vega
git+https://github.com/joequant/jupyterlab-sql.git@support-v2
ccxt
voila
h5py
https://github.com/joequant/ethercalc-python/tarball/master
https://github.com/joequant/spyre/tarball/master
https://github.com/joequant/cryptoexchange/tarball/master
https://github.com/joequant/algobroker/tarball/master
https://github.com/joequant/bitcoin-price-api/tarball/master
finmarketpy
https://github.com/quantopian/pyfolio/tarball/master
https://github.com/ematvey/pybacktest/tarball/master
https://github.com/bashtage/arch/tarball/master
https://github.com/joequant/OrderBook/tarball/master
https://github.com/joequant/bitcoin-etl/tarball/master
https://github.com/joequant/dynts/tarball/master
https://github.com/pymc-devs/pymc3/tarball/master
biopython
cubes
statsmodels
sklearn
Werkzeug
dgl
Flask
jupyterlab
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
pyalgotrade
nbpresent
jupyter_latex_envs
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
calysto_bash
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
jhub_remote_user_authenticator
dash
dash_renderer
dash_core_components
dash_html_components
xgboost
catboost
lightgbm
tensorly
pyro-ppl
torchvision
gpytorch
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
mpld3
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
black
yapf
autopep8
jupyterlab_code_formatter
cppyy-cling
modAL
alipy
mglearn
bitcoin-tools
jupyter_dashboards
cryptocompare
coinmarketcap
bitfinex-tencars
cryptowatch-client
voila
RISE
lolviz
papermill
apache-airflow
cryptofeed
jupyterthemes
pulp
tsfresh
scaleogram
pycwt
freqtrade
quandl
kaggle
wget
TA-Lib
PyPortfolioOpt
FinQuant
pyswarm
nilearn
psychopy
pipenv
scoop
sunpy
fs
xeus-python
vpython
bankroll[ibkr,schwab,fidelity]
investpy
deap
algorithmx
itkwidgets
jupyter_bokeh
jupyterlab-commenting-service
ipylab
ipyaggrid
black
isort
rpy2
qgrid
ipycanvas
ipyevents
ipympl
ipython-sql
psycopg2-binary
hy
https://github.com/ekaschalk/jedhy/tarball/master
https://github.com/Calysto/calysto_hy/tarball/master
https://github.com/joequant/jupyter-fs/tarball/master
https://github.com/joequant/webdavfs/tarball/master
https://github.com/joequant/PySDE/tarball/master
https://github.com/joequant/jupytext/tarball/master
https://github.com/joequant/jupyterlab-latex/tarball/master
jupyterlab-git
mplfinance
jupyter_telemetry
ax-platform
optuna
hyperopt
pySOT
pymoo
Platypus-Opt
jupyter-dash
EOF

# disable gmaps because it causes all widgets to disappear

pushd /tmp
git clone https://github.com/yixuan/LBFGSpp.git
cp -r LBFGSpp/include/* /usr/include
popd

HOROVOD_WITHOUT_GLOO=1 pip3 install --upgrade $PYTHON_ARGS --prefix /usr --no-cache-dir \
    https://github.com/joequant/horovod/tarball/master


#jupytext is not compatible with jupyter-fs

# moved out
#mlpy
#python-weka-wrapper

# moved out
: '
jupyterlab-commenting-service
itkwidgets
ipywidgets
jupyter-bokeh
jupytext
ipylab
algorithmx
ipydatetime
ipycallback
jupyterlab-latex
jupyter_declarativewidgets
tributary
ipytree
ipywidgets 
ipympl
itkwidgets
jupyterlab_widgets
sidecar
algorithmx
jupyter-fs
ipycanvas
ipygraphql
ipyevents
ipymesh
ipyleaflet
jupyterlab-git
jupyterlab-hdf
ipydatetime
ipywebrtc
itk-meshtopolydata
'

# Remove pyfilesystem in favor of jupyter-fs

#broken for jupyterlab 2.0
: '
jupyter-git
jupyterlab_templates
jupytext>=1.0.1
'

# use calysto bash
#python3 -m bash_kernel.install --sys-prefix
python3 -m calysto_hy install

#broken
#pylantern
#pytext-nlp
#jupyterlab_iframe
#

#broken
# can't install cboe
#tradingWithPython
#graphtool

# eventsourcing
#git+https://github.com/joequant/quantdsl.git 

#not instaled
#pywwt
#nbdime

#jupytext 1.0.1 fixes issue #185
# https://github.com/mwouts/jupytext/issues/185

: '
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
'

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

#https://github.com/maartenbreddels/ipyvolume/issues/324\

parallel --halt 2 -j1 -n1 --linebuffer --tagstring '{}' 'jupyter labextension install --no-build {}' ::: <<EOF
@jupyter-widgets/jupyterlab-manager
bqplot
ipyvolume
jupyter-threejs
algorithmx
algorithmx-jupyter
jupyter-matplotlib
jupyterlab-datawidgets
itkwidgets
@bokeh/jupyter_bokeh
jupyterlab-spreadsheet
@jupyterlab/vega2-extension
@jupyterlab/vega3-extension
@jupyterlab/fasta-extension
@jupyterlab/geojson-extension
@jupyterlab/commenting-extension
@jupyterlab/github
@jupyterlab/toc
@jupyter-voila/jupyterlab-preview
@aquirdturtle/collapsible_headings
@lckr/jupyterlab_variableinspector
@ryantam626/jupyterlab_code_formatter
jupyterlab-drawio
ipylab
ipyaggrid
ipysheet
qgrid2
jupyterlab-kernelspy
ipycanvas
ipyevents
@pyviz/jupyterlab_pyviz
jupyterlab-plotly
plotlywidget
vispy
EOF

do_github_install () {
pushd /tmp
git clone --depth=1 $1
pushd `basename $1 .git`
jlpm
jlpm run build
jupyter labextension install --no-build .
popd
rm -rf `basename $1 .git` 
popd
}

export -f do_github_install

parallel --halt 2 -j1 -n1 --linebuffer --tagstring '{}' 'do_github_install {}' ::: <<EOF
https://github.com/joequant/jupyterlab_filetree.git
https://github.com/joequant/jupyterlab-latex.git
EOF

# remove mathjax3 and katex extensions as they are missing
# mathjax3 features

: '
jupyterlab_filetree
@jupyterlab/toc
@jupyterlab/debugger
@jupyterlab/celltags
@jupyterlab/commenting-extension
@jupyterlab/pullrequests
@jupyterlab/celltags-extension
@jupyterlab/github
itkwidgets
ipylab
algorithmx-jupyter
jupyterlab_filetree
@lckr/jupyterlab_variableinspector
@jupyterlab/toc-extension
@jupyterlab/latex
@jupyterlab/dataregistry-extension
@jupyterlab/commenting-extension
jupyterlab-datawidgets
jupyter-matplotlib
ipysheet
jupyterlab-python-file
jupyter-webrtc
jupyter-threejs
@ryantam626/jupyterlab_code_formatter
@jupyterlab/fasta-extension
@jupyterlab/geojson-extension
@jupyterlab/htmlviewer-extension
@jupyter-widgets/jupyterlab-sidecar
ipycanvas
'

# broken for now - see https://github.com/jupyterlab/jupyterlab-latex/issues/135
: '
@jupyterlab/latex
'

# broken packages for jupyterlab 2.0
: '
jupyterlab_templates
@jupyterlab/git
jupyterlab_tensorboard
jupyterlab-drawio
jupyterlab-spreadsheet
@jupyterlab/toc
jupyterlab_filetree
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

: '
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

jupyter serverextension enable jupyterlab_sql --py --sys-prefix
jupyter serverextension enable jupytext --sys-prefix

jupyter lab build
echo "Log jupyterlab"
cat /tmp/jupyterlab-debug-*.log || true

jupyter dashboards quick-setup --sys-prefix
jupyter nbextensions_configurator enable --sys-prefix
jupyter serverextension enable --py jupyter_tensorboard --sys-prefix
jupyter serverextension enable --py jupyterlab_code_formatter --sys-prefix

#set up for jupyterfs

cat <<EOF > /usr/etc/jupyter/jupyter_notebook_config.py
# jupyterfs contents manager
c.NotebookApp.contents_manager_class = "jupyterfs.metamanager.MetaManager"
c.LatexConfig.latex_command = 'pdflatex'
EOF

: '
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
pump --shutdown
