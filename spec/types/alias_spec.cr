require "../spec_helper"

describe Crow do
  it "should keep type aliases" do
    crystal = <<-CR
    alias MyNumber = Int32
    CR

    flow = <<-JS
    type MyNumber = number;
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should keep nilable type aliases" do
    crystal = <<-CR
    alias MyNumber = Int32?
    CR

    # TODO: Maybe allow ?number syntax
    flow = <<-JS
    type MyNumber = number | void;
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should keep type aliases of union types" do
    crystal = <<-CR
    alias MyType = Int32 | String
    CR

    flow = <<-JS
    type MyType = number | string;
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should keep type aliases of typed arrays" do
    crystal = <<-CR
    alias MyArrayType = Array(String)
    CR

    flow = <<-JS
    type MyArrayType = string[];
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should keep other parametric types" do
    crystal = <<-CR
    alias MyType = Foo(Bar)
    CR

    flow = <<-JS
    type MyType = Foo<Bar>;
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should keep tuple type definitions" do
    crystal = <<-CR
    alias MyType = {Foo, Bar, Pipe}
    CR

    flow = <<-JS
    type MyType = [Foo, Bar, Pipe];
    JS

    Crow.convert(crystal).should eq flow
  end

  it "should keep proc type definitions" do
    crystal = <<-CR
    alias FnType = Int32 -> String
    CR

    flow = <<-JS
    type FnType = (number): string;
    JS

    Crow.convert(crystal).should eq flow
  end
end
