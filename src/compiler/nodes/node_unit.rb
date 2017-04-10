require_relative 'node.rb'

class DabNodeUnit < DabNode
  attr_reader :constants

  def initialize
    super()
    @functions = DabNode.new
    @constants = DabNode.new
    @classes = DabNode.new
    insert(@functions, 'functions')
    insert(@constants, 'constants')
    insert(@classes, 'classes')
    @class_numbers = STANDARD_CLASSES_REV.dup
    @labels = 0
  end

  def class_number(id)
    @class_numbers[id]
  end

  def reserve_label
    ret = @labels
    @labels += 1
    "L#{ret}"
  end

  def add_constant(literal)
    index = @constants.count
    const = DabNodeConstant.new(literal, index)
    @constants.insert(const)
    ret = DabNodeConstantReference.new(index)
    ret.clone_source_parts_from(literal)
    ret
  end

  def add_function(function)
    @functions.insert(function)
  end

  def add_class(klass)
    number = @class_numbers[klass.identifier]
    number ||= USER_CLASSES_OFFSET + @classes.count
    klass.assign_number(number)
    @classes.insert(klass)
    @class_numbers[klass.identifier] = number
  end

  def _items
    [@constants.children, @classes.children, @functions.children]
  end

  def compile(output)
    [@constants.children, @classes.children].each do |list|
      list.each do |node|
        node.compile(output)
      end
      output.separate
    end
    @functions.children.each do |function|
      function.compile(output)
    end
    output.separate
    output.print('BREAK_LOAD')
    output.separate
    @functions.children.each do |function|
      function.compile_body(output)
      output.separate
    end
    @classes.children.each do |klass|
      klass.functions.each do |function|
        function.compile_body(output)
        output.separate
      end
    end
  end

  def remove_constant_node(node)
    @constants.remove_child(node)
  end

  def reorder_constants!
    @constants.children.sort_by!(&:index)
  end

  def formatted_source(options)
    _items.flatten(1).map { |item| item.formatted_source(options) }.join("\n")
  end
end
