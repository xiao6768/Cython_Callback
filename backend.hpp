#ifndef __GUARD
#define __GUARD

#include <iostream>
#include <string>

class Callback {
public:
    // This is wrapper of Python fuction.
    typedef void (*method_type)(std::string param, void *user_func);

    Callback();
    Callback(method_type, void *user_func);
    virtual ~Callback();

    void cy_execute(std::string parameter);

    bool is_cython_call()
    {
        return this->is_cython_call_;
    }
protected:
    bool is_cython_call_;
private:
    method_type method_;
    void *user_func_;
};

#endif
