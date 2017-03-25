// Autogenerated from /src/shared/opcodes.rb

enum
{
    OP_START_FUNCTION  = 0x00,
    OP_CONSTANT_SYMBOL = 0x01,
    OP_CONSTANT_STRING = 0x02,
    OP_PUSH_CONSTANT   = 0x03,
    OP_CALL            = 0x04,
    OP_SET_VAR         = 0x05,
    OP_PUSH_VAR        = 0x06,
    OP_PUSH_ARG        = 0x07,
    OP_CONSTANT_NUMBER = 0x08,
    OP_RETURN          = 0x09,
    OP_JMP             = 0x0A,
    OP_JMP_IFN         = 0x0B,
    OP_NOP             = 0x0C,
    OP_PUSH_NIL        = 0x0E,
    OP_KERNELCALL      = 0x0F,
    OP_START_CLASS     = 0x10,
    OP_PUSH_CLASS      = 0x11,
    OP_INSTCALL        = 0x12,
    OP_PUSH_SELF       = 0x13,
    OP_PUSH_INSTVAR    = 0x14,
    OP_SET_INSTVAR     = 0x15,
    OP_PUSH_ARRAY      = 0x16,
    OP_PUSH_TRUE       = 0x17,
    OP_PUSH_FALSE      = 0x18,
};
