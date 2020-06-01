# PEDAC

# P (Problem)
# Input: array
# Output: array
# Requirements: select the element out of the array if its index is a Fibonacci number
# Rules: 
# Mental model: Iterate through set of numbers and build new array of numbers that are fibinacci

# E (Example/Test Cases)
# fibinacci([1, 1, 2, 3, 4]) == [0, 1, 2, 3]

# D (Data Structure)
# array

# A (Algorithm)
# create results variable, empty array
# Iterate through given array, 0.upto(array.size - 1), create idx block parameter
# call is_fibinacci? method on each idx
# if true, add to results array
# return results array after upto completes

# is_fibinacci? method
# iterate through all numbers from 1 to index
# return fibinacci number for each interation
# return true if index = fibinacci number returned
# otherwise return false after interation is complete

# C (Code)
def fibinacci_indices(array)
  results = []
  0.upto(array.size - 1) do |index|
    results << index if is_fibinacci?(index)
  end
  results
end

def is_fibinacci?(index)
  return true if index == 2 || index == 3
  1.upto(index) do |n|
    return true if index == calculate_fibinacci(n)
  end
  false
end

def calculate_fibinacci(n)
  return 1 if n <= 2
  calculate_fibinacci(n - 1) + calculate_fibinacci(n - 2)
end

p fibinacci_indices([1, 1, 2, 3, 4])
p fibinacci_indices([1, 1, 2, 3, 4]) == [1, 2, 3]
p fibinacci_indices([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 11, 12, 13])
p fibinacci_indices([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 11, 12, 13])
