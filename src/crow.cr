require "compiler/crystal/syntax.cr"
require "./crow/*"

module Crow
  def self.convert(crystal_source_code)
    parser = Crystal::Parser.new(crystal_source_code)
    node = Crystal::Expressions.from(parser.parse)
    transpile node
  end

  private def self.transpile(content : String)
    content
  end

  private def self.transpile(node : Crystal::Expressions)
    apply_let_and_const(node.expressions).map do |node|
      transpile node
    end.join("\n")
  end

  private def self.transpile(node : Crystal::ASTNode)
    transpile node.to_s
  end

  private def self.transpile(node : Crystal::NilLiteral)
    "undefined"
  end

  private def self.transpile(node : Crystal::SymbolLiteral)
    "Symbol.for('#{node.value}')"
  end

  private def self.transpile(node : Crystal::ArrayLiteral)
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

  private def self.transpile(node : Crystal::HashLiteral)
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

  private def self.transpile(node : Crystal::NamedTupleLiteral)
    entries = node.entries.map do |entry|
      "\"#{transpile entry.key}\": #{transpile entry.value}"
    end.join(", ")

    "{#{entries}}"
  end

  private def self.transpile(node : Crystal::Path)
    case node.to_s
    when "Int32"
      "number"
    when "String"
      "string"
    else
      node.to_s
    end
  end

  private def self.transpile(node : Crystal::If)
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

  private def self.transpile(node : Crystal::Unless)
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
    "#{transpile node.target} = #{transpile node.value};"
  end

  private def self.transpile(node : Crystal::InstanceVar)
    "this." + transpile(node.to_s.sub(/^@/, ""))
  end

  private def self.transpile(node : ConstVar)
    "const " + transpile(node.to_s)
  end

  private def self.transpile(node : LetVar)
    "let " + transpile(node.to_s)
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
      if call.obj
        if method == "new"
          method = "#{method} #{call.obj}"
        else
          method = "#{call.obj}.#{method}"
        end
      end

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

  private def self.format_body(node : Crystal::ASTNode)
    format_body transpile(node)
  end

  private def self.format_body(body)
    indented_body = body.split("\n").map do |line|
      "  #{line}"
    end.join("\n")

    "\n#{indented_body}\n".gsub(/\A\s+\Z/, "")
  end

  private def self.apply_let_and_const(expressions : Array(Crystal::ASTNode))
    defined = Hash(Crystal::ASTNode, Crystal::Assign).new
    lets = [] of Crystal::Assign

    expressions.each do |assign|
      case assign
      when Crystal::Assign
        if defined[assign.target]?
          lets << defined[assign.target]
        else
          defined[assign.target] = assign
        end
      end
    end

    lets.each do |let|
      target = let.target
      case target
      when Crystal::Var
        let.target = LetVar.new(target.name)
        defined.delete target
      end
    end

    defined.values.each do |const|
      target = const.target
      case target
      when Crystal::Var
        const.target = ConstVar.new(target.name)
      end
    end

    expressions
  end
end
