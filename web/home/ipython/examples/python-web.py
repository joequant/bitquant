# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

#This creates a web service located off 
# http://localhost/python-web/
#
# To shutdown the server you will need to
# restart the kernel

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options
port = 9010

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")

def register():
    import json
    import urllib.request
    data = {"prefix" : "python-web", "port" : port }
    request = urllib.request.Request("http://localhost/app/register")
    request.add_header('Content-Type', 'application/json')
    response = urllib.request.urlopen(request, json.dumps(data).encode('utf-8'))
def main():    
    has_ioloop = tornado.ioloop.IOLoop.initialized()
    application = tornado.web.Application([
        (r"/python-web", MainHandler),
    ])
    application.listen(port)
    if not has_ioloop:
        tornado.ioloop.IOLoop.instance().start()

# <codecell>

register()

# <codecell>

main()

# <codecell>


