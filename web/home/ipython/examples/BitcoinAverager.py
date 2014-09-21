# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

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

# <codecell>

import tables
import os
import numpy as np
import csv
import logging
import urllib

# <codecell>

class TickData(tables.IsDescription):
    epoch = tables.Float64Col(pos=0)
    price = tables.Float64Col(pos=1)
    volume = tables.Float64Col(pos=2)
    
class CurrencyData(tables.IsDescription):
    date = tables.StringCol(10,pos=0)
    rate = tables.Float64Col(pos=1)
    high = tables.Float64Col(pos=2)
    low = tables.Float64Col(pos=3)
    epoch = tables.Float64Col(pos=4)

# <codecell>

def fill_zeros(fields):
    def _fill(row):
            if len(row) < fields:
                row.extend([0.0] * (fields-len(row)))
            return row
    return _fill

# <codecell>

def fill_epoch(fields, tz_string, time_field):
    import pytz
    from datetime import datetime, timedelta
    tz = pytz.timezone(tz_string)
    def _fill(row):
        if len(row) < fields -1:
              row.extend([0.0] * (fields -len(row)-1))
        datestamp = row[time_field]
        (year, month, day) = datestamp.split("-")
        year = int(year)
        month = int(month)
        day = int(day)
        epoch = TimeUtil.unix_epoch(tz.localize(datetime(year, month, day, 0, 0, 0)))
        row.append(epoch)
        return row
    return _fill

# <codecell>

class BitcoinDataLoader(object):
    def __init__(self):
        self.filename = "bitcoin.h5"
    def init_file(self, keep_existing=True):
        if os.path.isfile(self.filename):
            if keep_existing:
                return
            os.remove(self.filename)
        with tables.open_file(self.filename,mode="w") as h5file:
            self.tick_data = h5file.create_group("/", "tick_data")
            self.currency_data = h5file.create_group("/", "currency_data")
    def openfile(self):
        return tables.open_file(self.filename, mode="a")
    def filedata(self):
        with self.openfile() as f:
            print f
    def download_tick_data(self, exchange):  
        local_cache = exchange + ".csv.gz"
        if not os.path.isfile(local_cache):
            logging.info("retrieving %s" % exchange)
            testfile = urllib.URLopener()
            testfile.retrieve("http://api.bitcoincharts.com/v1/csv/" +
                local_cache,  local_cache)
        logging.info("done retrieving")
    def download_currency_data(self, currency, source="QUANDL"):
        local_cache = currency + ".csv"
        if not os.path.isfile(local_cache):
            logging.info("retrieving %s" % currency)
            testfile = urllib.URLopener()
            if currency == "USDCNY":
                testfile.retrieve("http://www.quandl.com/api/v1/datasets/FRED/DEXCHUS.csv?trim_start=2000-01-01&sort_order=asc", 
                              local_cache)
            else:
                testfile.retrieve("http://www.quandl.com/api/v1/datasets/QUANDL/%s?sort_order=asc" % local_cache, 
                              local_cache)
        logging.info("done retrieving")
    def read_csv(self, table, csv_reader, row_func):
        bsize = 5000
        rows = []
        for i, row in enumerate(csv_reader):
            row = row_func(row)
            all_floats = True
            for j in row[1:]:
                try:
                    float(j)
                except ValueError:
                    all_floats = False
                    break
            if not all_floats:
                continue
            rows.append(tuple(row))
            if ((i+1) % bsize) == 0:
                table.append(rows)
                rows = []
        if rows:
            table.append(rows)  
    def load_tick_data(self, exchange_list):
        import gzip
        with tables.open_file(self.filename, mode="a") as h5file:
            for e in exchange_list:
                if not os.path.isfile(e + ".csv.gz"):
                    self.download_tick_data(e)
                    if ("/tick_data/" + e) in h5file:
                        h5file.remove_node("/tick_data", e)
                if ("/tick_data/" + e) not in h5file:
                    tick_table = h5file.create_table("/tick_data", e, TickData)
                    with gzip.open(e + ".csv.gz", "r") as csv_file:
                        csv_reader = csv.reader(csv_file)
                        self.read_csv(tick_table, csv_reader, fill_zeros(3))
                    tick_table.cols.epoch.create_index()
    def load_currency_data(self, currency_list, tz="Europe/London", source="QUANDL"):
        with tables.open_file("bitcoin.h5", mode="a") as h5file:
            for c in currency_list:
                if not os.path.isfile(c + ".csv"):
                    self.download_currency_data(c)
                    if ("/currency_data/" + c) in h5file:
                        h5file.remove_node("/currency_data", c)
                if ("/currency_data/" + c) not in h5file:
                    currency_table = h5file.create_table("/currency_data", c, CurrencyData)
                    with open(c + ".csv", "r") as csv_file:
                        csv_reader = csv.reader(csv_file)
                        csv_reader.next()
                        self.read_csv(currency_table, csv_reader, fill_epoch(5, tz, 0))
data_loader = BitcoinDataLoader()
data_loader.init_file()

# <codecell>

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

import pandas as pd    
class DataLoaderClient(object):
    loader = BitcoinDataLoader()
    def reload(self):
        self.clear_cache()
        self.load_data()
    def clear_cache(self):
        import os
        if os.path.isfile(self.local_cache):
            os.remove(self.local_cache)
    def load_data(self):
        raise NotImplementedError
        
class BitcoinAverager(DataLoaderClient):
    def __init__(self, exchange, base_currency=None):
        self.exchange = exchange
        self.local_cache = exchange + ".csv.gz"
        self.error_load = False
        self.error_currency = False
        self.base_currency = base_currency
        self.exchange_currency = exchange[-3:]
        if self.base_currency != None and \
            self.exchange_currency != self.base_currency: \
            self.currency_convert = self.base_currency + \
                self.exchange_currency
        else:
            self.currency_convert = None
        self.load_data()
    def load_data(self):
        try:
            self.loader.load_tick_data([self.exchange])
            self.error_load = False
        except:
            self.error_load = True
        if self.currency_convert != None:
            try:
                self.loader.load_currency_data([self.currency_convert])
                self.error_currency = False
            except:
                print "error loading currency"
                self.currency_convert = None
                self.error_currency = True
    def index_range(self):
        if self.error_load:
            return None
        with self.loader.openfile() as h5file:
            node = h5file.get_node("/tick_data", self.exchange)
            first_line = node[0]
            last_line = node[-1]
            rows = len(node)
        return [first_line['epoch'], last_line['epoch'], rows] 
    def select(self, start_epoch, end_epoch):
        u_cols = ['timestamp', 'price', 'volume']
        time_list = []
        price_list = []
        volume_list = []
        with self.loader.openfile() as h5file:
            node = h5file.get_node("/tick_data", self.exchange)
            for line in node.where("(epoch >= %lf) & (epoch < %lf)" % (start_epoch, end_epoch)):
                timestamp = line['epoch']
                price = line['price']
                volume = line['volume']
                if timestamp >= end_epoch:
                    break
                if timestamp >= start_epoch:
                    time_list.append(timestamp)
                    price_list.append(price)
                    volume_list.append(volume)
        return pd.DataFrame({"price" : price_list, "volume": volume_list},
                            index = time_list)
    def select_currency(self, start_epoch, end_epoch):
        if self.currency_convert == None:
            return None
        time_list = []
        rate_list = []
        with self.loader.openfile() as h5file:
            node = h5file.get_node("/currency_data", self.currency_convert)
            for line in node.where("(epoch >= %lf) & (epoch < %lf)" % (start_epoch, end_epoch)):
                timestamp = line['epoch']
                rate = line['rate']
                if timestamp >= end_epoch:                    
                    time_list.append(timestamp)
                    break
                if timestamp >= start_epoch:
                    rate_list.append(rate)
        return pd.DataFrame({"rate" : rate_list}, index = time_list)        
    def weighted_average(self, epoch_list, index=None):
        epoch_iter = iter(epoch_list)
        start_epoch = None
        end_epoch = next(epoch_iter)
        sum_price = {}
        sum_price_base_currency = {}
        sum_volume = {}
        sum_trades = {}
        done = False
        sum_price[end_epoch] = 0.0
        sum_price_base_currency[end_epoch] = 0.0
        sum_volume[end_epoch] = 0.0
        sum_trades[end_epoch] = 0
        with self.loader.openfile() as h5file:
            node = h5file.get_node("/tick_data", self.exchange)
            nodeh = None
            currency_timestamp = None
            next_currency_timestamp = None
            if self.currency_convert != None:
                nodec = h5file.get_node("/currency_data", self.currency_convert)
                nodeh = nodec.where("(epoch <= %lf)" % (epoch_list[-1]))
                next_currency_data = next(nodeh, None)
                currency_data = None
                while next_currency_data != None and \
                    next_currency_data['epoch'] <= epoch_list[0]:
                        currency_data = next_currency_data
                        next_currency_data = next(nodeh, None)
            for line in node.where("(epoch >= %lf) & (epoch <= %lf)" % (epoch_list[0], epoch_list[-1])):
                timestamp = line['epoch']
                price = line['price']
                volume = line['volume']
                while timestamp >= end_epoch:
                    if end_epoch == epoch_list[-1]:
                        done = True
                        break
                    start_epoch = end_epoch
                    e = next(epoch_iter)
                    if e < start_epoch:
                        raise RuntimeError
                    end_epoch = e
                    sum_price[end_epoch] = 0.0
                    sum_price_base_currency[end_epoch] = 0.0
                    sum_volume[end_epoch] = 0.0
                    sum_trades[end_epoch] = 0
                if self.currency_convert != None:
                    while next_currency_data != None and \
                        timestamp >= next_currency_data['epoch']:
                            currency_data = next_currency_data
                            next_currency_data = next(nodeh, None)
                            if next_currency_data == None:
                                break
                            if next_currency_data['epoch'] < \
                                currency_data['epoch']:
                                    print "error"
                                    raise RuntimeError
                if done:
                    break
                if start_epoch != None:
                   sum_price[end_epoch] += price * volume
                   if self.currency_convert != None:
                        rate = currency_data['rate']
                        if rate != 0.0:
                            sum_price_base_currency[end_epoch] += price * volume / rate
                        else:
                            sum_price_base_currency[end_epoch] = None
                   sum_volume[end_epoch] += volume
                   sum_trades[end_epoch] += 1
        average_list = []
        volume_list = []
        trade_list = []
        price_base_currency_list = []
        for i in epoch_list[1:]:
           if i not in sum_trades:
                average_list.append(None)
                volume_list.append(0.0)
                trade_list.append(0)
                price_base_currency_list.append(None)
                continue
           if sum_trades[i] == 0:
               average_list.append(None)
               price_base_currency_list.append(None)
           else:
                average_list.append(sum_price[i]/sum_volume[i])
                if self.currency_convert != None:
                    price_base_currency_list.append(sum_price_base_currency[i]/sum_volume[i])
                elif self.base_currency == self.exchange_currency:
                    price_base_currency_list.append(sum_price[i]/sum_volume[i])
                else:
                    price_base_currency_list.append(None)
           volume_list.append(sum_volume[i])
           trade_list.append(sum_trades[i])
        if index is None:
            index=epoch_list
        df = pd.DataFrame({"price" : average_list, "volume" : volume_list, "trade" : trade_list,
                           "price_base": price_base_currency_list}, index=index[1:])
        df['price'] = df['price'].astype('float32')  # Force None to NaN's
        df['price_base'] = df['price_base'].astype('float32')
        return df
    def intervals(self, start, interval, nintervals):
        dates = TimeUtil.dates(start, interval, nintervals)
        epochs = TimeUtil.epochs(start, interval, nintervals)
        return self.weighted_average(epochs, dates)

class Forex (DataLoaderClient):
    def __init__(self, exchange):
        self.exchange = exchange
        if self.exchange[:3] == self.exchange[-3:]:
            self.local_cache = None
        self.local_cache = exchange + ".csv"
        self.load_data()
# The methodology for this system is to assign to the interval
# the most recent exchange rate.
    def load_data(self):
        if self.exchange[:3] != self.exchange[-3:]:
            self.loader.load_currency_data([self.exchange])
    def rates(self, epoch_list, index=None):
        import pandas as pd
        from datetime import datetime, timedelta
        if self.exchange[:3] == self.exchange[-3:]:
            rate_list = [ 1.0 for i in epoch_list ]
            if index is None:
                index=epoch_list
            return pd.DataFrame({"rates" : rate_list}, index=index)     
        epoch_iter = iter(epoch_list)
        epoch = next(epoch_iter)
        rate = {}
        prev_value = None
        value = None
        done = False
        with self.loader.openfile() as h5file:
            fp = h5file.get_node("/currency_data", self.exchange)
            for line in fp:
                prev_value = value
                epoch_currency = line['epoch']
                value = line['rate']
                while epoch < epoch_currency:
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
        rate_list = [ (rate[i] if i in rate else None) for i in epoch_list ]
        if index is None:
            index=epoch_list
        return pd.DataFrame({"rates" : rate_list}, index=index)
    def intervals(self, start, interval, nintervals):
        dates = TimeUtil.dates(start, interval, nintervals)
        epochs = TimeUtil.epochs(start, interval, nintervals)
        return self.rates(epochs[1:], dates[1:])             

import pandas
class PriceCompositor(object):
    def __init__(self, exchange_list=None, base_currency="GBP"):
        if exchange_list == None:
            exchange_list = ['bitfinexUSD', 'bitstampUSD', 'itbitUSD', 'itbitEUR', 'krakenEUR', 'itbitSGD', 'anxhkHKD']
        self.set_params(exchange_list, base_currency)
    def set_params(self, exchange_list=None, base_currency="GBP"):
        self.exchange_list = exchange_list
        self.exchange_dict = {}
        for e in self.exchange_list:
            currency = e[-3:]
            if not currency in self.exchange_dict:
                self.exchange_dict[currency] = []
            self.exchange_dict[currency].append(e[:-3])
        self.base_currency = base_currency
        self.currencies = self.exchange_dict.keys()
        self.currency_cols = []
        self.exchange_cols = []
        for i in self.currencies:
            self.currency_cols.append(i + "_price")
            self.currency_cols.append(i + "_volume")
            self.currency_cols.append(i + "_trade")
            for j in self.exchange_dict[i]:
                self.exchange_cols.append(j + i)
        self.forex_list = [ self.base_currency + i for i in self.currencies]
        self.averager = { i:BitcoinAverager(i,base_currency) for i in self.exchange_cols }
        self.forex = { f:Forex(f) for f in self.forex_list }
    def reload(self):
        for e in self.exchange_cols:
            self.averager[e].reload()
        for c in self.forex_list:
            self.forex[c].reload()
    def exchange_table(self, start, period, intervals):
        exchange_table = pandas.DataFrame()
        for e in self.exchange_cols:
            table = self.averager[e].intervals(start, period, intervals)
            exchange_table[e+"_price"] = table["price"]
            exchange_table[e+"_price_base"] = table["price_base"]
            exchange_table[e+"_volume"] = table["volume"]
            exchange_table[e+"_trade"] = table ["trade"]
        return exchange_table        
    def currency_table(self, start, period, intervals):
        return self.composite_by_exchange(self.exchange_table(start, period, intervals))  
    def composite_table(self, start, period, intervals):
        return self.composite_all(self.currency_table(start, period, intervals))[0]
    def composite_by_exchange(self, avg):
        df = pandas.DataFrame(columns=self.currency_cols)
        avg1 = avg.fillna(0.0)
        for i in self.currencies:
            price_key = [ j + i + "_price" for j in self.exchange_dict[i]]
            price_base_key = [j+i + "_price_base" for j in self.exchange_dict[i]]
            volume_key = [ j + i + "_volume" for j in self.exchange_dict[i]]
            trade_key = [ j + i + "_trade" for j in self.exchange_dict[i]]
            map_dict = {(j+i+"_volume"):(j+i+"_price") for j in self.exchange_dict[i]}
            df[i + "_volume"] = avg1[volume_key].sum(axis=1)
            df[i + "_trade"] = avg1[trade_key].sum(axis=1)
            df[i + "_price"] = (avg1[price_key] * avg1[volume_key].rename(columns=map_dict)).sum(axis=1) / df[i + "_volume"]
            df[i + "_price_base"] = (avg1[price_base_key] * avg1[volume_key].rename(columns=map_dict)).sum(axis=1) / df[i + "_volume"]
        return df
    def composite_all(self,df, method="exchange"):
        epochs = map(TimeUtil.unix_epoch, df.index)
        conversion_table = pandas.DataFrame()
        for f in self.forex_list:
            conversion_table[f] = self.forex[f].rates(epochs, df.index)['rates']
        df1 = df.join(conversion_table)
        composite = pandas.DataFrame(columns=["price", "price_base",  "volume", "trade"])
        price_key = [(i + "_price") for i in self.currencies]
        price_base_key = [(i+"_price_base") for i in self.currencies]
        volume_key = [(i + "_volume") for i in self.currencies]
        trade_key = [(i + "_trade") for i in self.currencies]
        if (method == "exchange"):
            dict_map = {(self.base_currency+i):(i+ "_price_base") for i in self.currencies}
            dict1_map = {(i+ "_volume"):(i+ "_price_base") for i in self.currencies}
            composite['price'] = (df1[price_base_key] * 
                              df1[volume_key].rename(columns=dict1_map)).sum(axis=1) / composite["volume"]
        else:
           currency_key = [ (self.base_currency + i) for i in self.currencies]
           dict_map = {(self.base_currency+i):(i+ "_price") for i in self.currencies}
           dict1_map = {(i+ "_volume"):(i+ "_price") for i in self.currencies}
           dict2_map = {(i+"_price"):(self.base_currency + i + "_price") for i in self.currencies}
           converted_price_table = \
                              (df1[price_key] / df1[currency_key].rename(columns=dict_map)).rename(columns=dict2_map)
           composite['price'] = (df1[price_key]  /  df1[currency_key].rename(columns=dict_map) * \
                              df1[volume_key].rename(columns=dict1_map)).sum(axis=1) / composite["volume"]
        composite["volume"] = df1[volume_key].sum(axis=1)
        composite["trade"] = df1[trade_key].sum(axis=1)
        return (composite, conversion_table, converted_price_table)
    def col_format(self, times=True,
                   currency=True,
                   exchange=True,
                   rates=True,
                   converted_prices=True):
        retval = []
        retval.append(["index", 1])
        retval.append(['sum', 3])
        if currency:
            retval.append(["currency", len(self.currencies)*3])
        if exchange:
            retval.append(['exchange', len(self.exchange_list)*3])
        if converted_prices:
            retval.append(['converted', len(self.currencies)])
        if rates:
            retval.append(['rates', len(self.currencies)])
        if times:
            retval.append(['times', 4], )
        return retval
    def generate(self, start, period, intervals, times=False,
                 currency=False, exchange=False, rates=False,
                 converted_prices=False):
        """Generate pytable with composite bitcoin information
@param start - date to start table
@param period - time delta to iterate over
@param intervals - number of intervals
@param times - add time related columns
@param currency - add currency related columns
@param exchange - add exchange related columns
@param converted_prices - add converted prices
"""
        exchange_table = self.exchange_table(start, period, intervals)
        currency_table = self.composite_by_exchange(exchange_table)
        (composite_table, conversion_table, converted_price_table) = self.composite_all(currency_table)
        if currency:
            composite_table = composite_table.join(currency_table)
        if exchange:
            composite_table = composite_table.join(exchange_table)
        if converted_prices:
            composite_table = composite_table.join(converted_price_table)
        if rates:
            composite_table = composite_table.join(conversion_table)
        if times:        
            time_table = TimeUtil.time_table(start, period, intervals)
            composite_table = composite_table.join(time_table)
        return composite_table

# <codecell>


# <codecell>


# <codecell>


