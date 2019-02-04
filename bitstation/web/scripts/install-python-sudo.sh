#!/bin/bash
# sudo portion of python package installations

echo "Running python installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

#PYTHON_ARGS=--upgrade
#missing zipline since requirements installation causes issues

# see http://click.pocoo.org/5/python3/
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

SUPERSET=git+https://github.com/apache/incubator-superset.git

# Astropy is needed for tushare
# nnabla has dependence on old cython which breaks things
# install eventsourcing for dateutil

pip3 install --upgrade pip --prefix /usr
#remove to avoid attribute error
pip3 uninstall numpy -y
pip3 install --upgrade numpy --prefix /usr

# reinstall to get jupyter executable
pip3 install --upgrade --force-reinstall jupyter-core --prefix /usr
pip3 install --upgrade $PYTHON_ARGS entrypoints python-dateutil==2.6.1 --prefix /usr


PYCURL_SSL_LIBRARY=openssl pip3 install pycurl --prefix /usr

#Use tf-nightly-gpu instead of tensorflow to get python 3.7

cat <<EOF | xargs --max-args=1 --max-procs=$(nproc) pip3 install --upgrade $PYTHON_ARGS --prefix /usr
six
sklearn
Werkzeug
Flask
pyzmq
jupyterlab
numba
ipympl
import-ipynb
matplotlib
pandas
scipy
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
pythreejs
vega
nbpresent
jupyter_latex_envs
jupyterlab_latex
ipyleaflet
bqplot
cookiecutter
pyquickhelper
scikit-image
patsy
beautifulsoup4
pymongo
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
git+https://github.com/joequant/ethercalc-python.git
git+https://github.com/joequant/spyre.git
git+https://github.com/joequant/cryptoexchange.git
git+https://github.com/joequant/algobroker.git
git+https://github.com/joequant/bitcoin-price-api.git
git+https://github.com/joequant/pythalesians.git
git+https://github.com/quantopian/pyfolio.git
nnabla
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
git+https://github.com/ematvey/pybacktest.git
chinesestockapi
bizdays
git+https://github.com/bashtage/arch.git
ffn
git+https://github.com/joequant/OrderBook.git
git+https://github.com/joequant/quantdsl.git
pulsar
pyspark
cvxopt
git+https://github.com/joequant/dynts.git
pynance
ipyleaflet
keras
nolearn
theano
tf-nightly
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
torch
torchvision
$SUPERSET
OpenNN
py4j
xgboost
catboost
lightgbm
tensorly
pyro-ppl
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
torchvision
cv2
imlib
dm-sonnet
caffe2
tributary
pylantern
mpld3
nbdime
itkwidgets
jupyterlab_templates
jupyterlab_iframe
pywwt
Jupyter-Video-Widget
jupytext
EOF

cat <<EOF > /tmp/constraints.txt
numpy
matplotlib
EOF

pip3 install --no-deps mxnet --prefix /usr
pip3 install --no-deps allennlp --prefix /usr
pip3 install --upgrade mxnet allennlp --prefix /usr -c /tmp/constraints.txt

echo "Installing webpack"
npm install -g --unsafe webpack webpack-command

jupyter contrib nbextension install
jupyter nbextensions_configurator enable --sys-prefix

for extension in \
    codefolding/main search-replace/main ;
    do jupyter nbextension enable $extension --sys-prefix --system ;
done



jupyter nbextension install --py --sys-prefix jpy_video --system
jupyter nbextension enable  --py --sys-prefix jpy_video --system

jupyter serverextension enable --py jupyterlab --sys-prefix
jupyter labextension install @jupyterlab/git
jupyter labextension install @jupyterlab/google-drive
#jupyter labextension install jupyterlab-spreadsheet
jupyter labextension install holmantai/xyz-extension
jupyter labextension install jupyterlab_tensorboard
jupyter labextension install jupyterlab_bokeh
jupyter labextension enable jupyterlab_bokeh
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install jupyter-matplotlib
jupyter labextension install jupyter-widgets
jupyter labextension install jupyterlab_voyager
jupyter labextension install jupyterlab_templates
jupyter labextension install ipysheet
jupyter labextension install qgrid
jupyter labextension install @jupyterlab/toc
jupyter labextension install @jupyterlab/latex
jupyter labextension install jupyterlab-kernelspy
jupyter labextension install @ijmbarr/jupyterlab_spellchecker
jupyter labextension install @jupyterlab/hub-extension
jupyter labextension install @mflevine/jupyterlab_html
jupyter labextension install @pyviz/jupyterlab_holoviews
jupyter labextension install @jupyterlab/fasta-extension
jupyter labextension install @jupyterlab/geojson-extension
jupyter labextension install @jupyterlab/mathjax3-extension
jupyter labextension install @jupyterlab/katex-extension
jupyter labextension install @jupyterlab/plotly-extension
jupyter labextension install @jupyterlab/vega2-extension
jupyter labextension install @jupyterlab/vega3-extension
jupyter labextension install @jupyterlab/celltags
jupyter labextension install @candela/jupyterlab
jupyter labextension install jupyterlab-drawio
jupyter labextension install pylantern
jupyter labextension install jupyter-leaflet
jupyter labextension install bqplot
jupyter labextension install @lckr/jupyterlab_variableinspector
jupyter labextension install @oriolmirosa/jupyterlab_materialdarker
jupyter labextension install jupyterlab_iframe
jupyter labextension install jupyterlab-spreadsheet
jupyter labextension install jupyterlab-python-file
jupyter labextension install jupyter-video
jupyter labextension install jupyterlab_filetree
jupyter labextension install @agoose77/jupyterlab-attachments
jupyter labextension install @enlznep/jupyterlab_shell_file
jupyter labextension install jupyterlab-jupytext

#jupyter nbextension disable --py --sys-prefix ipysheet.renderer_nbext
#jupyter labextension disable ipysheet:renderer # for jupyter lab
jupyter serverextension enable --py jupyterlab_templates
jupyter serverextension enable --py jupyterlab_iframe

jupyter lab build

mkdir -p /home/$ME/.local/share/jupyter/kernels
cp -r /root/.local/share/jupyter/kernels/* /home/$ME/.local/share/jupyter/kernels
chown $ME:$ME -R /home/$ME/.local/share/jupyter

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
