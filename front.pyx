
from cython.operator cimport dereference as deref
from libcpp.string cimport string

import sys
# referenced from
# http://stackoverflow.com/questions/5242051/cython-implementing-callbacks

ctypedef void (*method_type)(string param, void *user_data)


cdef extern from "backend.hpp":
    cdef cppclass Callback:
        Callback(method_type py_callback_template, void *user_data)
        void cy_execute(string parameter)

cdef void py_callback_template(string parameter, void *py_method_handle):
    (<object>py_method_handle)(parameter)


cdef class PyCallback:
    cdef Callback *thisptr

    def __cinit__(self, py_method_handle):
        self.thisptr = new Callback(py_callback_template, <void*>py_method_handle)

    def __dealloc__(self):
        if self.thisptr:
            del self.thisptr

    cpdef void execute(self, parameter):
        self.thisptr.cy_execute(parameter)

