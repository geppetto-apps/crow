require "../spec_helper"

describe Crow do
  it "should treat modules as objects" do
    crystal = <<-CR
    module Foo
      module Bar
        def self.pipe
          return "dream"
        end
      end
    end
    CR

    flow = <<-JS
    const Foo = {
      Bar: {
        pipe() {
          return "dream";
        },
      },
    };
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should raise an error if module methods are defined" do
    crystal = <<-CR
    module Foo
      def pipe
        return "dream"
      end
    end
    CR

    expection_raised = false
    begin
      Crow.convert(crystal)
    rescue
      expection_raised = true
    end
    expection_raised.should eq true
  end
end
