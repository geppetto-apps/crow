require "tempfile"
require "./spec_helper"

def execute_cr(path)
  `crystal #{path}`.strip
end

def execute_js(path)
  `node "#{path}"`.strip
end

describe Crow do
  Dir["examples/**/*.cr"].each do |filepath|
    it filepath do
      expected_result = execute_cr(filepath)
      code = File.read(filepath)
      tempfile = Tempfile.open("js") { |file|
        file.print(Crow.convert(code, prelude: true))
      }
      tempfile.close
      begin
        actual_result = execute_js(tempfile.path)
        actual_result.should eq expected_result
        tempfile.unlink
      rescue e
        pp tempfile.path
        raise e
      end
    end
  end
end
