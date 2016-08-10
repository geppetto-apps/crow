require "../spec_helper"

describe Cr2flow do
  it "should convert nil to undefined" do
    crystal = <<-CRYSTAL
    nil
    CRYSTAL

    flow = <<-FLOW
    undefined
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end
end
