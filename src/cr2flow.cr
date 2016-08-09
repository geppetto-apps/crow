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
    if node.target.to_s.starts_with? "@"
      "this." + transpile(node.to_s.sub(/^@/, "")) + ";"
    else
      "const " + transpile node.to_s + ";"
    end
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

  private def self.transpile(klass : Crystal::ClassDef)
    class_name = klass.name.to_s
    if klass.superclass
      class_name += " extends #{klass.superclass.to_s}"
    end

    class_body = format_body(transpile(klass.body))

    <<-JS
    class #{class_name} {#{class_body}}
    JS
  end

  private def self.transpile(method : Crystal::Def)
    name = method.name
    name = "constructor" if name == "initialize"
    if method.receiver && method.receiver.to_s == "self"
      name = "static #{name}"
    end

    args = method.args.map do |arg|
      val = "#{arg.name}"
      case arg.restriction
      when Crystal::Path
        val += " : #{arg.restriction.to_s}"
      end
      val
    end

    method_body = format_body(transpile(method.body))

    <<-JS
    #{name}(#{args.join(", ")}) {#{method_body}}
    JS
  end

  private def self.format_body(body)
    indented_body = body.split("\n").map do |line|
      "  #{line}"
    end.join("\n")

    "\n#{indented_body}\n".gsub(/\A\s+\Z/, "")
  end
end
