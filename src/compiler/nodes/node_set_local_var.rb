require_relative 'node.rb'

class DabNodeSetLocalVar < DabNode
  attr_accessor :index
  attr_reader :identifier
  attr_reader :my_type
  attr_accessor :arg_var

  def initialize(identifier, value, type = nil, arg_var = false)
    super()
    @identifier = identifier
    insert(value)
    type ||= DabNodeType.new(nil)
    type = type.dab_type if type.is_a? DabNodeType
    @my_type = type
    @arg_var = arg_var
  end

  def extra_dump
    "<#{real_identifier}>"
  end

  def value
    children[0]
  end

  def real_identifier
    identifier
  end

  def compile(output)
    raise 'no index' unless @index
    value.compile(output)
    output.comment("var #{index} #{identifier}")
    output.print('SET_VAR', index)
  end
end