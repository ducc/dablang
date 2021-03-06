require_relative 'node.rb'

class DabNodeArg < DabNode
  attr_reader :index

  def initialize(index)
    super()
    @index = index
  end

  def extra_dump
    "$#{@index}"
  end

  def my_type
    function&.arg_type(@index) || DabTypeAny.new
  end

  def compile(output)
    output.print('PUSH_ARG', @index)
  end
end
