#!/usr/bin/python
from wsgiref.handlers import CGIHandler
from flask import Flask, Response, request
import os
import sys
app = Flask(__name__)
script_dir = os.path.dirname(os.path.realpath(__file__))
template = """
<html>
<head>
</head>
<body>
<script type="text/javascript">
function open_pages() {
%s
close();
}
</script>
<button onclick="javascript:open_pages()">Open pages</button>
</body>
"""

@app.route('/', methods=['GET','POST'])
def index():
    if request.method == "POST":
        string = resource.form["resource"];
        open_string = ""
        for i in string.split("\n"):
            i = i.strip();
            open_string += "window.open('%s');\n" % i
        return template % open_string;
    else:
        return template % "";

if __name__ == '__main__' and len(sys.argv) == 1:
    from wsgiref.handlers import CGIHandler
    CGIHandler().run(app)
