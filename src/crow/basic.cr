module Crow
  module Basic
    private def transpile(node : Crystal::ASTNode | String)
      node.to_s
    end

    private def transpile(node : Crystal::NilLiteral)
      "undefined"
    end

    private def transpile(node : Crystal::Assign)
      "#{transpile node.target} = #{transpile node.value};"
    end
  end
end
