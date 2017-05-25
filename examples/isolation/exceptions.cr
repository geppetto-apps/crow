begin
  raise "This is an exception."
rescue e
  puts "This block rescues the exception: #{e.message}"
ensure
  puts "And this is always printed"
end
