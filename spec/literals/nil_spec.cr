require "../spec_helper"

describe Crow do
  it "should convert nil to undefined" do
    crystal = <<-CRYSTAL
    nil
    CRYSTAL

    flow = <<-FLOW
    undefined
    FLOW

    Crow.convert(crystal).should eq flow
  end
end
