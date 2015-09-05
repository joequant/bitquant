
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

def plot_function(xrange, ylist,  hlines=[], vlines=[], labels=[], yrange=None):
        x = np.linspace(*xrange)
        label_style = {"text-anchor":"start", "-toyplot-anchor-shift":"5px"}
        canvas = toyplot.Canvas(width=600, height=400)
        axes = canvas.axes( )
        ylast = []
        if yrange != None:
            [axes.y.domain.min, axes.y.domain.max] = yrange
        for y in ylist:
            yvec = np.vectorize(y)(x)
            axes.plot(x, yvec)
            ylast.append(yvec[-1])
        for l in zip(labels, ylast):
            axes.text(x[-1], l[1], l[0], style=label_style)
        axes.hlines(hlines )
        axes.vlines(vlines)

def plot_asset_dep(portfolios, asset, xrange, date, prices, yrange=None):
    labels = [ "payoff %d" % (x+1) for x in range(len(portfolios)) ] +         [ "MTM %d" % (x+1) for x in range(len(portfolios)) ]
    plot_function(xrange,
        [ x.asset_dep(asset, mtm=True, payoff_asset=asset, date=date) for x in portfolios] +
        [ x.asset_dep(asset, mtm=True, date=date) for x in portfolios],
            vlines=prices[asset], labels=labels, yrange=yrange)

def plot_delta(portfolios, asset, xrange, date, prices, yrange=None):
    labels = [ "payoff %d" % (x+1) for x in range(len(portfolios)) ] +         [ "MTM %d" % (x+1) for x in range(len(portfolios)) ]
    plot_function(xrange, [ p.delta_dep(asset) for p in portfolios] +
                          [ p.delta_dep(asset, mtm=True, date=date) for p in portfolios],
                  vlines=[prices[asset]], labels=labels, yrange=yrange)

def difference(a, b):
   return (lambda x: a(x) - b(x))

def trade_option(quantity, style, expiry, strike, underlying, price) :
    return [
        [ quantity, style, expiry, strike, underlying, price ],
        [ -quantity * price, "cash"]
    ]

def trade_spot(quantity, underlying, price) :
    return [
        [ quantity, "spot", underlying, price ],
        [ -quantity * price, "cash"]
    ]

class Portfolio(object):
    def __init__(self, portfolio, prices={}, vols={},  beta={}, r=0.0, **kwargs):
            self.portfolio = portfolio
            self.prices = prices
            self.vols = vols
            self.beta=beta
            self.r = r
    def portfolio_nav(self, prices = None, mtm=False, payoff_asset=None, date=None, dt = 0.0):
        return sum(self.portfolio_items(prices, mtm, payoff_asset, date, dt), 0.0)
    def portfolio_items(self,  prices = None, mtm=False, payoff_asset=None, date=None, dt = 0.0):
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
                if not mtm or underlying == payoff_asset:
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
                    value = black_scholes ((-1 if style == "put" else 1), price,                                              strike, t, vol, self.r, 0.0)
                retval.append(quantity * value )             
            elif asset[1] == "comment":
                pass
            else:
                raise Exception ("unknown asset")
        return retval
    def asset_dep(self, asset, *args, **kwargs):
        return  lambda x: self.portfolio_nav(prices=merge(self.prices, {asset:x}), *args, **kwargs)
    def delta_dep(self, asset, *args, **kwargs):
        return  lambda x: scipy.misc.derivative(self.asset_dep(asset, *args, **kwargs), x, dx=1e-6)
    def market_dep(self, *args, **kwargs):
        return lambda x: self.portfolio_nav(prices=scale(self.prices, x, self.beta), *args, **kwargs)
    def evolve(self, date, *args, **kwargs):
        return  lambda t: self.portfolio_nav(dt=t, date=date, mtm=True, *args, **kwargs)
    def theta_portfolio(self, *args, **kwargs):
        return  lambda t: scipy.misc.derivative(self.evolve(*args, **kwargs), t, dx=1e-6)


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

    today="2015-07-15"
    yrange = [200000,800000]
    portfolios = [ Portfolio(x, prices=prices, vols=vols, beta=beta, r=0.0) 
                  for x in [portfolio, portfolio + trade, portfolio + trade + exercise] ]


# In[ ]:

if __name__ == '__main__':
    plot_asset_dep(portfolios, '3888.HK', [10, 20], today, prices, yrange=yrange)


# In[ ]:

if __name__ == '__main__':
    plot_delta(portfolios, "3888.HK", [10,20], today, prices)


# In[ ]:

if __name__ == '__main__':
    plot_function([0,90], [p.evolve(date=today) for p in portfolios])


# In[ ]:

if __name__ == '__main__':
    plot_function([0,90], [p.theta_portfolio(date=today) for p in portfolios])

