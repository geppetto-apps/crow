module Crow
  module Functions
    private def transpile(method : Crystal::Def)
      original_name = method.name

      name = original_name == "initialize" ? "constructor" : original_name
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

      method_body = if original_name == "initialize"
                      format_body(transpile(method.body))
                    else
                      format_body(transpile_with_return(method.body))
                    end

      if @@class_stack == 0
        name = "function #{name}"
      end

      <<-JS
      #{name}(#{args.join(", ")}) {#{method_body}}
      JS
    end

    private def transpile(call : Crystal::Call)
      method = call.name

      if @@macros[call.name]?
        return transpile_macro(call, @@macros[call.name])
      end

      case call.name
      when "+"
        "#{call.obj} + #{call.args[0]}"
      when "-"
        "#{call.obj} - #{call.args[0]}"
      when "*"
        "#{call.obj} * #{call.args[0]}"
      when "/"
        "#{call.obj} / #{call.args[0]}"
      when "<"
        "#{call.obj} < #{call.args[0]}"
      when "=="
        "#{call.obj} === #{call.args[0]}"
      else
        args = transpile call.args

        method = "console.log" if %w[p puts].includes? method
        method = "throw new Crow.RuntimeError" if method == "raise"

        if call.obj
          if method == "new"
            method = "#{method} #{call.obj}"
          else
            method = "#{call.obj}.#{method}"
          end
        end

        if context? :template_string
          "#{method}(#{args.join(", ")})"
        else
          "#{method}(#{args.join(", ")});"
        end
      end
    end

    private def transpile_with_return(node : Crystal::ASTNode)
      "return #{transpile(node)}"
    end

    private def transpile_with_return(node : Crystal::NumberLiteral)
      "return #{transpile(node)};"
    end

    private def transpile_with_return(node : Crystal::Nop)
      ""
    end
  end
end
