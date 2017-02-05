class DabCompilerError
  attr_reader :message
  attr_reader :source
  def initialize(message, source)
    @message = message
    @source = source
  end
end

class DabCompileUnknownFunctionError < DabCompilerError
  def initialize(function, source)
    super("Unknown function <#{function}>.", source)
  end

  def error_code
    1
  end
end

class DabCompileSetvarTypeError < DabCompilerError
  def initialize(type1, type2, source)
    super("Cannot assign <#{type1.type_string}> to a variable of type <#{type2.type_string}>.", source)
  end

  def error_code
    2
  end
end

class DabCompileSetargTypeError < DabCompilerError
  def initialize(type1, type2, source)
    super("Cannot pass <#{type1.type_string}> to an argument of type <#{type2.type_string}>.", source)
  end

  def error_code
    3
  end
end
