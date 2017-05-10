require_relative 'node_set_local_var.rb'

class DabNodeDefineLocalVar < DabNodeSetLocalVar
  def formatted_source(options)
    'var ' + super
  end

  def var_definition
    self
  end

  def index
    function.localvar_index(self)
  end
end
