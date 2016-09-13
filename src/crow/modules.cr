module Crow
  module Modules
    private def transpile(node : Crystal::ModuleDef)
      transpiled_body = transpile_module(node.body)
      "const #{transpile(node.name)} = {#{format_body(transpiled_body)}};"
    end

    private def transpile_module(node : Crystal::Assign)
      "#{transpile(node.target)}: #{transpile(node.value)},"
    end

    private def transpile_module(node : Crystal::ModuleDef)
      transpiled_body = transpile_module(node.body)
      "#{transpile(node.name)}: {#{format_body(transpiled_body)}},"
    end

    private def transpile_module(node : Crystal::Def)
      receiver = node.receiver
      if receiver.is_a?(Crystal::Var) && receiver.name == "self"
        "#{transpile(node.name)}() {#{format_body(node.body)}},"
      else
        raise "Module method definitions cannot be transpiled"
      end
    end

    private def transpile_module(node : Crystal::ASTNode)
      transpile(node)
    end
  end
end
