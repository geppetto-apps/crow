require "../spec_helper"

describe Cr2flow do
  it "should convert char correctly" do
    crystal = <<-CR
      p 'h' + 'i'
    CR
    flow = <<-JS
    console.log('h' + 'i');
    JS

    Cr2flow.convert(crystal).should eq flow
  end
end
