require "spec"
require "./support/*"
require "../src/crow"

Crow.logger.level = Logger::INFO

macro code_example(title, crystal, flow)
  it "Code Example: " + {{title}} do
    crystal = {{crystal}}
    flow = {{flow}}

    Crow.convert(crystal).should eq flow
  end
end
