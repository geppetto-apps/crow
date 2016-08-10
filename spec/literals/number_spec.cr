require "../spec_helper"

describe Crow do
  it "should convert numbers correctly" do
    crystal = <<-CR
      p 125921
      p 125921.25
      p -125
      p -125.21
    CR
    flow = <<-JS
    console.log(125921);
    console.log(125921.25);
    console.log(-125);
    console.log(-125.21);
    JS

    Crow.convert(crystal).should eq flow
  end
end
