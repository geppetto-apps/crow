require "../spec_helper"

describe Crow do
  it "should convert char correctly" do
    crystal = <<-CR
      p 'h' + 'i'
    CR
    flow = <<-JS
    console.log('h' + 'i');
    JS

    Crow.convert(crystal).should eq flow
  end
end
