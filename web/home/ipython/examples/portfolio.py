
# coding: utf-8

# In[ ]:

get_ipython().magic('matplotlib inline')
import toyplot
import numpy as np
from blackscholes import black_scholes, date_fraction
import scipy

def get_beta(beta, x):
    if x in beta:
        return beta[x]
    else:
        return 1.0

def scale (prices, x, beta={}):
    return { k : prices[k]*((x-1.0)*get_beta(beta,k)+1.0)  for k in prices.keys()}

def merge(x, y):
    '''Given two dicts, merge them into a new dict as a shallow copy.'''
    z = x.copy()
    z.update(y)
    return z

def plot_function(xrange, ylist,  hlines=[], vlines=[]):
        x = np.linspace(*xrange)
        canvas = toyplot.Canvas(width=400, height=400)
        axes = canvas.axes( )
        for y in ylist:
            axes.plot(x, np.vectorize(y)(x))
        axes.hlines(hlines )
        axes.vlines(vlines)

class Portfolio(object):
    def __init__(self, portfolio, prices={}, vols={},  beta={}, **kwargs):
            self.portfolio = portfolio
            self.prices = prices
            self.vols = vols
            self.beta=beta
    def portfolio_nav(self,  prices = None, mtm=False,  date=None, dt = 0.0, r=None):
        return sum(self.portfolio_items(prices, mtm, date, dt, r), 0.0)
    def portfolio_items(self,  prices = None, mtm=False,  date=None, dt = 0.0, r=None):
        retval = []
        if prices == None:
            prices = self.prices
        for asset in self.portfolio:
            if asset[1] == "cash":
                retval.append(asset[0])
            elif asset[1] == "spot":
                quantity = asset[0]
                underlying = asset[2]
                purchase = asset[3]
                if  purchase < 0.0:
                    raise ValueError
                retval.append(quantity * prices[underlying])
            elif asset[1] == "put" or asset[1] == "call":
                quantity = asset[0]
                style = asset[1]
                expiry = asset[2]
                strike = asset[3]
                underlying = asset[4]
                purchase = asset[5]
                price = prices[underlying]
                value = 0.0
                if strike < 0.0 or purchase < 0.0:
                    raise ValueError
                if not mtm:
                    if asset[1] == "put" and price < strike:
                        value = strike - price
                    if asset[1] == "call" and price > strike:
                        value = price - strike
                else:
                    t = (date_fraction(date, expiry) -dt/365.0) 
                    if (t < 0.0):
                        t = 0.0
                    vol = self.vols[underlying]
                    if (price < 0.0):
                        price = 0.0
                    value = black_scholes ((-1 if style == "put" else 1), price,                                              strike, t, vol, r, 0.0)
                retval.append(quantity * value )             
            elif asset[1] == "comment":
                pass
            else:
                    raise Exception ("unknown asset")
        return retval
    def asset_dep(self, asset, *args, **kwargs):
        return  lambda x: self.portfolio_nav(prices=merge(self.prices, {asset:x}), *args, **kwargs)
    def delta_dep(self, asset, *args, **kwargs):
        return  lambda x: scipy.misc.derivative(self.asset_dep(asset, *args, **kwargs), x)
    def market_dep(self, *args, **kwargs):
        return lambda x: self.portfolio_nav(prices=scale(self.prices, x, self.beta), *args, **kwargs)
    def evolve(self, date, *args, **kwargs):
        return  lambda t: self.portfolio_nav(dt=t, date=date, mtm=True, *args, **kwargs)


# 
# Portfolio payoff routines
# 
# These routines take a portfolio of call and put options and plots the payoff functions.

# In[ ]:

if __name__ == '__main__':
    get_ipython().magic('matplotlib inline')
    portfolio = [
        [-10000, "put", "2015-09", 24.00, "3888.HK", 1.0],
        [-10000, "put", "2015-07", 25.00, "3888.HK", 0.55],
        [-10000, "put", "2015-07", 26.00, "3888.HK", 0.63],
        [-10000, "put", "2015-08", 26.00, "3888.HK", 1.06],
        [-5000, "call", "2015-08", 26.00, "3888.HK", 1.06],
        [-5000, "call", "2015-08", 27.00, "3888.HK", 0.88],
        [975928.19, "cash"]
    ]

    trade = [
        [-10000, "put","2015-08", 18.50, "3888.HK", 1.05]
    ]

    exercise = [
        [10000, "put", "2015-08", 25.00, "3888.HK", 0.0],
        [-250000, "cash"],
        [10000, "spot", '3888.HK', 25.00]
    ]
    prices = {
        "3888.HK": 22.6
    }
    
    vols = {
        "3888.HK":0.8
    }
    
    beta = {
        "3888.HK":3
    }

    portfolio_list = [portfolio, trade, exercise]
    functions = []
    for i in range(1,4):
        p = Portfolio(sum(portfolio_list[:i],[]), prices=prices, vols=vols, beta=beta)
        functions.append(p.asset_dep("3888.HK"))
    plot_function([10,35], functions)


# In[ ]:

if __name__ == '__main__':
    p = Portfolio(portfolio, prices=prices, vols=vols, beta=beta)
    plot_function([10,35], [p.asset_dep("3888.HK"), p.asset_dep("3888.HK", mtm=True, date="2015-07-15", r=0)])


# In[ ]:

if __name__ == '__main__':
    portfolio_list = [portfolio, trade, exercise]
    functions = []
    for i in range(1,4):
        p = Portfolio(sum(portfolio_list[:i],[]), prices=prices, vols=vols, beta=beta)
        functions.append(p.market_dep())
    plot_function([0.25,1.5], functions)


# In[ ]:

if __name__ == '__main__':
    portfolio_list = [portfolio, trade, exercise]
    functions = []
    for i in range(1,4):
        p = Portfolio(sum(portfolio_list[:i],[]), prices=prices, vols=vols, beta=beta)
        functions.append(p.evolve(date="2015-07-15", r=0))
    plot_function([0,90], functions)


# In[ ]:




# In[ ]:



