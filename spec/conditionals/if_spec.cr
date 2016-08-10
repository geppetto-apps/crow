require "../spec_helper"

describe Crow do
  it "should convert normal ifs" do
    crystal = <<-CR
    if true
      p "yes"
    end
    CR
    flow = <<-JS
    if (true) {
      console.log("yes");
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should convert if and else" do
    crystal = <<-CR
    if true
      p "yes"
    else
      p "no"
    end
    CR
    flow = <<-JS
    if (true) {
      console.log("yes");
    } else {
      console.log("no");
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should convert elsif and else" do
    crystal = <<-CR
    if true
      p "yes"
    elsif false
      p "maybe"
    else
      p "no"
    end
    CR
    flow = <<-JS
    if (true) {
      console.log("yes");
    } else if (false) {
      console.log("maybe");
    } else {
      console.log("no");
    }
    JS

    Crow.convert(crystal).should eq flow
  end
end
