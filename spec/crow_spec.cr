require "./spec_helper"

describe Crow do
  it "should work with hello world" do
    crystal = <<-CRYSTAL
    p "Hello World"
    CRYSTAL

    flow = <<-FLOW
    console.log("Hello World");
    FLOW

    Crow.convert(crystal).should eq flow
  end

  it "should work with string assignment (const)" do
    crystal = <<-CRYSTAL
    text = "Hello World"
    p text
    CRYSTAL

    flow = <<-FLOW
    const text = "Hello World";
    console.log(text);
    FLOW

    Crow.convert(crystal).should eq flow
  end

  it "should work with string assignment (var)" do
    crystal = <<-CRYSTAL
    text = "Hello"
    text += " "
    text += "World"
    p text
    CRYSTAL

    flow = <<-FLOW
    let text = "Hello";
    text = text + " ";
    text = text + "World";
    console.log(text);
    FLOW

    Crow.convert(crystal).should eq flow
  end

  it "should work with concatenating strings" do
    crystal = <<-CRYSTAL
    p "Hello" + "World"
    CRYSTAL

    flow = <<-FLOW
    console.log("Hello" + "World");
    FLOW

    Crow.convert(crystal).should eq flow
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

    Crow.convert(crystal).should eq flow
  end

  it "should transpile arithmetic operations properly" do
    crystal = <<-CRYSTAL
    p 512 * 16 + 24 - 12
    CRYSTAL

    flow = <<-FLOW
    console.log((512 * 16) + 24 - 12);
    FLOW

    Crow.convert(crystal).should eq flow
  end
end
