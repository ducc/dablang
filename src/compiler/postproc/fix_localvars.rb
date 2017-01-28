class DabPPFixLocalvars
  def run(program)
    program.visit_all(DabNodeFunction) do |function|
      local_vars = {}
      function.visit_all(DabNodeDefineLocalVar) do |node|
        node.index = local_vars.count
        local_vars[node.real_identifier] = node.index
      end
      function.visit_all(DabNodeLocalVar) do |node|
        node.index = local_vars[node.real_identifier]
      end
      function.n_local_vars = local_vars.count
    end
  end
end