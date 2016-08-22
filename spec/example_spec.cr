# Runs examples generated from `examples/*.md` files
renderer = Markdown::ExampleSpecRenderer.new

Dir["examples/**/*.md"].each do |filepath|
  Markdown::Parser.new(File.read(filepath), renderer).parse
end
