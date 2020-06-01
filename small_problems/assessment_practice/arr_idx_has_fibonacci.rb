# Select the elements out of the array if its index is a Fibonacci number.

# P (Problem)
# Input: array
# Output: array
# Requirements: 
# Rules: array has positive integers
# Mental model: iterate through each num in array, select each num that is a Fibanacci number.

# E (Example/Test Cases)
# fibanacci_numbers([1, 2, 3]) = true
# fibanacci_numbers([6, 11, 20]) = false
# fibanacci_numbers([8, 14, 20]) = true
# fibanacci_numbers([7, 89, 4]) = true


# D (Data Structure)
# array

# A (Algorithm)
# select through the given array.
# check if each element in the array is_fibanacci?
# select returns an array upon completion

# C (Code) - v1
def fibanacci_numbers(arr)
  arr.select { |num| is_fibanacci?(num) }
end

def is_fibanacci?(num)
  return true if num == 2 || num == 3
  1.upto(num) { |n| return true if num == fibonacci(n) }
  false
end

def fibonacci(n)
  return 1 if n <= 2
  fibonacci(n - 1) + fibonacci(n - 2)
end

# C (Code) - v2
# def fibanacci_numbers(arr)
#   arr.select { |n| is_fibanacci?(n) }
# end

# def is_fibanacci?(n)
#   # https://www.geeksforgeeks.org/check-number-fibonacci-number/
#   Math.sqrt(5 * n**2 + 4) % 1 == 0 || Math.sqrt(5 * n**2 - 4) % 1 == 0
# end

p fibanacci_numbers([]) == []
p fibanacci_numbers([8]) == [8]
p fibanacci_numbers([1, 2, 3]) #== [1, 2, 3]
p fibanacci_numbers([6, 11, 20]) #== []
p fibanacci_numbers([8, 14, 20]) #== [8]
p fibanacci_numbers([7, 89, 4]) #== [89]
p fibanacci_numbers([0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144])


