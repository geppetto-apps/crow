require "../spec_helper"

describe Crow do
  it "should work with macros" do
    crystal = <<-CRYSTAL
    macro define_method(name, content)
      def {{name}}
        {{content}}
      end
    end

    define_method foo, 1
    define_method bar, 42
    CRYSTAL

    flow = <<-FLOW
    function foo() {
      return 1;
    }
    function bar() {
      return 42;
    }
    FLOW

    Crow.convert(crystal).should eq flow
  end
end
