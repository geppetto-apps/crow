module Crow
  module Formatting
    private def format_body(node : Crystal::ASTNode)
      format_body transpile(node)
    end

    def format_body(body : String)
      indented_body = body.split("\n").map do |line|
        "  #{line}"
      end.join("\n")

      "\n#{indented_body}\n".gsub(/\A\s+\Z/, "")
    end
  end
end
