require "../spec_helper"

describe Cr2flow do
  it "should convert true" do
    crystal = "true"
    flow = "true"

    Cr2flow.convert(crystal).should eq flow
  end

  it "should convert false" do
    crystal = "false"
    flow = "false"

    Cr2flow.convert(crystal).should eq flow
  end
end
