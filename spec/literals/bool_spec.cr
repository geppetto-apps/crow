require "../spec_helper"

describe Crow do
  it "should convert true" do
    crystal = "true"
    flow = "true"

    Crow.convert(crystal).should eq flow
  end

  it "should convert false" do
    crystal = "false"
    flow = "false"

    Crow.convert(crystal).should eq flow
  end
end
