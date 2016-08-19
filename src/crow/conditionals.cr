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
    rescue CaseWithTypeDetected
      transformed = transform_case_to_if(node)
      transpile(transformed)
    end

    private def transpile_to_case(node : Crystal::When)
      code = node.conds.map do |cond|
        case cond
        when Crystal::Path
          raise CaseWithTypeDetected.new
        else
          "case #{transpile(cond)}:"
        end
      end.join("\n")

      code += format_body(transpile(node.body) + "\nbreak;")
    end

    private def transpile_to_default(node : Crystal::ASTNode | Nil)
      return "" if node.is_a? Nil

      transpiled = transpile(node)
      formatted = format_body("#{transpiled}\nbreak;")
      "default:#{formatted}"
    end

    private def transform_case_to_if(node : Crystal::Case)
      node_cond = node.cond
      return "" if node_cond.nil?

      if_nodes = [] of Crystal::If
      node.whens.map do |when_node|
        when_node.conds.map do |cond|
          if_node = Crystal::If.new(Crystal::IsA.new(node_cond, cond))
          if_node.then = when_node.body
          if_nodes << if_node
        end
      end

      join_ifs(if_nodes, last_else: node.else)
    end

    private def join_ifs(ifs : Array(Crystal::If), last_else : Crystal::ASTNode?)
      first_if = ifs.shift
      prev_if = first_if
      ifs.each do |if_node|
        prev_if.else = if_node
        prev_if = if_node
      end

      prev_if.else = last_else unless last_else.nil?
      first_if
    end

    class CaseWithTypeDetected < Exception
    end
  end
end
