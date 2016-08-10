require "./ast/*"

module Crow
  module Vars
    private def transpile(node : Crystal::Assign)
      assign(node.target, node.value)
    end

    private def transpile(node : AST::ConstVar)
      "const " + transpile(node.to_s)
    end

    private def transpile(node : AST::LetVar)
      "let " + transpile(node.to_s)
    end

    private def transpile(node : Crystal::InstanceVar)
      "this." + transpile(node.to_s.sub(/^@/, ""))
    end

    private def transpile(node : Crystal::Global)
      "global." + transpile(node.to_s.sub(/^\$/, ""))
    end

    private def assign(target, value)
      "#{transpile target} = #{transpile value};"
    end

    private def assign(target, value : Crystal::ProcLiteral)
      "function #{transpile target}#{transpile value};"
    end
  end
end
