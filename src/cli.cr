require "commander"
require "./cr2flow.cr"

cli = Commander::Command.new do |cmd|
  cmd.use = "cr2flow"
  cmd.long = "Transpile Crystal to Flow (JS) code."

  cmd.flags.add do |flag|
    flag.name = "verbose"
    flag.short = "-v"
    flag.long = "--verbose"
    flag.default = false
    flag.description = "Enable more verbose logging."
  end

  cmd.run do |options, arguments|
    basename = nil
    input = if arguments.size == 0
      STDIN.gets_to_end
    else
      input_path = arguments[0]
      basename = File.basename(input_path).gsub(/\.[^.]+$/, "")

      File.read(input_path)
    end
    output = Cr2flow.convert(input)

    if basename
      output_path = "#{basename}.js.flow"
      File.write(output_path, output)
    else
      STDOUT.puts output
    end
  end
end

Commander.run(cli, ARGV)
