require "../spec_helper"

describe Crow do
  it "should convert symbols correctly" do
    crystal = <<-CR
      foo = :symbol
      bar = :other_symbol
    CR
    flow = <<-JS
    const foo = Symbol.for('symbol');
    const bar = Symbol.for('other_symbol');
    JS

    Crow.convert(crystal).should eq flow
  end
end
