#!/usr/bin/env python
# coding: utf-8

# In[10]:


import pandas as pd
import pandas_schema 
from pandas_schema import Column
from pandas_schema.validation import CustomElementValidation
import numpy as np
from decimal import *

def check_decimal(dec):
    try:
        Decimal(dec)
    except InvalidOperation:
        return False
    return True


def check_int(num):
    try:
        int(num)
    except ValueError:
        return False
    return True

def check_str(num):
    try:
        str(num)
    except ValueError:
        return False
    return True

def do_validation():
    # read the data
    
    data = pd.read_csv(r'C:\Users\MAC\Desktop\Yarra\POC\\user_location_bcp.csv')

    # define validation elements
    decimal_validation = [CustomElementValidation(lambda d: check_decimal(d), 'is not decimal')]
    int_validation = [CustomElementValidation(lambda i: check_int(i), 'is not integer')]
    null_validation = [CustomElementValidation(lambda d: d is not np.nan, 'this field cannot be null')]
    #string_validation = [CustomElementValidation(lambda d: check_str(d), 'is not a String')]

    # define validation schema
    schema = pandas_schema.Schema([
            Column('address',null_validation),
            Column('latitude', decimal_validation),
            Column('longitude', decimal_validation),
            Column('tag', null_validation),
            Column('location_id', int_validation),
            Column('user_id', int_validation+null_validation)])

    # apply validation
    errors = schema.validate(data)
    
    errors_index_rows = [e.row for e in errors]
    
    data_clean = data.drop(index=errors_index_rows)

    # save data
    pd.DataFrame({'col':errors}).to_csv('errors.csv')
    data_clean.to_csv('clean_data.csv',index=False)

# Source google https://github.com/BogdanCojocar/medium-articles/blob/master/pandas_validation/validation.py 
do_validation()


# In[2]:





# In[ ]:




