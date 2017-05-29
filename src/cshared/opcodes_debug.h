// Autogenerated from /src/shared/opcodes.rb

const DabOpcodeInfo g_opcodes[] = {
    {OP_NOP, "NOP", {}},
    {OP_PUSH_NIL, "PUSH_NIL", {}},
    {OP_PUSH_SELF, "PUSH_SELF", {}},
    {OP_PUSH_TRUE, "PUSH_TRUE", {}},
    {OP_PUSH_FALSE, "PUSH_FALSE", {}},
    {OP_PUSH_STRING, "PUSH_STRING", {ARG_VLC}},
    {OP_PUSH_NUMBER, "PUSH_NUMBER", {ARG_UINT64}},
    {OP_PUSH_ARRAY, "PUSH_ARRAY", {ARG_UINT16}},
    {OP_PUSH_CLASS, "PUSH_CLASS", {ARG_UINT16}},
    {OP_PUSH_CONSTANT, "PUSH_CONSTANT", {ARG_UINT16}},
    {OP_PUSH_ARG, "PUSH_ARG", {ARG_UINT16}},
    {OP_PUSH_VAR, "PUSH_VAR", {ARG_UINT16}},
    {OP_PUSH_INSTVAR, "PUSH_INSTVAR", {ARG_VLC}},
    {OP_PUSH_SYMBOL, "PUSH_SYMBOL", {ARG_VLC}},
    {OP_POP, "POP", {ARG_UINT16}},
    {OP_DUP, "DUP", {}},
    {OP_CONSTANT_SYMBOL, "CONSTANT_SYMBOL", {ARG_VLC}},
    {OP_CONSTANT_STRING, "CONSTANT_STRING", {ARG_VLC}},
    {OP_CONSTANT_NUMBER, "CONSTANT_NUMBER", {ARG_UINT64}},
    {OP_CALL, "CALL", {ARG_UINT16, ARG_UINT16}},
    {OP_INSTCALL, "INSTCALL", {ARG_UINT16, ARG_UINT16}},
    {OP_HARDCALL, "HARDCALL", {ARG_UINT16, ARG_UINT16}},
    {OP_SYSCALL, "SYSCALL", {ARG_UINT8}},
    {OP_JMP, "JMP", {ARG_INT16}},
    {OP_JMP_IF, "JMP_IF", {ARG_INT16}},
    {OP_JMP_IFN, "JMP_IFN", {ARG_INT16}},
    {OP_RETURN, "RETURN", {ARG_UINT16}},
    {OP_SET_VAR, "SET_VAR", {ARG_UINT16}},
    {OP_SET_INSTVAR, "SET_INSTVAR", {ARG_VLC}},
    {OP_COV_FILE, "COV_FILE", {ARG_UINT16, ARG_VLC}},
    {OP_COV, "COV", {ARG_UINT16, ARG_UINT16}},
    {OP_START_FUNCTION, "START_FUNCTION", {ARG_VLC, ARG_UINT16, ARG_UINT16, ARG_UINT16}},
    {OP_LOAD_FUNCTION, "LOAD_FUNCTION", {ARG_UINT16, ARG_VLC, ARG_UINT16}},
    {OP_STACK_RESERVE, "STACK_RESERVE", {ARG_UINT16}},
    {OP_DEFINE_CLASS, "DEFINE_CLASS", {ARG_VLC, ARG_UINT16, ARG_UINT16}},
    {OP_BREAK_LOAD, "BREAK_LOAD", {}},
    {OP_YIELD, "YIELD", {ARG_UINT16}},
};
