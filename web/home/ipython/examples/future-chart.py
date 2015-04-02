# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

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

plotme(get_data())
plt.margins()

# <codecell>

for i in ["week", "next_week", "quarter"]:
    data = requests.get('http://market.bitvc.com/futures/ticker_btc_' + i + '.js').json()
    print(data)

