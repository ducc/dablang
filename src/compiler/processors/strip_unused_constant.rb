class StripUnusedConstant
  def run(node)
    return false if node.references.count > 0
    node.remove!
    true
  end
end
