# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

from BitcoinAverager import TimeUtil, BitcoinAverager, PriceCompositor, Forex, BitcoinDataLoader

# <codecell>

all_exchanges = ['bitfinexUSD','bitstampUSD','itbitUSD',
                 'itbitEUR','krakenEUR','itbitSGD','anxhkHKD',
                 'okcoinCNY', 'btcnCNY']
compositor = PriceCompositor(all_exchanges)
compositor.reload()

# <codecell>

from datetime import datetime
from dateutil.relativedelta import relativedelta
import pytz
hkg_time = pytz.timezone("Asia/Hong_Kong")
start_time = hkg_time.localize(datetime(2015,1,1,6,0,0))
period = relativedelta(minutes=1)
intervals = 60 * 24*90
compositor = PriceCompositor(['bitfinexUSD'], base_currency='USD')
data = compositor.composite_table(start_time, period, intervals)
data

# <codecell>

averagers = {}
exchanges = ["anxhkHKD", "bitfinexUSD", "bitstampUSD", "btceUSD", "itbitEUR", "itbitSGD", "itbitUSD", \
             "krakenEUR", "krakenUSD", "okcoinCNY", "btcnCNY"]

for e in exchanges:
    averagers[e] = BitcoinAverager(e)

averager = averagers["bitfinexUSD"]

# <codecell>

data['price'].tolist()

# <codecell>

from scipy import signal
import matplotlib.pyplot as plt
sig  = data['price'].tolist()
widths = pow(2,np.arange(0, 18, 0.5))
cwtmatr = signal.cwt(sig, signal.ricker, widths)
imgplot = plt.imshow(cwtmatr, aspect='auto')
imgplot

# <codecell>

pow(2,np.arange(0, 16, 0.5))

# <codecell>

from scipy import signal
import matplotlib.pyplot as plt
sig  = data['volume'].tolist()
widths = pow(2,np.arange(0, 18, 0.5))
cwtmatr = signal.cwt(sig, signal.ricker, widths)
imgplot = plt.imshow(cwtmatr, aspect='auto')
imgplot

# <codecell>


