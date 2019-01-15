def init_ipython():
    from os.path import expanduser
    import sys
    import os.path
    import os
    home = expanduser("~")
    os.environ['PYTHONPATH'] = \
    ':'.join( [os.path.join(home, "ipython"),
               os.path.join(home, "ipython", "examples")] )

init_ipython()
