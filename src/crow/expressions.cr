module AST
  class InitialVar < Crystal::Var
  end
end

module Crow
  module Expressions
    private def transpile(node : Crystal::Expressions)
      Private.apply_var(node.expressions).map do |node|
        transpile node
      end.join("\n")
    end

    module Private
      def self.apply_var(expressions : Array(Crystal::ASTNode))
        defined = Hash(Crystal::ASTNode, Crystal::Assign).new
        vars = [] of Crystal::Assign

        expressions.each do |assign|
          case assign
          when Crystal::OpAssign
            if other_assign = defined[assign.target]?
              vars << defined[assign.target]
            end
          when Crystal::Assign
            if defined[assign.target]?
              vars << defined[assign.target]
            else
              defined[assign.target] = assign
            end
          end
        end

        defined.each do |name, assign|
          assign.target = AST::InitialVar.new(name.to_s)
        end

        expressions
      end
    end
  end
end
