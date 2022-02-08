
from cython.operator cimport dereference as deref
import sys
# referenced from
# http://stackoverflow.com/questions/5242051/cython-implementing-callbacks

ctypedef double (*method_type)(void *param, void *user_data)


cdef extern from "backend.hpp":
    cdef cppclass Callback:
        Callback(method_type py_callback_template, void *user_data)
        double cy_execute(void *parameter)

cdef double py_callback_template(void *parameter, void *py_method_handle):
    return (<object>py_method_handle)(<object>parameter)


cdef class PyCallback:
    cdef Callback *thisptr

    def __cinit__(self, py_method_handle):
        self.thisptr = new Callback(py_callback_template, <void*>py_method_handle)

    def __dealloc__(self):
        if self.thisptr:
            del self.thisptr

    cpdef double execute(self, parameter):
        return self.thisptr.cy_execute(<void*>parameter)

