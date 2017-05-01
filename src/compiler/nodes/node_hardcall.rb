require_relative 'node.rb'
require_relative '../../shared/opcodes.rb'

class DabNodeHardcall < DabNode
  def initialize(identifier, args)
    super()
    insert(identifier)
    args&.each { |arg| insert(arg) }
  end

  def identifier
    children[0]
  end

  def real_identifier
    identifier.extra_value
  end

  def args
    children[1..-1]
  end

  def compile(output)
    args.each { |arg| arg.compile(output) }
    output.push(identifier)
    output.comment(real_identifier)
    output.printex(self, 'HARDCALL', args.count.to_s, '1')
  end

  def target_function
    root.has_function?(real_identifier)
  end
end
