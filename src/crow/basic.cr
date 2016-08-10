module Crow
  module Basic
    private def transpile(node : Crystal::ASTNode | String)
      node.to_s
    end
  end
end
