require_relative '../../shared/base_context.rb'

class DabContext < DabBaseContext
  attr_accessor :local_vars
  attr_accessor :functions
  attr_accessor :classes

  def initialize(stream)
    super(stream)
    @local_vars = []
    @functions = ['print']
    @classes = ['String']
  end

  def add_local_var(id)
    raise "id must be string, is #{id.class}" unless id.is_a? String
    @local_vars << id
  end

  def add_function(id)
    raise "id must be string, is #{id.class}" unless id.is_a? String
    @functions << id
  end

  def add_class(id)
    raise "id must be string, is #{id.class}" unless id.is_a? String
    @classes << id
  end

  def has_function?(id)
    @functions.include? id
  end

  def read_program
    ret = DabNodeUnit.new
    until @stream.eof?
      if f = on_subcontext(&:read_function)
        ret.add_function(f)
      elsif c = on_subcontext(&:read_define_class)
        ret.add_class(c)
      else
        raise 'unknown token'
      end
      @stream.skip_whitespace
    end
    ret
  end

  def _read_list(item_method, separator = ',')
    __read_list(item_method, separator, DabNode.new) do |base, item, sep|
      base.insert(DabNodeListNode.new(item, sep))
    end
  end

  def _read_simple_list(item_method, separator = ',')
    list = _read_list(item_method, separator)
    return nil unless list
    ret = DabNode.new
    list.children.map(&:value).each { |item| ret.insert(item) }
    ret
  end

  def _read_list_or_single(method, separator, klass)
    list = _read_list(method, separator)
    return list unless list
    ret = list[0].value
    (list.count - 1).times do |n|
      i = n + 1
      ret = klass.new(ret, list[i].value, list[i].separator)
    end
    ret
  end

  def read_argument
    on_subcontext do |subcontext|
      id = subcontext.read_identifier
      next false unless id
      lbrace = subcontext.read_operator('<')
      if lbrace
        next false unless type = subcontext.read_type
        next false unless rbrace = subcontext.read_operator('>')
      end

      ret = DabNodeArgDefinition.new(-1, id, type)
      ret.add_source_part(id)
      ret.add_source_part(lbrace)
      ret.add_source_part(type)
      ret.add_source_part(rbrace)
      ret
    end
  end

  def read_arglist
    list = _read_simple_list(:read_argument)
    if list
      list.each_with_index do |item, index|
        item.index = index
      end
    end
    list
  end

  def read_type
    on_subcontext do |subcontext|
      typename = subcontext.read_identifier
      next false unless typename
      DabNodeType.new(typename)
    end
  end

  def read_define_class
    on_subcontext do |subcontext|
      next false unless subcontext.read_keyword('class')
      next false unless ident = subcontext.read_identifier
      next false unless subcontext.read_operator('{')
      next false unless subcontext.read_operator('}')
      subcontext.add_class(ident)
      DabNodeClassDefinition.new(ident)
    end
  end

  def read_function
    on_subcontext do |subcontext|
      next false unless subcontext.read_keyword('func')
      next false unless ident = subcontext.read_identifier
      subcontext.add_function(ident)
      next false unless subcontext.read_operator('(')
      if arglist = subcontext.read_arglist || nil
        arglist.each do |arg|
          symbol = arg.identifier
          subcontext.add_local_var(symbol)
        end
      end
      next false unless subcontext.read_operator(')')
      next false unless code = subcontext.read_codeblock
      DabNodeFunction.new(ident, code, arglist)
    end
  end

  def read_return
    on_subcontext do |subcontext|
      next false unless subcontext.read_keyword('return')
      next false unless value = subcontext.read_value

      DabNodeReturn.new(value)
    end
  end

  def read_instruction
    read_if || read_return || read_define_var || read_call
  end

  def read_if
    on_subcontext do |subcontext|
      next false unless subcontext.read_keyword('if')
      next false unless subcontext.read_operator('(')
      next false unless condition = subcontext.read_value
      next false unless subcontext.read_operator(')')
      next false unless if_true = subcontext.read_codeblock
      elsek = subcontext.read_keyword('else')
      if elsek
        next false unless if_false = subcontext.read_codeblock
      end

      DabNodeIf.new(condition, if_true, if_false)
    end
  end

  def read_local_var
    on_subcontext do |subcontext|
      id = subcontext.read_identifier
      if @local_vars.include? id
        DabNodeLocalVar.new(id)
      else
        false
      end
    end
  end

  def read_class
    on_subcontext do |subcontext|
      id = subcontext.read_identifier
      if @classes.include? id
        DabNodeClass.new(id)
      else
        false
      end
    end
  end

  def read_define_var
    on_subcontext do |subcontext|
      next false unless keyw = subcontext.read_keyword('var')
      lbrace = subcontext.read_operator('<')
      if lbrace
        next false unless type = subcontext.read_type
        next false unless rbrace = subcontext.read_operator('>')
      end
      next false unless id = subcontext.read_identifier
      next false unless eq = subcontext.read_operator('=')
      next false unless value = subcontext.read_value

      subcontext.add_local_var(id)
      ret = DabNodeDefineLocalVar.new(id, value, type)
      ret.add_source_part(keyw)
      ret.add_source_part(lbrace)
      ret.add_source_part(type)
      ret.add_source_part(rbrace)
      ret.add_source_part(id)
      ret.add_source_part(eq)
      ret.add_source_part(value)
      ret
    end
  end

  def read_valuelist
    _read_simple_list(:read_value)
  end

  def read_call
    on_subcontext do |subcontext|
      next false unless id = subcontext.read_identifier
      next false unless op1 = subcontext.read_operator('(')
      valuelist = subcontext.read_valuelist || nil
      next false unless op2 = subcontext.read_operator(')')
      ret = DabNodeCall.new(id, valuelist)
      ret.add_source_part(id)
      ret.add_source_part(op1)
      ret.add_source_part(valuelist)
      ret.add_source_part(op2)
      ret
    end
  end

  def read_codeblock
    on_subcontext do |subcontext|
      next false unless subcontext.read_operator('{')
      ret = DabNodeCodeBlock.new
      while true
        instr = subcontext.read_instruction
        break unless instr
        next false unless subcontext.read_operator(';')
        ret.insert(instr)
      end
      next false unless subcontext.read_operator('}')
      ret
    end
  end

  def read_literal_string
    on_subcontext do |subcontext|
      str = subcontext.read_string
      next false unless str
      DabNodeLiteralString.new(str)
    end
  end

  def read_literal_number
    on_subcontext do |subcontext|
      str = subcontext.read_number
      next false unless str
      ret = DabNodeLiteralNumber.new(str.to_i)
      ret.add_source_part(str)
      ret
    end
  end

  def read_literal_boolean
    on_subcontext do |subcontext|
      next false unless keyword = subcontext.read_any_operator(%w(true false))
      DabNodeLiteralBoolean.new(keyword == 'true')
    end
  end

  def read_literal_value
    read_literal_string || read_literal_number || read_literal_boolean
  end

  def read_base_value
    read_class || read_literal_value || read_local_var || read_call
  end

  def read_simple_value
    on_subcontext do |subcontext|
      value = subcontext.read_base_value
      next false unless value
      dot = subcontext.read_operator('.')
      next value unless dot
      prop_name = subcontext.read_identifier
      next false unless prop_name
      lparen = subcontext.read_operator('(')
      if lparen
        arglist = subcontext.read_valuelist
        next false unless arglist
        rparen = subcontext.read_operator(')')
        next false unless rparen
        DabNodeInstanceCall.new(value, prop_name, arglist)
      else
        DabNodePropertyGet.new(value, prop_name)
      end
    end
  end

  def read_mul_value
    _read_list_or_single(:read_simple_value, ['*', '/', '%'], DabNodeOperator)
  end

  def read_add_value
    _read_list_or_single(:read_mul_value, ['+', '-'], DabNodeOperator)
  end

  def read_value
    _read_list_or_single(:read_add_value, ['=='], DabNodeOperator)
  end

  def clone
    ret = super
    ret.local_vars = @local_vars.clone
    ret.functions = @functions.clone
    ret.classes = @classes.clone
    ret
  end

  def merge!(other_context)
    super(other_context)
    @local_vars = other_context.local_vars
    @functions = other_context.functions
    @classes = other_context.classes
  end
end
