#ifndef __GUARD
#define __GUARD

#include <iostream>

class Callback {
public:
    // This is wrapper of Python fuction.
    typedef double (*method_type)(void *param, void *user_func);

    Callback();
    Callback(method_type, void *user_func);
    virtual ~Callback();

    double cy_execute(void *parameter);

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
