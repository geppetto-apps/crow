require "../spec_helper"

describe Crow do
  it "should convert begin/rescue blocks" do
    crystal = <<-CR
    begin
      raise "This is an exception."
    rescue e
      p "This block rescues the exception"
    end
    CR

    flow = <<-JS
    try {
      throw new Error("This is an exception.");
    } catch (e) {
      console.log("This block rescues the exception");
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should keep named exception vars" do
    crystal = <<-CR
    begin
      raise "This is an exception."
    rescue ex
      p ex
    end
    CR

    flow = <<-JS
    try {
      throw new Error("This is an exception.");
    } catch (e) {
      const ex = e;
      console.log(ex);
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should support ensure/finally" do
    crystal = <<-CR
    begin
      raise "This is an exception."
    rescue e
      p "This block rescues the exception"
    ensure
      p "This block always run"
    end
    CR

    flow = <<-JS
    try {
      throw new Error("This is an exception.");
    } catch (e) {
      console.log("This block rescues the exception");
    } finally {
      console.log("This block always run");
    }
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should convert specific handlers" do
    crystal = <<-CR
    begin
      function_accessing_array()
    rescue iex : IndexError
      p "We got an index error:", iex
    rescue ex : Exception | ArgumentError
      p "Default exception or argument error"
    end
    CR

    flow = <<-JS
    try {
      function_accessing_array();
    } catch (e) {
      if (e instanceof IndexError) {
        const iex = e;
        console.log("We got an index error:", iex);
      } else if (e instanceof Exception || e instanceof ArgumentError) {
        const ex = e;
        console.log("Default exception or argument error");
      }
    }
    JS

    Crow.convert(crystal).should eq flow
  end
end
