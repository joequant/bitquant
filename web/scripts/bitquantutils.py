import tornado.ioloop
has_ioloop = tornado.ioloop.IOLoop.initialized()

def register_port(prefix, port):
    import json
    import urllib.request
    data = {"prefix" : prefix, "port" : port }
    request = urllib.request.Request("http://localhost/app/register")
    request.add_header('Content-Type', 'application/json')
    response = urllib.request.urlopen(request,
                                      json.dumps(data).encode('utf-8'))

def register_tornado_handler(prefix, port, handler):
    import tornado.ioloop
    import tornado.web
    register_port(prefix, port)
    application = tornado.web.Application([
        (prefix + "($|/.*)", handler),
        ])
    application.listen(port)

def register_wsgi(prefix, port, handler):
    import tornado.ioloop
    import tornado.wsgi
    import tornado.web
    register_port(prefix, port)
    container = tornado.wsgi.WSGIContainer(handler)
    application = tornado.web.Application([
        (prefix + ".*", tornado.web.FallbackHandler, dict(fallback=container))
        ])
    application.listen(port)

def start_loop():
    if not has_ioloop:
        tornado.ioloop.IOLoop.instance().start()
