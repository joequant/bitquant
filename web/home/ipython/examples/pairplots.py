
# coding: utf-8

# Read in stock data
# ----

# In[ ]:

get_ipython().magic('matplotlib inline')
from pandas import *
import pandas_datareader.data as web 
import scipy
def get_data(stock, start):
    stock  = web.DataReader(stock, 'yahoo', start)
    stock['Daily Ret'] = scipy.log(stock['Close']/stock['Close'].shift(1))
    stock['Weekly Ret'] = scipy.log(stock['Close']/stock['Close'].shift(5))
    stock['Monthly Ret'] = scipy.log(stock['Close']/stock['Close'].shift(30))
    return stock

stock_list = ['3888.HK', '0027.HK', '0267.HK','0388.HK', '0700.HK', '1211.HK', '2800.HK', '2823.HK',  '2600.HK',  '0005.HK', '6030.HK', '^HSI', '000001.SS']

stock = {}
for i in stock_list:
    stock[i] = get_data(i, '01/01/2010')

ret = {}
close_dict = {}

for i in stock_list:
    ret[i] = stock[i]['Daily Ret']
    close_dict[i] = stock[i]['Close']
#    ret["prev." + i ] = stock[i]['Daily Ret'].shift(1)

df = DataFrame(ret)
close = DataFrame(close_dict)    
#get_data('GEINX.HK', '01/01/2010')


# Plot time dependence

# In[ ]:

# 3. Plotting 
get_ipython().magic('matplotlib inline')
import matplotlib.pyplot as plt

def plot(stock_id):
    plt.subplot(211)
    stock[stock_id]['Close'].plot()
    plt.ylabel('Index Level')

    plt.subplot(212)
    stock[stock_id]['Daily Ret'].plot()
    plt.ylabel('Log Returns')
    
plot('3888.HK')


# Do unit root test - Test for stationarity

# In[ ]:

import statsmodels.tsa.stattools as ts
ts.adfuller(stock['3888.HK']['Close'].loc['20150101':], 1)


# Calculate hurst exponent - Mean reverting or momentum following

# In[ ]:

from numpy import cumsum, log, polyfit, sqrt, std, subtract
from numpy.random import randn

def hurst(ts, lag=100):
	"""Returns the Hurst Exponent of the time series vector ts"""
	# Create the range of lag values
	lags = range(2, lag)

	# Calculate the array of the variances of the lagged differences
	tau = [sqrt(std(subtract(ts[lag:], ts[:-lag]))) for lag in lags]

	# Use a linear fit to estimate the Hurst Exponent
	poly = polyfit(log(lags), log(tau), 1)

	# Return the Hurst exponent from the polyfit output
	return poly[0]*2.0

for i in stock_list:
    print ("Hurst(%s):  %s" % (i, hurst(stock[i].loc['20150801':]['Close'], 10)))


# Calculate distribution of daily returns.  Check for crashes

# In[ ]:

import numpy as np
import pandas as pd
from scipy import stats, integrate
import matplotlib.pyplot as plt
import seaborn as sns
sns.set(color_codes=True)
sns.distplot(stock['0027.HK']['Daily Ret'].loc['20150601':], hist=False, rug=True, label="After June")
sns.distplot(stock['0027.HK']['Daily Ret'].loc['20150101':], hist=False, rug=True, label="2015")
sns.distplot(stock['0027.HK']['Daily Ret'].loc['20140101':'20141231'], hist=False, rug=True, label="2014")
sns.distplot(stock['0027.HK']['Daily Ret'].loc['20130101':'20131231'], hist=False, rug=True, label="2013")


# Look at weekly returns

# In[ ]:

import numpy as np
import pandas as pd
from scipy import stats, integrate
import matplotlib.pyplot as plt
import seaborn as sns
sns.set(color_codes=True)
sns.distplot(stock['^HSI']['Weekly Ret'].loc['20150601':], hist=False, rug=True, label="After June")


# Calculate culmative returns
# ----

# In[ ]:

import numpy as np
import pandas as pd
get_ipython().magic('matplotlib inline')
from scipy import stats, integrate
import matplotlib.pyplot as plt
import seaborn as sns
sns.set(color_codes=True)
sns.kdeplot(stock['^HSI']['Daily Ret'].loc['20150701':'20150801'], label="July", cumulative=True)
sns.kdeplot(stock['^HSI']['Daily Ret'].loc['20150801':], label="After August", cumulative=True)
sns.kdeplot(stock['^HSI']['Daily Ret'].loc['20150101':], label="2015", cumulative=True)


# Calculate daily returns distribution
# ----

# In[ ]:

import numpy as np
import pandas as pd
from scipy import stats, integrate
import matplotlib.pyplot as plt
import seaborn as sns
sns.set(color_codes=True)
sns.distplot(stock['3888.HK']['Daily Ret'], hist=False, rug=True)
sns.distplot(stock['^HSI']['Daily Ret'], hist=False, rug=True)


# In[ ]:

sns.distplot(stock['3888.HK']['Close'], hist=False, rug=True)


# Weekly returns versus monthly return
# ----

# In[ ]:

sns.regplot(x=stock['3888.HK']['Weekly Ret'],y=stock['3888.HK']['Monthly Ret'])


# Heatmap correlations
# -----

# In[ ]:

import seaborn as sns
sl = slice('20140101', '20141231')
sns.heatmap(df[sl].corr())


# Raw plot between stock prices
# ----

# In[ ]:

import seaborn as sns
sl = slice('20140101', None)
sns.pairplot(close[sl].dropna(),vars=['0027.HK', '0388.HK','3888.HK', '^HSI'])


# Correlate stocks
# ------

# In[ ]:

import seaborn as sns
sl = slice('20150701', '20150801')
sns.pairplot(df[sl].dropna(),vars=['0027.HK', '2823.HK','3888.HK', '^HSI'])


# In[ ]:

sns.pairplot(df['20150701':].dropna())


# Linear regressions
# -----

# In[ ]:

import scipy
import scipy.stats
sl = slice('20150701','20151001')
import statsmodels.api as sm
X = df[sl].dropna()['^HSI'].tolist()
X = sm.tools.add_constant(X)
for i in stock_list:
    results = sm.OLS(df[sl].dropna()[i].tolist(), X).fit()
    print(i, results.params[1], results.params[0], results.rsquared)


# In[ ]:

import scipy
import scipy.stats
sl = slice('20150701','20150801')
import statsmodels.api as sm
X = df[sl].dropna()['^HSI'].tolist()
X = sm.tools.add_constant(X)
for i in stock_list:
    results = sm.OLS(df[sl].dropna()[i].tolist(), X).fit()
    print(i, results.params[1], results.params[0], results.rsquared)


# In[ ]:



