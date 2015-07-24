
# coding: utf-8

# This is an example of registering a python web service.  You can access the a service which
# is registered by name /python-web by http://localhost/app/python-web  

# In[ ]:

#This creates a web service located off 
#   
#
# To shutdown the server you will need to
# restart the kernel

import tornado.web

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")
import bitquantutils
bitquantutils.register_tornado_handler("/python-web",  MainHandler)


# In[ ]:

#Create web service off of
# http://localhost/app/python-wsgi

def simple_app(environ, start_response):
    status = "200 OK"
    response_headers = [("Content-type", "text/plain")]
    start_response(status, response_headers)
    return [b"Hello world! with WSGI Handler\n"]

import bitquantutils
bitquantutils.register_wsgi("/python-wsgi", simple_app)


# In[ ]:

#Create web service off of 
# http://localhost/app/python-web-html

from IPython.display import HTML
def html_response(input):
    return """<table>
<tr>
<th>Header 1</th>
<th>Header 2</th>
</tr>
<tr>
<td>row 1, cell 1</td>
<td>row 1, cell 2</td>
</tr>
<tr>
<td>row 2, cell 1</td>
<td>row 2, cell 2</td>
</tr>
</table>"""
HTML(html_response(None))
import tornado.web

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write(html_response(None))

import bitquantutils
bitquantutils.register_tornado_handler("/python-web-html", MainHandler)


# In[ ]:

import bitquantutils
bitquantutils.start_loop()


# In[ ]:

bitquantutils.unregister_all()


# In[ ]:



