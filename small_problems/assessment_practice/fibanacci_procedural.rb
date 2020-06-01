# Rewrite your recursive fibonacci method so that it computes its results without recursion.

# PEDAC

# P (Problem)
# Input: Integer
# Output: Output
# Requirements: 
# Rules: Algorithm must be procedural, not recursive
# Mental model: Set a counter to that increments every time a number is reduced to 1 or 2

# E (Example/Test Cases)
# See below

# D (Data Structure)
# Integer variable

# A (Algorithm)
# set variable fibonacci_number = 0 which will be a counter
# iterate from 1 upto the argument using block paramenter num
# if num == 1 or 2 increment the counter by one and break out of the block
# if num > 2:
#   1. Loop through n - 1, reducing n and incrementing the counter until n <= 2
#   2. Loop through n - 2, reducing n and incrementing the counter until n <= 2
# Return the counter

# C (Code) 

# def fibonacci(num)
#   counter = 0
#   return 1 if n <= 2
#   3.upto(num) do |num|
#     loop do
#        n1 = call_method(num - 1)
#       counter += 1
#       break if n1 <= 2
#     end

#     loop do |n2|

#     end
#   end
# end

def fibonacci(nth)
  first, last = [1, 1]
  3.upto(nth) do
    binding.pry
    first, last = [last, first + last]
  end

  last
end

fibonacci(20) == 6765
fibonacci(100) == 354224848179261915075
fibonacci(100_001) # => 4202692702.....8285979669707537501