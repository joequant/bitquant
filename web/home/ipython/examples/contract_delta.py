
# coding: utf-8

# In[ ]:

# contract id, lot size, current price

contracts = {
    "3888.HK" : [1000, 20]
}

def contract_delta (id, num_contracts, delta):
    print ("with %d contracts a %f change = %f" %
          (num_contracts, float(delta), 
               float(delta) *contracts[id][0] * num_contracts))

def contract_delta_percent (id, num_contracts, delta):
    print ("with %d contracts a %f  %% at %f change = %f" %
          (num_contracts, float(delta), contracts[id][1],
               float(delta)/100.0 *contracts[id][0] * contracts[id][1] * num_contracts))


# In[ ]:

contract_delta("3888.HK", 10, 1)


# In[ ]:

contract_delta_percent("3888.HK", 10, 5)


# In[ ]:



