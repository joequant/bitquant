def init_ipython():
    from os.path import expanduser
    import sys
    import os.path
    import os
    home = expanduser("~")
    os.environ['PYTHONPATH'] = \
    ':'.join( [os.path.join(home, "ipython"),
               os.path.join(home, "git", "bitquant", "web", "scripts")] )

init_ipython()
