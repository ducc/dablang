require_relative 'node.rb'

class DabNodeOperator < DabNode
  def initialize(left, right, method)
    super()
    insert(method.to_sym)
    insert(left)
    insert(right)
  end

  def identifier
    children[0]
  end

  def left
    children[1]
  end

  def right
    children[2]
  end

  def compile(output)
    tmp_label = '_tmp_label_0'

    left.compile(output)
    op_id = identifier.extra_value.to_s
    if op_id == '||' || op_id == '&&'
      output.print('DUP')
      output.print(op_id == '||' ? 'JMP_IF' : 'JMP_IFN', tmp_label)
      output.print('POP', 1)
      right.compile(output)
      output.label(tmp_label)
    else
      right.compile(output)
      output.push(identifier)
      output.comment("op #{identifier.extra_value}")
      output.print('CALL', 2, 1)
    end
  end

  def formatted_source(options)
    left.formatted_source(options) + " #{identifier.extra_value} " + right.formatted_source(options)
  end

  def optimize!
    return fold! if left.constant? && right.constant?
    super
  end

  def fold!
    id = identifier.extra_value
    lv = left.constant_value
    rv = right.constant_value
    numeric = (lv.is_a? Numeric) && (rv.is_a? Numeric)
    if id == :'||'
      replace_with!((lv.nil? || lv == 0 || lv == '' || lv == false) ? right : left)
      return true
    end
    if id == :'&&'
      replace_with!((lv.nil? || lv == 0 || lv == '' || lv == false) ? left : right)
      return true
    end
    if numeric && %i(+ - * / %).include?(id)
      replace_with! DabNodeLiteralNumber.new(lv.send(id, rv))
      return true
    elsif %i(== !=).include?(id)
      replace_with! DabNodeLiteralBoolean.new(lv.send(id, rv))
      return true
    else
      raise "don't know how to fold #{lv.class} #{id} #{rv.class}"
    end
  end
end
