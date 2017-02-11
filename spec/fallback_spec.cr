require "./spec_helper"

describe Crow do
  it "should log fallback usage" do
    io = IO::Memory.new
    Crow.logger = Logger.new(io)
    Crow.log_fallback_usage Crystal::Var.new("foo")
    io.to_s.should match /Using fallback for node with type Crystal::Var/
  end

  context "when strict flag is on" do
    it "should raise an exception" do
      Crow.strict = true
      exception_raised = false

      begin
        Crow.log_fallback_usage Crystal::Var.new("foo")
      rescue e
        exception_raised = true
        e.message.should match /Fallback is not allowed in strict mode./
        e.message.should match /Attempted to transpile a node of type Crystal::Var./
      ensure
        Crow.strict = false
      end

      exception_raised.should eq true
    end
  end
end
