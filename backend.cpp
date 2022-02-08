#include "backend.hpp"

Callback::Callback()
    :is_cython_call_(true)
{}

Callback::Callback(method_type method, void *user_func)
    :is_cython_call_(true), method_(method), user_func_(user_func)
{}

Callback::~Callback()
{}

void Callback::cy_execute(std::string parameter)
{
    this->method_(parameter, user_func_);
}
