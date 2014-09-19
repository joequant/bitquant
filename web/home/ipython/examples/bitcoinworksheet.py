# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

%matplotlib inline
from BitcoinAverager import TimeUtil, BitcoinAverager, PriceCompositor, Forex, BitcoinDataLoader

# <codecell>

import datetime
import time
import pytz
from dateutil.relativedelta import relativedelta
hkg_time = pytz.timezone("Asia/Hong_Kong")
start = hkg_time.localize(datetime.datetime(2014,2,1,6,0,0))
period = relativedelta(days=1)
intervals = 30

TimeUtil.time_table(start, period, intervals)

# <codecell>

averagers = {}
exchanges = ["anxhkHKD", "bitfinexUSD", "bitstampUSD", "btceUSD", "itbitEUR", "itbitSGD", "itbitUSD", \
             "krakenEUR", "krakenUSD", "okcoinCNY", "btcnCNY"]

for e in exchanges:
    averagers[e] = BitcoinAverager(e)

averager = averagers["bitfinexUSD"]

# <codecell>

averager.index_range()

# <codecell>

from datetime import datetime
from dateutil.relativedelta import relativedelta
import pytz
hkg_time = pytz.timezone("Asia/Hong_Kong")
start_time = hkg_time.localize(datetime(2014,2,1,6,0,0))
end_time = start_time + relativedelta(days=1)
start_epoch = TimeUtil.unix_epoch(start_time)
end_epoch = TimeUtil.unix_epoch(end_time)
selected = averager.select(start_epoch, end_epoch)
len(selected)

# <codecell>

from datetime import datetime
from dateutil.relativedelta import relativedelta
import pytz
hkg_time = pytz.timezone("Asia/Hong_Kong")
start_time = hkg_time.localize(datetime(2014,2,1,6,0,0))
end_time = start_time + relativedelta(minute=15)
start_epoch = TimeUtil.unix_epoch(start_time)
end_epoch = TimeUtil.unix_epoch(end_time)
selected = averager.select(start_epoch, end_epoch)
selected

# <codecell>

selected = averager.intervals(start_time, relativedelta(minutes=1),50 )
selected

# <codecell>

%matplotlib inline

# <codecell>

selected.plot(y='price')

# <codecell>

selected.plot(y="volume")

# <codecell>

import datetime
import time
import pytz
from dateutil.relativedelta import relativedelta
hkg_time = pytz.timezone("Asia/Hong_Kong")
start = hkg_time.localize(datetime.datetime(2014,2,1,6,0,0))
period = relativedelta(days=1)
intervals = 30

forex_list = ["GBPUSD"]
forex_table = {}
compositor = PriceCompositor()
avg = compositor.exchange_table(start, period, intervals)

for f in forex_list:
    forex = Forex(f)
    forex_table[f] = forex.rates(map(TimeUtil.unix_epoch, avg.index), avg.index)
    forex_table[f].rename(columns={"rates" : f}, inplace=True)

avg = avg.join(forex_table[f] for f in forex_list)

# <codecell>

forex_table["GBPUSD"]

# <codecell>

f=Forex("USDUSD")
f.rates(map(TimeUtil.unix_epoch, avg.index), avg.index)

# <codecell>

import datetime
import time
import pytz
from dateutil.relativedelta import relativedelta
hkg_time = pytz.timezone("Asia/Hong_Kong")
start_date = hkg_time.localize(datetime.datetime(2014,2,1,7,0,0))
period = relativedelta(minutes=5)
intervals = 200

forex_table = {}
compositor = PriceCompositor()
avg = compositor.exchange_table(start_date, period, intervals)

for f in forex_list:
    forex = Forex(f)
    forex_table[f] = forex.rates(map(TimeUtil.unix_epoch, avg.index), avg.index)
    forex_table[f].rename(columns={"rates" : f}, inplace=True)

avg = avg.join(forex_table[f] for f in forex_list)   
avg[['bitfinexUSD_price', 'bitstampUSD_price']]

# <codecell>

avg[['GBPUSD']]

# <codecell>

import datetime
import time
import pytz
from dateutil.relativedelta import relativedelta
hkg_time = pytz.timezone("Asia/Hong_Kong")
start_date = hkg_time.localize(datetime.datetime(2014,2,1,7,0,0))
period = relativedelta(hours=1)
intervals = 200

compositor = PriceCompositor()
compositor.currency_table(start_date, period, intervals)

# <codecell>

import datetime
import time
import pytz
from dateutil.relativedelta import relativedelta

hkg_time = pytz.timezone("Asia/Hong_Kong")
start_date = hkg_time.localize(datetime.datetime(2014,2,1,7,0,0))
period = relativedelta(hours=1)
intervals = 200

compositor = PriceCompositor()
composite = compositor.composite_table(start_date, period, intervals)
composite

# <codecell>

composite[["price"]].plot()

# <codecell>

import datetime
import time
import pytz
from dateutil.relativedelta import relativedelta
hkg_time = pytz.timezone("Asia/Hong_Kong")
start_date = hkg_time.localize(datetime.datetime(2014,2,1,7,0,0))
period = relativedelta(hours=1)
intervals = 200

compositor = PriceCompositor()
compositor.generate(start_date, period, intervals)

# <codecell>

c = compositor.generate(start_date, period, intervals, converted_prices=True,currency=True)
c

# <codecell>

import matplotlib.pyplot as plt

plt.figure(figsize=(10, 10))
ax1 = plt.subplot2grid((8,1), (0,0), rowspan=7)
ax2 = plt.subplot2grid((8,1), (7,0))
ax1.xaxis.set_ticklabels([])
c[['price', 'GBPUSD_price', 'GBPEUR_price']].plot(ax=ax1)
c[['volume', 'USD_volume', 'EUR_volume']].plot(ax=ax2)

# <codecell>

import datetime
import time
import pytz
from dateutil.relativedelta import relativedelta
hkg_time = pytz.timezone("Asia/Hong_Kong")
start_date = hkg_time.localize(datetime.datetime(2014,2,1,7,0,0))
period = relativedelta(hours=1)
intervals = 200

compositor = PriceCompositor(base_currency="USD")
composite = compositor.generate(start_date, period, intervals)

# <codecell>

composite[["price"]].plot()

# <codecell>

compositor.reload()

# <codecell>

f = BitcoinDataLoader()

# <codecell>

f.filedata()

# <codecell>


