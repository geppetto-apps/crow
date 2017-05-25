module Crow
  module Loops
    private def transpile(node : Crystal::While)
      cond = transpile node.cond

      <<-JS
      while (#{cond}) {#{format_body(node.body)}}
      JS
    end

    private def transpile(node : Crystal::Until)
      cond = transpile node.cond

      <<-JS
      do {#{format_body(node.body)}} while (!(#{cond}))
      JS
    end

    private def transpile(node : Crystal::Next)
      "continue"
    end
  end
end
