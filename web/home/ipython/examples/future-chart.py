# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

import datetime
def weekly_expiry():
    d = datetime.date.today()
    while d.weekday() != 5:
        d += datetime.timedelta(1)
    return d

# <codecell>

def  quarter_expiry():
    ref = datetime.date.today()
    if ref.month < 4:
        d = datetime.date(ref.year, 3, 31)
    elif ref.month < 7:
        d = datetime.date(ref.year, 6, 30)
    elif ref.month < 10:
        d = datetime.date(ref.year, 9, 30)
    else:
        d= datetime.date(ref.year, 12, 31)
    while d.weekday() != 5:
        d -= datetime.timedelta(1)
    return d
quarter_expiry()

# <codecell>

import json
import requests
import dateutil.parser
import matplotlib.pyplot as plt

# <codecell>

#usdcny = requests.get('http://rate-exchange.appspot.com/currency?from=USD&to=CNY').json()['rate']
usdcny = 6.18

def get_data():
    retval = {}
    expiry = {}
    expiry['week'] = weekly_expiry()
    expiry['next_week'] = weekly_expiry() + datetime.timedelta(1)
    expiry['quarter'] = quarter_expiry()
    #bitmex
    data = requests.get('https://www.bitmex.com:443/api/v1/instrument/active').json()
    for contracttype in ["XBU", "XBT"]:
        symbols = []
        dates = []
        bids = []
        asks = []
        last = []
        for i in data:
            if i['rootSymbol'] == contracttype and i['buyLeg'] == "":
                dates.append(dateutil.parser.parse(i['expiry']))
                symbols.append(i['symbol'])
                bids.append(i['bidPrice'])
                asks.append(i['askPrice'])
                last.append(i['lastPrice'])
        retval["bitmex" + contracttype ] = {"dates": dates,
                                            "bids" : np.array(bids),
                                            "asks" : np.array(asks),
                                            "last" : np.array(last)}
        #okcoin
    symbols = []
    dates = []
    bids = []
    asks = []
    last = []
    for i in ["this_week", "next_week", "month", "quarter"]:
        response = requests.get('https://www.okcoin.com/api/future_ticker.do', params={"symbol": "btc_usd",
                                                                                       "contractType": i})
        data = response.json()["ticker"][0]
        d = datetime.date(int(str(data['contractId'])[0:4]),
                      int(str(data['contractId'])[4:6]),
                      int(str(data['contractId'])[6:8]))
        dates.append(d)
        bids.append(data["buy"])
        asks.append(data['sell'])
        last.append(data['last'])
    retval['okcoin'] = {"dates": dates,
                        "bids" : np.array(bids),
                        "asks" : np.array(asks),
                        "last": np.array(last)}
    #796
    data = requests.get("http://api.796.com/v3/futures/ticker.html?type=weekly").json()['ticker']
    retval['796'] = {'dates':[weekly_expiry()],
                     "bids" : np.array([float(data['buy'])]),
                     "asks" : np.array([float(data['sell'])]),
                     "last" : np.array([float(data['last'])])}
    data = requests.get("http://api.796.com/v3/futures/ticker.html?type=btccnyweeklyfutures").json()['ticker']
    retval['796CNY'] = {'dates':[weekly_expiry()],
                     "bids" : np.array([float(data['buy'])/usdcny]),
                     "asks" : np.array([float(data['sell'])/usdcny]),
                     "last" : np.array([float(data['last'])/usdcny])}
    # bitvic
    dates= []
    bids = []
    asks = []
    last = []
    for i in ["week", "next_week", "quarter"]:
        data = requests.get('http://market.bitvc.com/futures/ticker_btc_' + i + '.js').json()
        dates.append(expiry[i])
        bids.append(data['buy'])
        asks.append(data['sell'])
        last.append(data['last'])
    retval['bitvc'] = {'dates':dates,
                     "bids" : np.array(bids).astype(float)/usdcny,
                     "asks" : np.array(asks).astype(float)/usdcny,
                     "last" : np.array(last).astype(float)/usdcny}      
    print(data)
    return retval

# <codecell>

def plotme(data):
    import matplotlib.pyplot as plt
    fig, ax = plt.subplots()
    plt.margins(x=0.1, y=0.1)
    for k, v in data.items():
        ax.errorbar(v['dates'], v['last'], 
                    yerr=[v['last']-v['asks'], 
                          v['bids']-v['last']], fmt="o")

# <codecell>

data = get_data()
plotme(data)

# <codecell>


