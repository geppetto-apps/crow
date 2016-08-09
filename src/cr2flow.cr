require "./cr2flow/*"
require "crystal/compiler/crystal/syntax.cr"

module Cr2flow
  def self.convert(crystal_source_code)
    parser = Crystal::Parser.new(crystal_source_code)
    node = Crystal::Expressions.from(parser.parse)
    transpile node
  end

  private def self.transpile(content : String)
    content
  end

  private def self.transpile(node : Crystal::Expressions)
    node.expressions.map do |node|
      transpile node
    end.join("\n")
  end

  private def self.transpile(node : Crystal::ASTNode)
    transpile node.to_s
  end

  private def self.transpile(node : Crystal::StringInterpolation)
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

  private def self.transpile(node : Crystal::Assign)
    "const " + transpile node.to_s + ";"
  end

  private def self.transpile(call : Crystal::Call)
    method = call.name
    case call.name
    when "+"
      "#{call.obj} + #{call.args[0]}"
    when "-"
      "#{call.obj} - #{call.args[0]}"
    when "*"
      "#{call.obj} * #{call.args[0]}"
    when "/"
      "#{call.obj} / #{call.args[0]}"
    else
      args = call.args.map do |arg|
        transpile arg
      end

      method = "console.log" if method == "p"
      "#{method}(#{args.join(", ")});"
    end
  end
end
