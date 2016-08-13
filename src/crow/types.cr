module Crow
  module Types
    private def transpile(node : Crystal::Alias)
      "type #{node.name} = #{transpile node.value};"
    end

    private def transpile(node : Crystal::Union)
      transpile(node.types).join(" | ")
    end

    private def transpile(node : Crystal::Generic)
      type_vars = transpile node.type_vars

      node_name = transpile node.name
      case node_name
      when "Array"
        "#{type_vars.first}[]"
      when "::Tuple"
        "[#{type_vars.join(", ")}]"
      else
        "#{node_name}<#{type_vars.join(", ")}>"
      end
    end

    private def transpile(node : Crystal::ProcNotation)
      inputs = transpile node.inputs

      "(#{inputs.join(", ")}): #{transpile node.output}"
    end
  end
end
