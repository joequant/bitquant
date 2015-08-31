
# coding: utf-8

# In[ ]:

# https://ep2013.europython.eu/media/conference/slides/fast-data-mining-with-pytables-and-pandas.pdf

#1. Data Gathering
from pylab import *
from pandas.io.data import *
stock  = DataReader('AAPL', 'yahoo', start='01/01/2014')


# In[ ]:

# 2. Data Analysis
from pandas import *
stock['Ret'] = log(stock['Close']/stock['Close'].shift(1))
stock


# In[ ]:

# 3. Plotting 
get_ipython().magic('matplotlib inline')
from matplotlib import *

subplot(211)
stock['Close'].plot()
ylabel('Index Level')

subplot(212)
stock['Ret'].plot()
ylabel('Log Returns')


# In[ ]:

#4. Monte Carlo Simulation
S0 = stock['Close'][-1]
vol = std(stock['Ret'])*sqrt(262)
r = 0.026; K=S0*1.1; T=1.0; M=50; dt=T/M; I=10000
S=zeros((M+1,I)); S[0,:]=S0
for t in range(1,M+1):
    ran = standard_normal(I)
    S[t,:]=S[t-1,:]*exp((r-vol**2/2)*dt*vol*sqrt(dt)*ran)


# In[ ]:

#5. Option Valuation
V0=exp(-r*T)*sum(maximum(S[-1]-K,0))/I
print ("Call Value %8.3f" % V0)


# In[ ]:



