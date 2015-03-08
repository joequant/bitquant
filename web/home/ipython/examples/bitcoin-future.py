# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

%matplotlib inline
from QuantLib import *

# <codecell>

todaysDate = Date.todaysDate()
Settings.instance().evaluationDate = todaysDate
settlementDate = todaysDate + Period(2, Days)
riskFreeRate = FlatForward(settlementDate, 0.00, Actual365Fixed())

payoff = CryptoPayoffQuanto()

# <codecell>

settlementDate
payoff(367.0)

# <codecell>

timestamp = Date.universalDateTime()
newtime = timestamp + Period(3, Years)
newtime.year()
dcc = ContinuousTime(Years)

# <codecell>

import numpy as np
import matplotlib.pyplot as plt

def option(strike, vol, t, putcall):
    now = Date.universalDateTime()
    Settings.instance().evaluationDate = now
    settlementDate = todaysDate + Period(3, Weeks)
    riskFreeRate = FlatForward(todaysDate, 0.00, ContinuousTime.perDay())

    # option parameters
    exercise = EuropeanExercise(settlementDate)
    payoff = CryptoPayoffQuanto()
    x = np.arange(strike*0.8, strike*1.2, 0.01);

    volatility = BlackConstantVol(todaysDate, TARGET(), vol, ContinuousTime.perDay())
    dividendYield = FlatForward(settlementDate, 0.00, ContinuousTime.perDay())
    underlying = SimpleQuote(0.0)
    process = BlackScholesMertonProcess(QuoteHandle(underlying),
                                    YieldTermStructureHandle(dividendYield),
                                    YieldTermStructureHandle(riskFreeRate),
                                    BlackVolTermStructureHandle(volatility))
    option = CryptoCurrencyFuture(settlementDate, payoff)
    # method: analytic
    option.setPricingEngine(FDEuropeanEngine(process))
    def myfunc(x):
        underlying.setValue(x)
        return option.NPV()
    def mydelta(x):
        underlying.setValue(x)
        return option.delta()
    def mytheta(x):
        underlying.setValue(x)
        return option.theta()
    plt.figure(1, figsize=(5,8))
    plt.subplot(211)
    y = list(map(payoff, x))
    plt.plot(x, y)
    plt.plot(x, list(map(myfunc,x)))
    plt.subplot(212)
    plt.plot(x, list(map(mydelta,x)))

# <codecell>

option(350, 0.02, 90, 1)

# <codecell>

np.arange(0.8, 1.2,0.1)

# <codecell>


