module Crow
  module Basic
    private def transpile(content : String)
      content
    end

    private def transpile(node : Crystal::NilLiteral)
      "undefined"
    end

    private def transpile(node : Crystal::ASTNode)
      transpile node.to_s
    end

    private def transpile(node : Crystal::Assign)
      "#{transpile node.target} = #{transpile node.value};"
    end
  end
end
