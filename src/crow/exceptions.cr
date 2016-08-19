module Crow
  module Exceptions
    private def transpile(node : Crystal::ExceptionHandler)
      "try {#{format_body(node.body)}}" \
      "#{produce_catch(node.rescues)}" \
      "#{produce_finally(node.ensure)}"
    end

    private def produce_catch(node : Nil)
      ""
    end

    private def produce_catch(nodes : Array(Crystal::Rescue))
      " catch (e) {#{format_body(transpile_rescues(nodes))}}"
    end

    private def transpile_rescues(nodes : Array(Crystal::Rescue))
      if nodes.size == 1
        transpile(nodes[0])
      else
        transpile(nodes).join(" else ")
      end
    end

    private def produce_finally(node : Nil)
      ""
    end

    private def produce_finally(node : Crystal::ASTNode)
      transpiled_ensure = transpile(node)
      " finally {#{format_body(transpiled_ensure)}}"
    end

    private def transpile(node : Crystal::Rescue)
      transpiled_body = transpile(node.body)
      node_name = node.name

      case node_name
      when String
        if node_name != "e"
          transpiled_body = "const #{node_name} = e;\n" + transpiled_body
        end
      end

      node_types = node.types
      case node_types
      when Array(Crystal::ASTNode)
        types_condition = node_types.map do |type|
          is_a = Crystal::IsA.new(Crystal::Var.new("e"), type)
          transpile(is_a)
        end.join(" || ")
        "if (#{types_condition}) {#{format_body(transpiled_body)}}"
      else
        transpiled_body
      end
    end
  end
end
