module Crow
  module Conditionals
    private def transpile(node : Crystal::If)
      cond = transpile node.cond
      case node
      when Crystal::Unless
        cond = "!#{cond}"
      end

      code = <<-JS
      if (#{cond}) {#{format_body(node.then)}}
      JS
      case node.else
      when Crystal::Nop
      when Crystal::If
        code += " else #{transpile(node.else)}"
      else
        code += " else {#{format_body(node.else)}}"
      end
      code
    end

    private def transpile(node : Crystal::Unless)
      cond = transpile node.cond
      cond = "!#{cond}"

      code = <<-JS
      if (#{cond}) {#{format_body(node.then)}}
      JS
      case node.else
      when Crystal::Nop
      else
        code += " else {#{format_body(node.else)}}"
      end
      code
    end

    private def transpile(node : Crystal::Case)
      node_cond = node.cond

      case node_cond
      when Crystal::ASTNode
        code = node.whens.map do |when_node|
          transpile_to_case(when_node)
        end.join("")
        code += transpile_to_default(node.else)

        "switch (#{transpile(node_cond)}) {\n#{code}}"
      else
        raise "Case statements without conditions cannot be transpiled. \
               See https://github.com/geppetto-apps/crow/issues/8/"
      end
    end

    private def transpile_to_case(node : Crystal::When)
      code = node.conds.map do |cond|
        "case #{transpile(cond)}:"
      end.join("\n")

      code += format_body(transpile(node.body) + "\nbreak;")
    end

    private def transpile_to_default(node : Crystal::ASTNode | Nil)
      return "" if node.is_a? Nil

      transpiled = transpile(node)
      formatted = format_body("#{transpiled}\nbreak;")
      "default:#{formatted}"
    end
  end
end
