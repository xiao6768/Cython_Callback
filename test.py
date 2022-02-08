

from PyCallback import *

def func(n):
    return n * 2;

cb = PyCallback(func)
print (cb.execute(5.0))

