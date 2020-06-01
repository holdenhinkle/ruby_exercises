require 'pry'

# Write a method that takes a 3 x 3 matrix in Array of Arrays format and 
# returns the transpose of the original matrix. Note that there is a 
# Array#transpose method that does this -- you may not use it for this 
# exercise. You also are not allowed to use the Matrix class from the 
# standard library. Your task is to do this yourself.

# [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

# 0, 1, 2
# 3, 4, 5
# 6, 7, 8

# [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
# 0, 3, 6
# 1, 4, 7
# 2, 5, 8

# PEDAC

# P (Problem)
# Input: array with 3 sub-arrays that each contain 3 integers
# Output: new array with 3 sub-arrays that each contain 3 integers
# Requirements: 
# Rules: 
# Mental model: iterate through the array, pushing values to new array

# E (Example/Test Cases)
# new_matrix = transpose(matrix)

# p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
# p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

# D (Data Structure)
# Array

# A (Algorithm)
# create new_matrix empty array
# iterate through array using each
# iterate through the subarray with each_with_index
# grab element of each subarray and push into idx, idx +1, idx + 2 of new array
# return new array.

# C (Code)

def transpose(arr)
  new_arr = [[], [], []]
  arr.each do |subarr|
    subarr.each_with_index { |element, idx| new_arr[idx] << element }
  end
  new_arr
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]
p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]



