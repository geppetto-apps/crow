require "../spec_helper"

describe Crow do
  it "should convert arrays" do
    crystal = "[] of String"
    flow = "[]: string[]"

    Crow.convert(crystal).should eq flow
  end

  it "should convert false" do
    crystal = <<-CR
    [Class, "foo", 1]
    CR

    flow = <<-JS
    [Class, "foo", 1]
    JS

    Crow.convert(crystal).should eq flow
  end
end
