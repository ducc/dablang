require_relative '../shared/args.rb'
require_relative '../shared/base_context.rb'
require_relative '../shared/debug_output.rb'
require_relative '../shared/parser.rb'
require_relative 'nodes/node.rb'
require_relative 'nodes/node_arg.rb'
require_relative 'nodes/node_arg_definition.rb'
require_relative 'nodes/node_call.rb'
require_relative 'nodes/node_class.rb'
require_relative 'nodes/node_class_definition.rb'
require_relative 'nodes/node_class_var.rb'
require_relative 'nodes/node_class_var_definition.rb'
require_relative 'nodes/node_code_block.rb'
require_relative 'nodes/node_constant.rb'
require_relative 'nodes/node_constant_reference.rb'
require_relative 'nodes/node_define_local_var.rb'
require_relative 'nodes/node_function.rb'
require_relative 'nodes/node_if.rb'
require_relative 'nodes/node_instance_call.rb'
require_relative 'nodes/node_jump.rb'
require_relative 'nodes/node_list_node.rb'
require_relative 'nodes/node_literal.rb'
require_relative 'nodes/node_literal_array.rb'
require_relative 'nodes/node_literal_boolean.rb'
require_relative 'nodes/node_literal_nil.rb'
require_relative 'nodes/node_literal_number.rb'
require_relative 'nodes/node_literal_string.rb'
require_relative 'nodes/node_local_var.rb'
require_relative 'nodes/node_operator.rb'
require_relative 'nodes/node_property_get.rb'
require_relative 'nodes/node_reference_index.rb'
require_relative 'nodes/node_reference_instvar.rb'
require_relative 'nodes/node_reference_localvar.rb'
require_relative 'nodes/node_reference_member.rb'
require_relative 'nodes/node_return.rb'
require_relative 'nodes/node_self.rb'
require_relative 'nodes/node_set_inst_var.rb'
require_relative 'nodes/node_set_local_var.rb'
require_relative 'nodes/node_setter.rb'
require_relative 'nodes/node_symbol.rb'
require_relative 'nodes/node_type.rb'
require_relative 'nodes/node_unit.rb'
require_relative 'parts/compiler.rb'
require_relative 'parts/context.rb'
require_relative 'parts/exceptions.rb'
require_relative 'parts/output.rb'
require_relative 'parts/types.rb'
require_relative 'postproc/add_missing_returns.rb'
require_relative 'postproc/check_call_args_types.rb'
require_relative 'postproc/check_functions.rb'
require_relative 'postproc/check_setvar_types.rb'
require_relative 'postproc/compact_constants.rb'
require_relative 'postproc/convert_arg_to_localvar.rb'
require_relative 'postproc/fix_literals.rb'
require_relative 'postproc/fix_localvars.rb'
require_relative 'postproc/lower.rb'
require_relative 'postproc/reuse_constants.rb'
require_relative 'postproc/simplify_constant_properties.rb'
require_relative 'postproc/strip_single_vars.rb'
