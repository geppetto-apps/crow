module Crow
  module Core
    private def transpile(node : String)
      node
    end

    private def transpile(node : Crystal::ASTNode)
      log_fallback_usage(node)
      node.to_s
    end

    private def transpile(nodes : Array(Crystal::ASTNode) | Nil)
      case nodes
      when Nil
        [] of String
      else
        nodes.map do |node|
          transpile node
        end
      end
    end

    private def transpile(node : Crystal::Self)
      transpile "this"
    end

    private def transpile(node : Crystal::ProcLiteral)
      _def = node.def
      _def.name = ""
      transpile _def
    end

    private def log_fallback_usage(node)
      logger.info "Using fallback for node with type #{node.class}."
    end
  end
end
