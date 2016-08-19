require "../spec_helper"

describe Crow do
  it "should convert simple case statements" do
    crystal = <<-CR
    value = "foo"
    case value
    when "foo"
      p "yes"
    when "bar"
      p "no"
    else
      p "hiyaa"
    end
    CR

    flow = <<-JS
    const value = "foo";
    switch (value) {
    case "foo":
      console.log("yes");
      break;
    case "bar":
      console.log("no");
      break;
    default:
      console.log("hiyaa");
      break;
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should support case statements without default" do
    crystal = <<-CR
    value = "foo"
    case value
    when "foo"
      p "yes"
    when "bar"
      p "no"
    end
    CR

    flow = <<-JS
    const value = "foo";
    switch (value) {
    case "foo":
      console.log("yes");
      break;
    case "bar":
      console.log("no");
      break;
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should convert case statements comparing types to if statements" do
    crystal = <<-CR
    value = "foo"
    case value
    when Foo
      p "yes"
    when Bar
      p "no"
    else
      p "hiyaa"
    end
    CR

    flow = <<-JS
    const value = "foo";
    if (value instanceof Foo) {
      console.log("yes");
    } else if (value instanceof Bar) {
      console.log("no");
    } else {
      console.log("hiyaa");
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should raise an exception when conditionless case statements are found" do
    crystal = <<-CR
    case
    when true
      p "yes"
    when false
      p "no"
    else
      p "hiyaa"
    end
    CR

    exception_raised = false

    begin
      Crow.convert(crystal)
    rescue e
      exception_raised = true
      e.message.should match /Case statements without conditions cannot be transpiled./
      e.message.should match %r{See https://github.com/geppetto-apps/crow/issues/8/}
    ensure
      Crow.strict = false
    end

    exception_raised.should eq true
  end
end
