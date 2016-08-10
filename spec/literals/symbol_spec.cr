require "../spec_helper"

describe Cr2flow do
  it "should convert symbols correctly" do
    crystal = <<-CR
      foo = :symbol
      bar = :other_symbol
    CR
    flow = <<-JS
    const foo = Symbol.for('symbol');
    const bar = Symbol.for('other_symbol');
    JS

    Cr2flow.convert(crystal).should eq flow
  end
end
