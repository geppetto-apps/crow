module Crow
  module Symbol
    private def transpile(node : Crystal::SymbolLiteral)
      "Symbol.for('#{node.value}')"
    end
  end
end
