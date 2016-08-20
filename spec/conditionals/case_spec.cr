require "../spec_helper"

describe Crow do
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
