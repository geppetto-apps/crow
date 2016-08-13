module Crow
  module Literals
    private def transpile(node : Crystal::NilLiteral)
      "undefined"
    end

    private def transpile(node : Crystal::BoolLiteral)
      node.to_s
    end

    private def transpile(node : Crystal::NumberLiteral)
      node.to_s
    end

    private def transpile(node : Crystal::StringLiteral)
      node.to_s
    end

    private def transpile(node : Crystal::ArrayLiteral)
      elements = transpile(node.elements).join(", ")

      array_type = node.of
      case array_type
      when Crystal::Path
        "[#{elements}]: #{transpile array_type}[]"
      else
        "[#{elements}]"
      end
    end

    private def transpile(node : Crystal::HashLiteral)
      entries = transpile(node.entries).join(", ")

      hash_type = node.of
      case hash_type
      when Crystal::HashLiteral::Entry
        "{#{entries}}: { [key: #{transpile hash_type.key}]: #{transpile hash_type.value} }"
      else
        "{#{entries}}"
      end
    end

    private def transpile(entries : Array(Crystal::HashLiteral::Entry))
      entries.map do |entry|
        transpile entry
      end
    end

    private def transpile(entry : Crystal::HashLiteral::Entry)
      "\"#{transpile entry.key}\": #{transpile entry.value}"
    end

    private def transpile(node : Crystal::NamedTupleLiteral)
      entries = node.entries.map do |entry|
        "\"#{transpile entry.key}\": #{transpile entry.value}"
      end.join(", ")

      "{#{entries}}"
    end
  end
end
