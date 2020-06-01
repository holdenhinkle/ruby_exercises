require 'pry'

# Write a method that takes two sorted Arrays as arguments, and returns a new Array 
# that contains all elements from both arguments in sorted order.

# You may not provide any solution that requires you to sort the result array. 
# You must build the result array one element at a time in the proper order.

# Your solution should not mutate the input arrays.

# PEDAC

# P (Problem)
# Input: two arrays of integers
# Output: one array
# Requirements: Build a new array, one element at a time, from lowest to highest number.
# Rules: Cannot use a solution that sorts the result. You cannot mute the input arrays.
# Mental model: iterate through each array, compare minimums, add lowest minimum to new array.

# E (Example/Test Cases)
# See below

# D (Data Structure)
# Arrays

# A (Algorithm)
# Notes:
# min = min number in arrays
# max = max number in arrays
# iterate from min to max looking for each number
# if arr1 or arr2 has number
#   count occurances of number and add that many of the number to the results array
# return new array


# C (Code)
def merge(arr1, arr2)
  results = []
  min, max = min_max(arr1, arr2)
  min.upto(max) do |num|
    (arr1.count(num) + arr2.count(num)).times { results << num }
  end
  results
end

def min_max(arr1, arr2)
  if arr1.empty?
    return arr2.min, arr2.max
  elsif arr2.empty?
    return arr1.min, arr1.max
  else
    return [arr1.min, arr2.min].min, [arr1.max, arr2.max].max
  end
end

p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]



