from flask import Flask, request
app = Flask(__name__, static_url_path='', static_folder='bittrader')

@app.route("/")
def root():
    return app.send_static_file('index.html')

if __name__ == "__main__":
    app.run()
