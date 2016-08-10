module Crow
  module TemplateString
    private def transpile(node : Crystal::StringInterpolation)
      data = node.expressions.map do |node|
        case node
        when Crystal::StringLiteral
          node.value
        else
          "${#{transpile node}}"
        end
      end
      "`#{data.join}`"
    end
  end
end
