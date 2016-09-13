module Crow
  module Macros
    @@macros = Hash(String, Crystal::Macro).new

    private def transpile(node : Crystal::Macro)
      @@macros[node.name] = node
      ""
    end

    private def transpile(node : Crystal::MacroExpression | Crystal::MacroLiteral)
      node.to_s
    end

    private def transpile_macro(call : Crystal::Call, mac : Crystal::Macro)
      rendered = mac.body.as(Crystal::Expressions).expressions.map do |node|
        transpile(node)
      end.join("")

      mac.args.each_with_index do |arg, index|
        rendered = rendered.gsub("{{ #{arg.name} }}", call.args[index])
      end

      convert(rendered.strip)
    end
  end
end
