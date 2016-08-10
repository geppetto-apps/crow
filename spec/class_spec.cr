require "./spec_helper"

describe Crow do
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

    Crow.convert(crystal).should eq flow
  end

  it "should handle inheritance" do
    crystal = <<-CRYSTAL
    class Foo < Bar
    end
    CRYSTAL

    flow = <<-FLOW
    class Foo extends Bar {}
    FLOW

    Crow.convert(crystal).should eq flow
  end

  it "should handle static functions" do
    crystal = <<-CRYSTAL
    class Foo < Bar
      def self.pipe
      end
    end
    Foo.pipe
    CRYSTAL

    flow = <<-FLOW
    class Foo extends Bar {
      static pipe() {}
    }
    Foo.pipe();
    FLOW

    Crow.convert(crystal).should eq flow
  end

  it "should handle initialization" do
    crystal = <<-CRYSTAL
    Foo.new("Pipe", "Dream")
    CRYSTAL

    flow = <<-FLOW
    new Foo("Pipe", "Dream");
    FLOW

    Crow.convert(crystal).should eq flow
  end
end
