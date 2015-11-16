
# coding: utf-8

# In[ ]:

import ethercalc


# In[ ]:

e = ethercalc.EtherCalc("http://localhost/calc")
e.get("/daily/cells")


# In[ ]:

e.export('daily')

