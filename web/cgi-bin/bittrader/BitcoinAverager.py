# Copyright (c) 2014 Bitquant Research Laboratories (Asia) Ltd.

# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import logging
class TimeUtil(object):
    @staticmethod
    def unix_epoch(dt):
        import time
        return time.mktime(dt.timetuple())
    @staticmethod
    def dates(start, period, intervals):
        return [(start + n * period) for n in range(intervals + 1)]
    @staticmethod
    def epochs(start, period, intervals):
        return map(TimeUtil.unix_epoch, 
                   TimeUtil.dates(start, period, intervals))
    @staticmethod
    def time_table(start, period, intervals):
        import pandas
        epochs = TimeUtil.epochs(start, period, intervals)
        dates = TimeUtil.dates(start, period, intervals)
        data = {}
        data['start_epoch'] = epochs[:-1]
        data['end_epoch'] = epochs[1:]
        data['start_date'] = dates[:-1]
        data['end_date'] = dates[1:]
        return pandas.DataFrame(data, 
                                columns=['start_epoch', 'end_epoch', 'start_date', 'end_date'],
                                index=data['end_date'])

    
class BitcoinAverager(object):
    def __init__(self, exchange):
        self.exchange = exchange
        self.local_cache = exchange + ".csv"
        self.data = None
        self.retrieve_data()
    def retrieve_data(self):
        if not os.path.isfile(self.local_cache):
            logging.info("data not cached - downloading")
            self.download_data()
    def download_data(self):
        import urllib
        import subprocess
        import gzip
        import os
        if not os.path.isfile(self.local_cache):
            logging.info("retrieving %s" % self.exchange)
            testfile = urllib.URLopener()
            testfile.retrieve("http://api.bitcoincharts.com/v1/csv/" +
                 self.exchange + ".csv.gz", 
                          self.local_cache + ".gz")
            with gzip.open(self.local_cache + ".gz", 'rb') as orig_file:
                with open(self.local_cache, 'wb') as new_file:
                    new_file.writelines(orig_file)
                os.remove(self.local_cache + ".gz")
        logging.info("done retrieving")
    def clear_cache(self):
        import os
        os.remove(self.local_cache)
    def create_table(self):
        import gzip
        import pandas as pd
        u_cols = ['timestamp', 'value', 'amount']
        with open(self.local_cache) as fp:
            return pd.read_csv(fp, names=u_cols)
    def select(self, start_epoch, end_epoch):
        import pandas as pd
        u_cols = ['timestamp', 'price', 'volume']
        time_list = []
        value_list = []
        volume_list = []
        with open(self.local_cache) as fp:
            for line in fp:
                (timestamp, value, volume) = line.strip().split(",")
                timestamp = float(timestamp)
                value = float(value)
                volume = float(volume)
                if timestamp >= end_epoch:
                    break
                if timestamp >= start_epoch:
                    time_list.append(timestamp)
                    value_list.append(value)
                    volume_list.append(volume)
        return pd.DataFrame({"price" : value_list, "volume": volume_list},
                            index = time_list)
    def weighted_average(self, epoch_list, index=None):
        import pandas as pd
        epoch_iter = iter(epoch_list)
        start_epoch = None
        end_epoch = next(epoch_iter)
        sum_value = {}
        sum_volume = {}
        sum_trades = {}
        done = False
        with open(self.local_cache) as fp:
            for line in fp:
                (timestamp, value, volume) = line.strip().split(",")
                timestamp = float(timestamp)
                while timestamp >= end_epoch:
                    if end_epoch == epoch_list[-1]:
                        done = True
                        break
                    start_epoch = end_epoch
                    e = next(epoch_iter)
                    if e < start_epoch:
                        raise RuntimeError
                    end_epoch = e
                    sum_value[end_epoch] = 0.0
                    sum_volume[end_epoch] = 0.0
                    sum_trades[end_epoch] = 0
                if done:
                    break
                if start_epoch != None:
                   sum_value[end_epoch] += float(value) * float(volume)
                   sum_volume[end_epoch] += float(volume)
                   sum_trades[end_epoch] += 1
        average_list = []
        volume_list = []
        trade_list = []
        for i in epoch_list[1:]:
           if sum_trades[i] == 0:
               average_list.append(None)
           else:
               average_list.append(sum_value[i]/sum_volume[i])
           volume_list.append(sum_volume[i])
           trade_list.append(sum_trades[i])
        if index is None:
            index=epoch_list
        return pd.DataFrame({"price" : average_list, "volume" : volume_list, "trade" : trade_list}, index=index[1:])
    def intervals(self, start, interval, nintervals):
        dates = TimeUtil.dates(start, interval, nintervals)
        epochs = TimeUtil.epochs(start, interval, nintervals)
        return self.weighted_average(epochs, dates)

class Forex (object):
    def __init__(self, exchange):
        self.exchange = exchange
        self.local_cache = exchange + ".csv"
        self.data = None
        self.retrieve_data()
        self.tz = "Europe/London"
    def retrieve_data(self):
        if not os.path.isfile(self.local_cache):
            logging.info("data not cached - downloading")
            self.download_data()
    def download_data(self):
        import urllib
        import subprocess
        if not os.path.isfile(self.local_cache):
            logging.info("retrieving %s" % self.exchange)
            testfile = urllib.URLopener()
            testfile.retrieve("http://www.quandl.com/api/v1/datasets/QUANDL/%s?sort_order=asc" % self.local_cache, 
                          self.local_cache)
        logging.info("done retrieving")
    def delete_cache(self):
        os.remove(self.local_cache)
# The methodology for this system is to assign to the interval
# the most recent exchange rate.
    def rates(self, epoch_list, index=None):
        import pandas as pd
        import pytz
        from datetime import datetime, timedelta
        tz = pytz.timezone(self.tz)
        epoch_iter = iter(epoch_list)
        epoch = next(epoch_iter)
        rate = {}
        prev_value = None
        value = None
        done = False
        with open(self.local_cache) as fp:
            fp.readline() # skip header
            for line in fp:
                prev_value = value
                (datestamp, value, high, low) = line.strip().split(",")
                value = float(value)
                (year, month, day) = datestamp.split("-")
                year = int(year)
                month = int(month)
                day = int(day)
                end_interval = TimeUtil.unix_epoch(tz.localize(datetime(year, month, day, 0, 0, 0)))
                while epoch <= end_interval:
                    rate[epoch] = prev_value
                    if epoch == epoch_list[-1]:
                        done = True
                        break
                    e = next(epoch_iter)
                    if e < epoch:
                        raise RuntimeError
                    epoch = e
                if done:
                    break
        rate_list = [ rate[i] for i in epoch_list ]
        if index is None:
            index=epoch_list
        return pd.DataFrame({"rates" : rate_list}, index=index)
    def intervals(self, start, interval, nintervals):
        dates = TimeUtil.dates(start, interval, nintervals)
        epochs = TimeUtil.epochs(start, interval, nintervals)
        return self.rates(epochs[1:], dates[1:])             
                    
class PriceCompositor(object):
    def __init__(self, exchange_list=None, base_currency="GBP"):
        if exchange_list != None:
            self.exchange_list = exchange_list
        else:
            self.exchange_list = {
        "USD" : ["bitfinex", "bitstamp", "itbit"],
        "EUR" : ["itbit", "kraken"],
        "SGD" : ["itbit"],
        "HKD" : ["anxhk"]
        }
        self.base_currency = base_currency
        self.currencies = self.exchange_list.keys()
        self.currency_cols = []
        self.exchange_cols = []
        for i in self.currencies:
            self.currency_cols.append(i + "_price")
            self.currency_cols.append(i + "_volume")
            self.currency_cols.append(i + "_trade")
            for j in self.exchange_list[i]:
                self.exchange_cols.append(j + i)
        self.forex_list = [ self.base_currency + i for i in self.currencies]
        self.averager = {}
        for i in self.exchange_cols:
            self.averager[i] = BitcoinAverager(i)
        self.forex = {}
        for f in self.forex_list:
            self.forex[f] = Forex(f)
    def exchange_table(self, start, period, intervals):
        price_table = {}
        for e in self.exchange_cols:
           price_table[e] = self.averager[e].intervals(start, period, intervals)
           price_table[e].rename(columns={"price": e+"_price", "volume" : e+"_volume", 
                               "trade": e+"_trade"}, inplace=True)
        return price_table[self.exchange_cols[0]].join([price_table[e] for e in self.exchange_cols[1:]])        
    def currency_table(self, start, period, intervals):
        return self.composite_by_exchange(self.exchange_table(start, period, intervals))  
    def composite_table(self, start, period, intervals):
        return self.composite_all(self.currency_table(start, period, intervals))[0]
    def composite_by_exchange(self, avg):
        import pandas

        df = pandas.DataFrame(columns=self.currency_cols)
        avg1 = avg.fillna(0.0)
        for i in self.currencies:
            price_key = [ j + i + "_price" for j in self.exchange_list[i]]
            volume_key = [ j + i + "_volume" for j in self.exchange_list[i]]
            trade_key = [ j + i + "_trade" for j in self.exchange_list[i]]
            map_dict = {}
            for j in self.exchange_list[i]:
                map_dict[j + i + "_volume"] = j + i + "_price"
            df[i + "_volume"] = avg1[volume_key].sum(axis=1)
            df[i + "_trade"] = avg1[trade_key].sum(axis=1)
            df[i + "_price"] = (avg1[price_key] * avg1[volume_key].rename(columns=map_dict)).sum(axis=1) / df[i + "_volume"]
        return df
    def composite_all(self,df):
        import pandas
        epochs = map(TimeUtil.unix_epoch, df.index)
        conversion_table = pandas.DataFrame(columns =[], index=df.index )
        for f in self.forex_list:
            conversion_table = conversion_table.join(self.forex[f].rates(epochs, df.index).rename(columns={"rates": f}))
        df1 = df.join(conversion_table)
        composite = pandas.DataFrame(columns=["price", "volume", "trade"])
        price_key = [i + "_price" for i in self.currencies]
        volume_key = [i + "_volume" for i in self.currencies]
        trade_key = [i + "_trade" for i in self.currencies]
        currency_key = [ self.base_currency + i for i in self.currencies]

        dict_map = {}
        dict1_map = {}
        for i in self.currencies:
            dict_map[self.base_currency + i] = i + "_price"
            dict1_map[i + "_volume"] = i  + "_price"
        composite["volume"] = df1[volume_key].sum(axis=1)
        composite["trade"] = df1[trade_key].sum(axis=1)
        composite['price'] = (df1[price_key] / df1[currency_key].rename(columns=dict_map) * \
                              df1[volume_key].rename(columns=dict1_map)).sum(axis=1) / composite["volume"]
        return (composite, conversion_table)
    def generate(self, start, period, intervals, times=False, currency=False, exchange=False, rates=False):
        """Generate pytable with composite bitcoin information
@param start - date to start table
@param period - time delta to iterate over
@param intervals - number of intervals
@param times - add time related columns
@param currency - add currency related columns
@param exchange - add exchange related columns
"""
        exchange_table = self.exchange_table(start, period, intervals)
        currency_table = self.composite_by_exchange(exchange_table)
        (composite_table, conversion_table) = self.composite_all(currency_table)
        if times:        
            time_table = TimeUtil.time_table(start, period, intervals)
            composite_table = composite_table.join(time_table)
        if currency:
            composite_table = composite_table.join(currency_table)
        if rates:
            composite_table = composite_table.join(conversion_table)
        if exchange:
            composite_table = composite_table.join(exchange_table)
        return composite_table
