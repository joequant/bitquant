
# coding: utf-8

# Gearing
# ----------
# This notebook defines a function for long options

# In[ ]:

from portfolio import plot_function
from blackscholes import black_scholes, date_fraction
from numpy import interp

class GearingPlot(object):
    """This object plots various quantities having to do with long options"""
    def __init__(self, style, price, t, vol, r=0.0, d=0.0):
        self.style = style
        self.price = price
        self.t = t
        self.vol = vol
        self.r = r
        self.d = d
    """Calculate number of options that can be bought for unit price"""
    def leverage(self, strike):
        return 1.0 / black_scholes ((-1 if self.style == "put" else 1), 
                    self.price,
                    strike, 
                    self.t/365.0, 
                    self.vol,
                    self.r, 
                    self.d)
    def plot_leverage(self, xrange):
        plot_function(xrange, [lambda strike: self.leverage(strike)])
    def gearing(self, strike):
        """Calculate return dependence for given strike"""
        options = self.leverage(strike)
        return (lambda price_new, dt : options * black_scholes ((-1 if self.style == "put" else 1), price_new,                                                      strike, ((self.t-dt)/365.0), self.vol,  self.r, self.d))
    def plot_gearing(self, xrange, strikes, dt=0.0):
        """Plot the gearing curve"""
        plot_function(xrange,
                  map(lambda strike: lambda x: (self.gearing(strike)(x,dt)), strikes),
                 yrange=[0,5])
    def plot_evolve(self, dtrange, strikes, xpoints, ypoints):
        """Plot evolution"""
        f = lambda x: interp(x, xpoints, ypoints)
        plot_function(dtrange,
                      map(lambda strike: lambda dt: self.gearing(strike)(f(dt),dt),strikes),
                     yrange=[0,5])


# In[ ]:

if __name__ == '__main__':
    g = GearingPlot("put", 162.0, 15, 0.3)
    g.plot_leverage([140.0, 170.0])


# In[ ]:

if __name__ == '__main__':
    g= GearingPlot("put", 15.0, 15, 0.3)
    g.plot_gearing([12.0, 20.0], [14.0, 15.0, 18.0], dt=7)


# In[ ]:

if __name__ == '__main__':
    g.plot_evolve([0,15], [14,15,18], [0,3],[15,14])


# In[ ]:




# In[ ]:



