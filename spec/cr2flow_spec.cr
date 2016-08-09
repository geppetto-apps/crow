require "./spec_helper"

describe Cr2flow do
  it "should work with hello world" do
    crystal = <<-CRYSTAL
    p "Hello World"
    CRYSTAL

    flow = <<-FLOW
    console.log("Hello World");
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end

  it "should work with string assignment" do
    crystal = <<-CRYSTAL
    text = "Hello World"
    p text
    CRYSTAL

    flow = <<-FLOW
    const text = "Hello World";
    console.log(text);
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end

  it "should work with concatenating strings" do
    crystal = <<-CRYSTAL
    p "Hello" + "World"
    CRYSTAL

    flow = <<-FLOW
    console.log("Hello" + "World");
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end

  it "should work with interpolated string" do
    crystal = <<-CRYSTAL
    who = "World"
    p "Hello \#{who}"
    CRYSTAL

    flow = <<-FLOW
    const who = "World";
    console.log(`Hello ${who}`);
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end

  it "should transpile arithmetic operations properly" do
    crystal = <<-CRYSTAL
    p 512 * 16 + 24 - 12
    CRYSTAL

    flow = <<-FLOW
    console.log((512 * 16) + 24 - 12);
    FLOW

    Cr2flow.convert(crystal).should eq flow
  end
end
