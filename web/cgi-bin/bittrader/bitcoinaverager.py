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

script_dir = os.path.dirname(os.path.realpath(__file__))
os.chdir(script_dir)
from BitcoinAverager import PriceCompositor
compositor = PriceCompositor()

app = Flask(__name__)

@app.route('/')
def index():
    return 'index'

@app.route('/average-form')
def average_form():
    return """
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
Intervals: <input name=intervals value="20" size=3>
<p>
Include:
<input type="checkbox" name="time_table" value="True">Time/Epoch information
<input type="checkbox" name="currency_table" value="True">Breakdown by currency
<input type="checkbox" name="conversion_table" value="True">Currency conversion
<input type="checkbox" name="exchange_table" value="True">Exchange breakdown
<br>
Format: <select name="format">
<option value="text/html">HTML</option>
<option value="text/csv">CSV</option>
<option value="text/json">JSON</option>
</select>
<p>
<input type="submit" />
</form>
"""

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

    time_table = (request.form.get('time_table', '') == 'True')
    currency_table = (request.form.get('currency_table', '') == 'True')
    conversion_table = (request.form.get('conversion_table', '') == 'True')
    exchange_table = (request.form.get('exchange_table', '') == 'True')

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

    table = compositor.generate(start_date,
                                time_delta,
                                intervals,
                                times=time_table,
                                currency=currency_table,
                                exchange=exchange_table,
                                rates=conversion_table)
    output = cStringIO.StringIO()
    if format == "text/html":
        table.to_html(output)
    elif format == "text/csv":
        table.to_csv(output)
    elif format == "text/json":
        table.to_json(output)
    else:
        return "invalid format"
    string = output.getvalue()
    output.close()
    return Response(string, mimetype=format)

if __name__ == '__main__' and len(sys.argv) == 1:
    from wsgiref.handlers import CGIHandler
    CGIHandler().run(app)
elif __name__ == '__main__' and sys.argv[1] == "refresh-scripts":
    print refresh_scripts()
