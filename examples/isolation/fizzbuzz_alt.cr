i = 0
until i == 100
  i += 1
  if i % 5 == 0 && i % 3 == 0
    puts "FizzBuzz"
  elsif i % 3 == 0
    puts "Fizz"
  elsif i % 5 == 0
    puts "Buzz"
  end
end
