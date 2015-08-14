
# coding: utf-8

# 
# Portfolio payoff routines
# 
# These routines take a portfolio of call and put options and plots the payoff functions.

# In[ ]:

def date_fraction(start, to):
    import calendar
    from datetime import datetime
    (year, month) = to.split("-")
    (weekday, lastday) = calendar.monthrange(int(year), int(month))
    return abs((datetime(int(year), int(month), lastday)-datetime.strptime(start, "%Y-%m-%d")).days)

if __name__ == "__main__":
    print(date_fraction("2015-07-02", "2015-09"))


# In[ ]:

get_ipython().magic('matplotlib inline')
import toyplot
import numpy as np
from blackscholes import black_scholes

def get_beta(beta, x):
    if x in beta:
        return beta[x]
    else:
        return 1.0

def scale (prices, x, beta={}):
    return { k : prices[k]*((x-1.0)*get_beta(beta,k)+1.0)  for k in prices.keys()}

def merge_dicts(x, y):
    '''Given two dicts, merge them into a new dict as a shallow copy.'''
    z = x.copy()
    z.update(y)
    return z

class PortfolioCalculator(object):
    def __init__(self, **kwargs):
            pass
    def portfolio_nav(self, portfolio_list, prices, mtm=False, 
                      date=None, r=None,  vols=None):
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
                    expiry = asset[2]
                    strike = asset[3]
                    underlying = asset[4]
                    purchase = asset[5]
                    value = 0.0
                    if not mtm:
                        if asset[1] == "put" and prices[underlying] < strike:
                            value = strike - prices[underlying]
                        if asset[1] == "call" and prices[underlying] > strike:
                            value = prices[underlying] - strike
                    else:
                        t = date_fraction(date, expiry) / 365.0
                        if (t < 0.0):
                            t = 0.0
                        price = prices[underlying]
                        vol = vols[underlying]
                        value = black_scholes ((-1 if style == "put" else 1), price,                                              strike, t, vol, r, 0.0)
                    retval = retval + quantity * (value - purchase)             
                elif asset[1] == "comment":
                    pass
                else:
                    raise Exception ("unknown asset")
        return retval
    def plot_one_asset(self, asset, xrange, portfolio_list, prices,marklines=[], *args):
        x = np.linspace(*xrange[0:2])
        canvas = toyplot.Canvas(width=400, height=400)
        axes = canvas.axes( )
        for i in range(1,len(portfolio_list)+1):
            y = np.vectorize(lambda x: self.portfolio_nav(portfolio_list[:i], merge_dicts(prices, {asset:x}), *args))(x)
            axes.plot(x,y)
        axes.hlines(marklines )
        axes.vlines([prices[asset]] )
    def plot_scaled(self, portfolio_list, prices,marklines=[], beta={}, *args):
        x = np.linspace(0.01,1.5)
        canvas = toyplot.Canvas(width=400, height=400)
        axes = canvas.axes()        
        for i in range(1,len(portfolio_list)+1):
            y = np.vectorize(lambda x: self.portfolio_nav(portfolio_list[:i], scale(prices,x,beta, *args)))(x)
            axes.plot(x,y)
        for i in marklines:
            axes.hlines(marklines )


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
        [10000, "spot", '3888.HK', 25.00]
    ]
    prices = {
        "3888.HK": 22.6
    }
    
    vols = {
        "3888.HK":0.8
    }

    marklines = [
        250000,374920.00
    ]
    
    port_calc = PortfolioCalculator()
    [port_calc.portfolio_nav([portfolio, trade, exercise],{"3888.HK":28} ), scale(prices, 0.5)]
    port_calc.plot_one_asset("3888.HK",[10,35,0.1],[portfolio, trade, exercise], prices, marklines)


# In[ ]:

if __name__ == '__main__':
    port_calc.plot_one_asset("3888.HK", [10,35,0.1], [portfolio], prices, marklines, True, "2015-07-15", 0.0, vols)


# In[ ]:

if __name__ == '__main__':
    port_calc.plot_scaled([portfolio, trade, exercise], prices, marklines)


# In[ ]:



