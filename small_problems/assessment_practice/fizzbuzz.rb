# Write a short program that prints each number from 1 to 100 on a new line. 

# For each multiple of 3, print "Fizz" instead of the number. 

# For each multiple of 5, print "Buzz" instead of the number. 

# For numbers which are multiples of both 3 and 5, print "FizzBuzz" instead of the number.
def fizzbuzz(start_num, end_num)
  results = []
  start_num.upto(end_num) do |num|
    if num % 3 == 0 && num % 5 == 0
      results << "FizzBuzz"
    elsif num % 5 == 0
      results <<  "Buzz"
    elsif num % 3 == 0
      results <<  "Fizz"
    else
      results <<  num
    end
  end
  results.join(', ')
end

p fizzbuzz(5, 76)