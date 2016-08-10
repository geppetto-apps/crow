require "../spec_helper"

describe Crow do
  it "should set global variables to the global scope" do
    crystal = <<-CR
    $foo = "bar"
    CR

    flow = <<-JS
    global.foo = "bar";
    JS

    Crow.convert(crystal).should eq flow
  end
end
