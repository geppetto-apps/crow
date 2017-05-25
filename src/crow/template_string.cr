module Crow
  module TemplateString
    private def transpile(node : Crystal::StringInterpolation)
      data = node.expressions.map do |node|
        case node
        when Crystal::StringLiteral
          node.value
        else
          context :template_string do
            "${#{transpile node}}"
          end
        end
      end
      "`#{data.join}`"
    end
  end
end
