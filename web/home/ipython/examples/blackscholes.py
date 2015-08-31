
# coding: utf-8

# In[ ]:

# adapted from https://github.com/jmiedwards/Python---Black-Scholes-Pricing-calculator-

from scipy import stats
import math

def date_fraction(start, to):
    import calendar
    from datetime import datetime
    (year, month) = to.split("-")
    (weekday, lastday) = calendar.monthrange(int(year), int(month))
    return abs((datetime(int(year), int(month), lastday)-datetime.strptime(start, "%Y-%m-%d")).days) / 365.0

def black_scholes (cp, s, k, t, v, rf, div):
        """ Price an option using the Black-Scholes model.
        s: initial stock price
        k: strike price
        t: expiration time
        v: volatility
        rf: risk-free rate
        div: dividend
        cp: +1/-1 for call/put
        """
        if (s <= 0.0):
            s = 0.0
        if (t == 0.0 or v==0.0 or s==0):
            return max(0.0, cp * (s-k))

        d1  = (math.log(s/k)+(rf-div+0.5*math.pow(v,2))*t)/(v*math.sqrt(t))
        d2 = d1 - v*math.sqrt(t)

        optprice = (cp*s*math.exp(-div*t)*stats.norm.cdf(cp*d1)) - (cp*k*math.exp(-rf*t)*stats.norm.cdf(cp*d2))
        return optprice

if __name__ == "__main__":
    print(date_fraction("2015-07-02", "2015-09"))


# In[ ]:



