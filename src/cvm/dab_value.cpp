#include "cvm.h"

void DabValue::dump() const
{
    static const char *kinds[] = {"INVAL", "PrvIP", "PrvSP", "nArgs", "nVars",
                                  "RETVL", "CONST", "VARIA", "STACK"};
    static const char *types[] = {
        "INVA", "FIXN", "STRI", "BOOL", "NIL ", "SYMB",
    };
    fprintf(stderr, "%s %s ", kinds[kind], types[type]);
    print(stderr, true);
}

std::string DabValue::class_name() const
{
    switch (type)
    {
    case TYPE_FIXNUM:
        return "Fixnum";
        break;
    case TYPE_STRING:
        return "String";
        break;
    case TYPE_SYMBOL:
        return "Symbol";
        break;
    case TYPE_BOOLEAN:
        return "Boolean";
        break;
    case TYPE_NIL:
        return "NilClass";
        break;
    default:
        assert(false);
        break;
    }
}

void DabValue::print(FILE *out, bool debug) const
{
    switch (type)
    {
    case TYPE_FIXNUM:
        fprintf(out, "%zd", fixnum);
        break;
    case TYPE_STRING:
        fprintf(out, debug ? "\"%s\"" : "%s", string.c_str());
        break;
    case TYPE_SYMBOL:
        fprintf(out, ":%s", string.c_str());
        break;
    case TYPE_BOOLEAN:
        fprintf(out, "%s", boolean ? "true" : "false");
        break;
    case TYPE_NIL:
        fprintf(out, "nil");
        break;
    default:
        fprintf(out, "?");
        break;
    }
}

bool DabValue::truthy() const
{
    switch (type)
    {
    case TYPE_FIXNUM:
        return fixnum;
    case TYPE_STRING:
        return string.length();
        break;
    case TYPE_SYMBOL:
        return true;
        break;
    case TYPE_BOOLEAN:
        return boolean;
        break;
    case TYPE_NIL:
        return false;
        break;
    default:
        return false;
        break;
    }
}