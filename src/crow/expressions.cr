require "./ast/*"

module Crow
  module Expressions
    private def transpile(node : Crystal::Expressions)
      Private.apply_let_and_const(node.expressions).map do |node|
        transpile node
      end.join("\n")
    end

    module Private
      def self.apply_let_and_const(expressions : Array(Crystal::ASTNode))
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
            let.target = AST::LetVar.new(target.name)
            defined.delete target
          end
        end

        defined.values.each do |const|
          target = const.target
          case target
          when Crystal::Var
            const.target = AST::ConstVar.new(target.name)
          end
        end

        expressions
      end
    end
  end
end
