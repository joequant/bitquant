
# coding: utf-8

# This is an example of integrating jupyter with spyre.  It uses the pypi binding library configproxy to attach a wsgi server with the jupyter tornado web 

# In[ ]:

from spyre import server

class SimpleApp(server.App):
    title = "Simple App"
    inputs = [{ "type":"text",
                "key":"words",
                "label":"write words here",
                "value":"hello world", 
                "action_id":"simple_html_output"}]

    outputs = [{"type":"html",
                "id":"simple_html_output"}]

    def getHTML(self, params):
        words = params["words"]
        return "Here's what you wrote in the textbox: <b>%s</b>" % words

app = SimpleApp()
import configproxy
import cherrypy
configproxy.register_wsgi("/spyre-test", cherrypy.Application(app.getRoot(), '/'))

