# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

#!/usr/bin/python
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

from wsgiref.handlers import CGIHandler
from flask import Flask, Response, request
from werkzeug.utils import secure_filename
import subprocess
import sys
import shutil
import os
import json
import getpass
import login
import traceback
import fcntl
import time
import crypt
import pandas
import datetime
import time
import pytz
import dateutil
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import getpass

# <codecell>

#me = getpass.getuser()
#sys.path.append(os.path.join("/home", me, "git/bitquant/web/home/ipython/examples"))
try:
    script_dir = os.path.dirname(os.path.realpath(__file__))
    os.chdir(script_dir)
except:
    pass

from BitcoinAverager import PriceCompositor



app = Flask(__name__)
all_exchanges = ['bitfinexUSD','bitstampUSD','itbitUSD',
                 'itbitEUR','krakenEUR','itbitSGD','anxhkHKD',
                 'okcoinCNY', 'btcnCNY']
compositor = PriceCompositor(all_exchanges)

@app.route('/')
def index():
    return average_form()

@app.route('/average-form')
def average_form():
    retval = """
<form method=POST action="generate-data">
Start time (yyyy/mm/dd): <input name="year" size=4 value="2014">/
<input name="month" size=2 value="02">/<input name="day" size=2 value="01">  <input name="hour" size=2 value="00">:<input name="minute" size=2 value="00">:<input name="second" size=2 value="00"><br>
Time zone: <input name="tz" size=20 value="Europe/London"><br>
Time interval: <input name=interval_length value="3" size=3>
<select name="interval_type">
<option value="month">month(s)</option>
<option value="week">week(s)</option>
<option value="day">day(s)</option>
<option value="hour" selected>hour(s)</option>
<option value="minute">minute(s)</option>
<option value="second">second(s)</option>
</select><br>
Intervals: <input name=intervals value="20" size=3><p>
Exchanges:<br>
"""
    for i in all_exchanges:
        if i not in compositor.averager:
            continue
        index_range = compositor.averager[i].index_range()
        if 'CNY' in i:
            c = ''
        else:
            c = 'checked'
        retval += '<input %s type="checkbox" name=exchanges value="%s">%s' % (c, i, i)
        try:
            retval += " - %s UTC to %s UTC - %d rows<br>" % ( time.strftime('%Y-%m-%d %H:%M:%S', time.gmtime(index_range[0])),
                                                       time.strftime('%Y-%m-%d %H:%M:%S', time.gmtime(index_range[1])), index_range[2])
        except:
            retval += "error"
    retval += """
<p>
Include:
<br>
Base Currency: <input name="base_currency" value="GBP" size="3">
<br>
Format: <select name="format">
<option value="text/html">HTML</option>
<option value="text/csv">CSV</option>
<option value="text/json">JSON</option>
</select>
<p>
<input type="checkbox" name="table" value="True" checked>Table<br>
<input type="checkbox" name="plot" value="True">Plot<br>
Price plot fields (comma_separated): <input name="price_plot_fields" value="price"><br>
Volume plot fields (comma separated): <input name="volume_plot_fields" value="volume"><br>
<input type="submit" />
</form>
"""
    return retval

@app.route('/generate-data', methods = ['POST'])
def generate_data():
    import cStringIO
    year = request.form['year']
    month = request.form['month']
    day = request.form['day']
    hour = request.form['hour']
    minute = request.form['minute']
    second = request.form['second']
    time_zone = request.form['tz']
    interval_length = int(request.form['interval_length'])
    interval_type = request.form['interval_type']
    intervals = int(request.form['intervals'])

    base_currency = request.form.get('base_currency', 'GBP')
    time_table = (request.form.get('time_table', 'True') == 'True')
    currency_table = (request.form.get('currency_table', 'True') == 'True')
    conversion_table = (request.form.get('conversion_table', 'True') == 'True')
    exchange_table = (request.form.get('exchange_table', 'True') == 'True')
    converted_prices = (request.form.get('converted_prices', 'True') == 'True')
    show_table = (request.form.get('table', '') == 'True')
    plot = (request.form.get('plot', '') == 'True')
    price_plot_fields = request.form.get('price_plot_fields', '')
    volume_plot_fields = request.form.get('volume_plot_fields', '')


    format = request.form.get('format', "text/html")
    local_tz = pytz.timezone(time_zone)
    start_date = local_tz.localize(datetime.datetime(int(year),
                                                     int(month),
                                                     int(day),
                                                     int(hour),
                                                     int(minute),
                                                     int(second)))
    time_delta = None
    if interval_type == "month":
        time_delta = dateutil.relativedelta.relativedelta(months=interval_length)
    elif interval_type == "week":
        time_delta = dateutil.relativedelta.relativedelta(weeks=interval_length)
    elif interval_type == "day":
        time_delta = dateutil.relativedelta.relativedelta(days=interval_length)
    elif interval_type == "hour":
        time_delta = dateutil.relativedelta.relativedelta(hours=interval_length)
    elif interval_type == "minute":
        time_delta = dateutil.relativedelta.relativedelta(minutes=interval_length)
    elif interval_type == "seconds":
        time_delta = dateutil.relativedelta.relativedelta(seconds=interval_length)
    else:
        return "invalid interval_type"
    exchanges = request.form.getlist("exchanges")
    compositor.set_params(exchanges, base_currency)
    table = compositor.generate(start_date,
                                time_delta,
                                intervals,
                                times=time_table,
                                currency=currency_table,
                                exchange=exchange_table,
                                rates=conversion_table,
                                converted_prices=converted_prices)
    output = cStringIO.StringIO()
    if format == "text/html":
        if show_table:
            table.to_html(output, classes=["data","compact", "stripe"])
        if plot:
            sio = cStringIO.StringIO()
            plt.figure(figsize=(6, 6))
            ax1 = plt.subplot2grid((8,1), (0,0), rowspan=7)
            ax2 = plt.subplot2grid((8,1), (7,0))
            ax1.xaxis.set_ticklabels([])
            table[[x.strip() for x in price_plot_fields.split(",")]].plot(ax=ax1)
            table[[x.strip() for x in volume_plot_fields.split(",")]].plot(ax=ax2)
            plt.savefig(sio,format='png')
            output.write('<img src="data:image/png;base64,%s"/>' % \
                         sio.getvalue().encode("base64").strip())
            sio.close()
    elif format == "text/csv":
        table.to_csv(output)
    elif format == "text/json":
        table.to_json(output, orient='split', date_format='iso')
    else:
        return "invalid format"
    string = output.getvalue()
    output.close()
    if format == "text/html":
        string = string.replace('border="1"', '')
        header = """
<head>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<script src="//cdn.datatables.net/fixedcolumns/3.0.0/js/dataTables.fixedColumns.min.js"></script>
<script>
$(document).ready(function() {
    var table = $('.data').dataTable({
        "bFilter": false,
        "scrollY": "350px",
        "scrollX": true,
        "scrollCollapse": true,
        "paging":         false,
        "columns" : [
    """
        col_items = []
        for col in compositor.col_format():
            for j in range(col[1]):
                if col[0] != "index" and col[0] != "sum":
                    visible = ", visible: " + '$("#' + col[0] + '_table").prop("checked")'
                else:
                    visible = ""
                col_items.append('{className : "' + col[0] + '"' + visible + '}')
        header +=  ",\n".join(col_items) + """
        ]
    });
    new $.fn.dataTable.FixedColumns( table );
    $( ".toggle" ).change(function() {
      item = $(this).attr("item");
      if ($(this).prop("checked")) {
      table.DataTable().columns(item).visible(true, false);
      } else {
      table.DataTable().columns(item).visible(false, false);
      }
      table.DataTable().draw();
      new $.fn.dataTable.FixedColumns( table );
    });
    });
</script>
<style type="text/css">
.data .index {
 white-space: nowrap
 }

 .times {
 white-space: nowrap
 }

td {
 text-align: right
 }

th {
 text-align: center
 }
</style>
<link href="//cdn.datatables.net/1.10.2/css/jquery.dataTables.css" type="text/css" rel="stylesheet">
<link href="//cdn.datatables.net/fixedcolumns/3.0.0/css/dataTables.fixedColumns.min.css" rel="stylesheet">
</head>
<input type="checkbox" class="toggle" item=".currency" id="currency_table" name="currency_table" value="True">Itemize by currency
<input type="checkbox" class="toggle" item=".exchange" id="exchange_table" name="exchange_table" value="True">Itemize by exchange
<input type="checkbox" class="toggle" item=".converted" id="converted_table" name="conversion_table" value="True">Currency converted prices
<input type="checkbox" class="toggle" item=".rates" id="rates_table" name="conversion_table" value="True">Currency rates
<input type="checkbox" class="toggle" item=".times" id="times_table" name="time_table" value="True">Time/Epoch information
"""
    return Response(header+string, mimetype=format)

@app.route("/reload")
def reload():
    compositor = PriceCompositor()
    compositor.reload()
    return "reloaded"

# <codecell>

import tornado
import tornado.wsgi
import tornado.httpserver

container = tornado.wsgi.WSGIContainer(app)
http_server = tornado.httpserver.HTTPServer(container)
http_server.listen(9010)
tornado.ioloop.IOLoop.instance().start()

# <codecell>


