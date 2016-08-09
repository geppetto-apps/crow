require "./spec_helper"

describe Cr2flow do
  it "should be able to convert classes" do
    crystal = <<-CRYSTAL
    class Foo
      def initialize(@label : String)
      end
    end
    CRYSTAL

    flow = <<-FLOW
    class Foo {
      constructor(label : String) {
        this.label = label;
      }
    }
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end

  it "should handle inheritance" do
    crystal = <<-CRYSTAL
    class Foo < Bar
    end
    CRYSTAL

    flow = <<-FLOW
    class Foo extends Bar {}
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end

  it "should handle static functions" do
    crystal = <<-CRYSTAL
    class Foo < Bar
      def self.pipe
      end
    end
    CRYSTAL

    flow = <<-FLOW
    class Foo extends Bar {
      static pipe() {}
    }
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end
end
