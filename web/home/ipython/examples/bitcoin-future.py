# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

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
    settlementDate = todaysDate + Period(t, Days)
    riskFreeRate = FlatForward(todaysDate, 0.00, ContinuousTime.perDay())

    # option parameters
    exercise = EuropeanExercise(settlementDate)
    payoff = CryptoPayoffQuanto()
    x = np.arange(strike*0.8, strike*1.2, 0.01);

    volatility = BlackConstantVol(todaysDate, TARGET(), vol, ContinuousTime.perDay())
    dividendYield = FlatForward(settlementDate, 0.00, ContinuousTime.perDay())
    underlying = SimpleQuote(strike)
    process = BlackScholesMertonProcess(QuoteHandle(underlying),
                                    YieldTermStructureHandle(dividendYield),
                                    YieldTermStructureHandle(riskFreeRate),
                                    BlackVolTermStructureHandle(volatility))
    option = CryptoCurrencyFuture(settlementDate, payoff)
    option.setPricingEngine(FDEuropeanEngine(process))
    option.recalculate()
    priceCurve = option.priceCurve()
    grid = priceCurve.grid()
    values = priceCurve.values()
    plt.figure(1, figsize=(10,8))
    plt.subplot(221)
    y = list(map(payoff, grid))
    plt.plot(grid, y)
    plt.plot(grid, list(values))
    plt.subplot(222)
    delta_grid = priceCurve.derivative()
    plt.plot(delta_grid.grid(), list(delta_grid.values()))
    gamma_grid = delta_grid.derivative()
    plt.subplot(223)
    plt.plot(gamma_grid.grid(), list(gamma_grid.values()))
    plt.subplot(224)
    thetaCurve = option.thetaCurve()
    plt.plot(thetaCurve.grid(), list(thetaCurve.values()))
#    plt.plot(x, list(map(mydelta,x)))

# <codecell>

option(350, 0.02, 90, 1)

# <codecell>

np.arange(0.8, 1.2,0.1)

# <codecell>


