
# coding: utf-8

# 
# Portfolio payoff routines
# 
# These routines take a portfolio of call and put options and plots the payoff functions.

# In[ ]:

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
    [10000, "spot", '3888.HK', 25.00]
]

prices = {
    "3888.HK": 22.6
}

marklines = [
    250000,374920.00
]

get_ipython().magic('matplotlib inline')

import matplotlib.pyplot as plt  
import numpy as np

def scale (prices, x):
    return { k : prices[k]*x for k in prices.keys()}

def merge_dicts(x, y):
    '''Given two dicts, merge them into a new dict as a shallow copy.'''
    z = x.copy()
    z.update(y)
    return z

class PortfolioCalculator(object):
    def __init__(self, **kwargs):
            pass
    def portfolio_nav(self, portfolio_list, prices):
        retval = 0.0
        if portfolio_list == None:
            portfolio_list = self.portfolio_list
        for portfolio in portfolio_list:
            for asset in portfolio:
                if asset[1] == "cash":
                    retval = retval +asset[0]
                elif asset[1] == "spot":
                    quantity = asset[0]
                    underlying = asset[2]
                    purchase = asset[3]
                    retval = retval + quantity * (prices[underlying] - purchase)
                elif asset[1] == "put" or asset[1] == "call":
                    quantity = asset[0]
                    style = asset[1]
                    date = asset[2]
                    strike = asset[3]
                    underlying = asset[4]
                    purchase = asset[5]
                    exercise_value = 0.0
                    if asset[1] == "put" and prices[underlying] < strike:
                        exercise_value = strike - prices[underlying]
                    if asset[1] == "call" and prices[underlying] > strike:
                        exercise_value = prices[underlying] - strike
                    retval = retval + quantity * (exercise_value - purchase)
                elif asset[1] == "comment":
                    pass
                else:
                    raise Exception ("unknown asset")
        return retval
    def plot_one_asset(self, asset, xrange, portfolio_list, prices):
        x = np.arange(*xrange)
        for i in range(1,len(portfolio_list)+1):
            y = np.vectorize(lambda x: self.portfolio_nav(portfolio_list[:i], merge_dicts(prices, {asset:x})))(x)
            plt.plot(x,y)
        for i in marklines:
            plt.axhline(y=i, xmin=0.0, xmax=1.0, ls='dashed' )
        plt.axvline(x=prices[asset],ymin=0.0,ymax=1.0,ls='dashed' )
        plt.grid(b=True, which='major', color='0.8', linestyle='--')
    def plot_scaled(self, portfolio_list, prices):
        x = np.arange(0,1.5,0.05)
        for i in range(1,len(portfolio_list)+1):
            y = np.vectorize(lambda x: self.portfolio_nav(portfolio_list[:i], scale(prices,x)))(x)
            plt.plot(x,y)
        for i in marklines:
            plt.axhline(y=i, xmin=0.0, xmax=1.0, ls='dashed' )
        plt.grid(b=True, which='major', color='0.8', linestyle='--')


# In[ ]:

port_calc = PortfolioCalculator()
[port_calc.portfolio_nav([portfolio, trade, exercise],{"3888.HK":28} ), scale(prices, 0.5)]


# In[ ]:

port_calc.plot_one_asset("3888.HK",[10,35,0.1],[portfolio, trade, exercise], prices)


# In[ ]:

port_calc.plot_scaled([portfolio, trade, exercise], prices)

