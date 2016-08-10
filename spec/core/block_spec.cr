require "../spec_helper"

describe Crow do
  it "should convert named blocks" do
    crystal = <<-CR
    fn = -> {
      p "This is a block"
    }
    CR

    flow = <<-JS
    function fn() {
      console.log("This is a block");
    };
    JS

    Crow.convert(crystal).should eq flow
  end
end
