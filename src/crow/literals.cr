module Crow
  module Literals
    private def transpile(node : Crystal::ArrayLiteral)
      elements = node.elements.map do |element|
        transpile element
      end.join(", ")

      array_type = node.of
      case array_type
      when Crystal::Path
        "[#{elements}]: #{transpile array_type}[]"
      else
        "[#{elements}]"
      end
    end

    private def transpile(node : Crystal::HashLiteral)
      entries = node.entries.map do |entry|
        "\"#{transpile entry.key}\": #{transpile entry.value}"
      end.join(", ")

      hash_type = node.of
      case hash_type
      when Crystal::HashLiteral::Entry
        "{#{entries}}: { [key: #{transpile hash_type.key}]: #{transpile hash_type.value} }"
      else
        "{#{entries}}"
      end
    end

    private def transpile(node : Crystal::NamedTupleLiteral)
      entries = node.entries.map do |entry|
        "\"#{transpile entry.key}\": #{transpile entry.value}"
      end.join(", ")

      "{#{entries}}"
    end
  end
end
