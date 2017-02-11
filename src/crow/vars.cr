require "./ast/*"

module Crow
  module Vars
    private def transpile(node : Crystal::Assign)
      assign(node.target, node.value)
    end

    private def transpile(node : Crystal::OpAssign)
      value = Crystal::Call.new(node.target, node.op, node.value)
      transpile Crystal::Assign.new(node.target, value)
    end

    private def transpile(node : AST::ConstVar)
      "const " + transpile(node.to_s)
    end

    private def transpile(node : AST::LetVar)
      "let " + transpile(node.to_s)
    end

    private def transpile(node : Crystal::Var)
      node.to_s
    end

    private def transpile(node : Crystal::InstanceVar)
      "#{transpile Crystal::Self.new}." + transpile(node.to_s.sub(/^@/, ""))
    end

    private def assign(target, value)
      "#{transpile target} = #{transpile value};"
    end

    private def assign(target, value : Crystal::ProcLiteral)
      _def = value.def.clone
      _def.name = transpile(target)
      "#{transpile _def};"
    end
  end
end
