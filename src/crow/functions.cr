module Crow
  module Functions
    private def transpile(method : Crystal::Def)
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

    private def transpile(call : Crystal::Call)
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
        args = transpile call.args

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
  end
end
