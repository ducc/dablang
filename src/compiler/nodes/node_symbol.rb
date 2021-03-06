require_relative 'node_literal.rb'

class DabNodeSymbol < DabNodeLiteral
  attr_reader :symbol
  def initialize(symbol)
    raise "empty symbol (#{symbol})" if symbol.to_s.empty?
    super()
    @symbol = symbol
    add_source_parts(symbol)
  end

  def extra_dump
    ":#{symbol}"
  end

  def extra_value
    symbol
  end

  def escaped_symbol
    if symbol =~ /^[a-z_]+$/i
      symbol
    else
      "\"#{symbol}\""
    end
  end

  def compile_constant(output)
    output.print('CONSTANT_SYMBOL', escaped_symbol)
  end

  def my_type
    DabTypeSymbol.new
  end

  def compile(output)
    output.print('PUSH_SYMBOL', escaped_symbol)
  end
end
