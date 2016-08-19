require "commander"
require "logger"

require "./crow.cr"

cli = Commander::Command.new do |cmd|
  cmd.use = "crow"
  cmd.long = "Transpile Crystal to Flow (JS) code."

  cmd.flags.add do |flag|
    flag.name = "version"
    flag.short = "-v"
    flag.long = "--version"
    flag.default = false
    flag.description = "Print version number and exit"
  end

  cmd.flags.add do |flag|
    flag.name = "no-strict"
    flag.long = "--no-strict"
    flag.default = false
    flag.description = "Disable strict mode (allow fallback transpilation)."
  end

  cmd.run do |options, arguments|
    if options.bool["version"]
      STDOUT.puts "Crow v#{Crow::VERSION}"
      next
    end

    Crow.logger = Logger.new(STDERR)
    Crow.strict = options.bool["strict"] && !options.bool["no-strict"]

    basename = nil
    input = if arguments.size == 0
              STDIN.gets_to_end
            else
              input_path = arguments[0]
              basename = File.basename(input_path).gsub(/\.[^.]+$/, "")

              File.read(input_path)
            end
    output = Crow.convert(input)

    if basename
      output_path = "#{basename}.js.flow"
      File.write(output_path, output)
    else
      STDOUT.puts output
    end
  end
end

Commander.run(cli, ARGV)
