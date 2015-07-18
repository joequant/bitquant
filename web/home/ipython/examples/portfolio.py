
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

prices = {
    "3888.HK": 22.6
}

marklines = [
    250000,374920.00
]

def scale (prices, x):
    return { k : prices[k]*x for k in prices.keys()}

def merge_dicts(x, y):
    '''Given two dicts, merge them into a new dict as a shallow copy.'''
    z = x.copy()
    z.update(y)
    return z

def portfolio_nav(portfolio_list, prices):
    retval = 0.0
    for portfolio in portfolio_list:
        for asset in portfolio:
            if asset[1] == "cash":
                retval = retval +asset[0]
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
    return retval


# In[ ]:

[portfolio_nav([portfolio,trade], {"3888.HK":28}), scale(prices, 0.5)]


# In[ ]:

get_ipython().magic('matplotlib inline')

def plot_one_asset(asset, xrange, portfolio_list, prices):
    import matplotlib.pyplot as plt  
    import numpy as np
    x = np.arange(*xrange)
    for i in range(1,len(portfolio_list)+1):
        y = np.vectorize(lambda x: portfolio_nav(portfolio_list[:i], merge_dicts(prices, {asset:x})))(x)
        plt.plot(x,y)
    for i in marklines:
        plt.axhline(y=i, xmin=0.0, xmax=1.0, ls='dashed' )
    plt.axvline(x=prices[asset],ymin=0.0,ymax=1.0,ls='dashed' )
    plt.grid(b=True, which='major', color='0.8', linestyle='--')

plot_one_asset("3888.HK",[10,35,0.1], [portfolio, trade], prices)


# In[ ]:

def plot_scaled(portfolio_list, prices):
    import matplotlib.pyplot as plt  
    import numpy as np
    x = np.arange(0,1.5,0.05)
    for i in range(1,len(portfolio_list)+1):
        y = np.vectorize(lambda x: portfolio_nav(portfolio_list[:i], scale(prices,x)))(x)
        plt.plot(x,y)
    for i in marklines:
        plt.axhline(y=i, xmin=0.0, xmax=1.0, ls='dashed' )
    plt.grid(b=True, which='major', color='0.8', linestyle='--')

plot_scaled([portfolio, trade], prices)


# In[ ]:



