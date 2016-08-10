require "../spec_helper"

describe Crow do
  it "should convert normal unless" do
    crystal = <<-CR
    unless true
      p "yes"
    end
    CR
    flow = <<-JS
    if (!true) {
      console.log("yes");
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should convert unless and else" do
    crystal = <<-CR
    unless true
      p "yes"
    else
      p "no"
    end
    CR
    flow = <<-JS
    if (!true) {
      console.log("yes");
    } else {
      console.log("no");
    }
    JS

    Crow.convert(crystal).should eq flow
  end
end
