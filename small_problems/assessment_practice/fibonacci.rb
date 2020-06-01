# Write a recursive method that computes the nth Fibonacci number, 
# where nth is an argument to the method.

# The Fibonacci series is a sequence of numbers starting with 1 and 1 
# where each number is the sum of the two previous numbers: 
# the 3rd Fibonacci number is 1 + 1 = 2, the 4th is 1 + 2 = 3, 
# the 5th is 2 + 3 = 5, and so on.

# Recursive methods have 3 primary qualities:
# 1)They call themselves at least once.
# 2) They have a condition that stops the recursion (n == 1 above).
# 3) They use the result returned by themselves.

# PEDAC

# P (Problem)
# Input: Integer
# Output: Integer which is the sum of the two consectuve numbers of the nth Fibonacci number
# Requirements: Write a recursive method that compuetes the nth Fibonacci number, where nth is the argument to the method.
# Rules: The input is a positive integer. 
# Mental model:  

# E (Example/Test Cases)
# fibonacci(1) == 1
# fibonacci(2) == 1
# fibonacci(3) == 2
# fibonacci(4) == 3
# fibonacci(5) == 5
# fibonacci(12) == 144
# fibonacci(20) == 6765

# D (Data Structure)
# Integer that tracks the number of Fibonacci numbers that have been iterated through, and the sum of the current Fibonacci sequence.

# A (Algorithm)
# if input is 1, return 1
# if input is 2, return 1
# fibonacci number = n + n - 1


# C (Code)
def fibonacci(n)
  return 1 if n <= 2
  fibonacci(n - 1) + fibonacci(n - 2)
end

# fibonacci(1) == 1
# fibonacci(2) == 1
# p fibonacci(3) #== 2
# p fibonacci(4) #== 3
# fibonacci(5) == 5
# p fibonacci(6)
# p fibonacci(7)
p fibonacci(8)
# p fibonacci(11)
# fibonacci(12) == 144
# fibonacci(20) == 6765
