require_relative 'node.rb'
require_relative '../processors/simplify_class_property.rb'

class DabNodePropertyGet < DabNode
  optimize_with SimplifyClassProperty
  lower_with :convert_to_call

  def initialize(value, identifier)
    super()
    insert(value)
    insert(identifier)
  end

  def value
    @children[0]
  end

  def identifier
    @children[1]
  end

  def real_identifier
    identifier.extra_value
  end

  def convert_to_call
    call = DabNodeInstanceCall.new(value, identifier, [], nil)
    replace_with!(call)
    true
  end

  def constant?
    value.constant?
  end

  def formatted_source(options)
    value.formatted_source(options) + '.' + real_identifier
  end
end
