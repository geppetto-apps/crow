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
  end
end
