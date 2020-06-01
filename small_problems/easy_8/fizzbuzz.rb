def fizzbuzz(num1, num2)
  result = []
  num1.upto(num2) do |n|
    result.push(fizzbuzz_value(n))
  end
  puts result.join(', ')
end

def fizzbuzz_value(n)
  if n % 3 == 0 && n % 5 == 0
    "FizzBuzz"
  elsif n % 5 == 0
    "Buzz"
  elsif n % 3 == 0
    "Fizz"
  else
    n
  end
end

fizzbuzz(1, 15)