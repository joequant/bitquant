
# coding: utf-8

# In[ ]:

from __future__ import print_function
from ipywidgets import interact, interactive, fixed
import ipywidgets as widgets


# In[ ]:

def f(x):
    return x


# In[ ]:

interact(f, x=10);


# In[ ]:

interact(f, x=True);


# In[ ]:

interact(f, x='Hi there!');


# In[ ]:

@interact(x=True, y=1.0)
def g(x, y):
    return (x, y)


# In[ ]:

def h(p, q):
    return (p, q)


# In[ ]:

interact(h, p=5, q=fixed(20));


# In[ ]:

from ipywidgets import IntSlider
IntSlider(min=-10,max=30,step=1,value=10)


# In[ ]:



