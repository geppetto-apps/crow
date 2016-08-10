require "../spec_helper"

describe Crow do
  it "should convert hashes" do
    crystal = "{} of String => Int32"
    flow = "{}: { [key: string]: number }"

    Crow.convert(crystal).should eq flow
  end

  it "should convert hashes with contents (inferred type)" do
    crystal = <<-CR
      {
        class: Class,
        bar: "foo",
        el: 1
      }
    CR

    flow = <<-JS
    {"class": Class, "bar": "foo", "el": 1}
    JS

    Crow.convert(crystal).should eq flow
  end
end
