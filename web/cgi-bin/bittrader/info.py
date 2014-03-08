#!/usr/bin/python
from wsgiref.handlers import CGIHandler
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return 'index'

@app.route('/foo')
def test():
    return 'test'

if __name__ == '__main__':
        from wsgiref.handlers import CGIHandler
        CGIHandler().run(app)
