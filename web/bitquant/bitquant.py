#!/usr/bin/python
from flask import Flask, request, render_template
app = Flask(__name__, static_url_path='', static_folder='')

@app.route("/")
def root():
    return app.send_static_file('index.html')

@app.route("/test")
def test():
    return "test"

if __name__ == "__main__":
    app.run()
