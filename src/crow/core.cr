module Crow
  module Core
    private def transpile(node : Crystal::ASTNode | String)
      node.to_s
    end

    private def transpile(node : Crystal::Self)
      transpile "this"
    end

    private def transpile(node : Crystal::ProcLiteral)
      _def = node.def
      _def.name = ""
      transpile _def
    end
  end
end
