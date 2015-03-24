def init_ipython():
    from os.path import expanduser
    import sys
    import os.path
    import os
    home = expanduser("~")
    sys.path.append(os.path.join(home, "ipython"))
    sys.path.append(os.path.join(home, "git", "bitquant", "web", "scripts"))

init_ipython()
