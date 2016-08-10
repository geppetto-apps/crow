require "./ast/*"

module Crow
  module Vars
    private def transpile(node : AST::ConstVar)
      "const " + transpile(node.to_s)
    end

    private def transpile(node : AST::LetVar)
      "let " + transpile(node.to_s)
    end

    private def transpile(node : Crystal::InstanceVar)
      "this." + transpile(node.to_s.sub(/^@/, ""))
    end
  end
end
