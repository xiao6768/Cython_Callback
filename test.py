

from PyCallback import *

def func(n):
    print (n)

cb = PyCallback(func)
a = "5.0"
b = a.encode(encoding="utf-8")
cb.execute(b)

