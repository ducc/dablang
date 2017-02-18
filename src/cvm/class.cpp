#include "cvm.h"

const DabFunction &DabClass::get_function(BaseDabVM &vm, const DabValue &klass,
                                          const std::string &name) const
{
    if (klass.type == TYPE_CLASS)
    {
        return get_static_function(vm, klass, name);
    }
    return _get_function(false, vm, klass, name);
}

const DabFunction &DabClass::get_static_function(BaseDabVM &vm, const DabValue &klass,
                                                 const std::string &name) const
{
    return _get_function(true, vm, klass, name);
}

const DabFunction &DabClass::_get_function(bool _static, BaseDabVM &vm, const DabValue &klass,
                                           const std::string &name) const
{
    auto &collection = _static ? static_functions : functions;
    if (!collection.count(name))
    {
        if (index == superclass_index)
        {
            fprintf(stderr, "VM error: Unknown %sfunction <%s> in <%s>.\n",
                    _static ? "static " : "", name.c_str(), klass.class_name(vm).c_str());
            exit(1);
        }
        else
        {
            auto &superclass = vm.get_class(superclass_index);
            return superclass._get_function(_static, vm, klass, name);
        }
    }
    return collection.at(name);
}