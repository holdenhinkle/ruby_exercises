# PEDAC

# P (Problem)
# Input: array with subarrays
# Output: new array
# Requirements: Write a method that takes an arbitrary matrix and rotates it 90 degrees clockwise as shown above.
# Rules: 
# Mental model: 

# E (Example/Test Cases)
# See below

# D (Data Structure)
# Array

# A (Algorithm)

# 90 DEGREES - DONE
# Before:
# [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

# 0, 1, 2
# 3, 4, 5
# 6, 7, 8

# After:
# 6, 3, 0
# 7, 4, 1
# 8, 5, 2
# Same as my last algorithm, but instead of pushing each element into the new_arr, 
# we unshift it (first element is last, instead of first):

# 180 DEGREES - DONE
# Before:
# [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

# 0, 1, 2
# 3, 4, 5
# 6, 7, 8

# After:
# 8, 7, 6
# 5, 4, 3
# 2, 1, 0
# Each row is reversed.
# => CREATE TEST EXAMPLE FOR WHEN MATRIX SHAPE CHANGES (IE 2 X 4, ETC)

# 270 DEGREES
# Before:
# [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

# 0, 1, 2
# 3, 4, 5
# 6, 7, 8

# After:
# 2, 5, 8
# 1, 4, 7
# 0, 3, 6
# => NOT COMPLETED


# C (Code)
def rotate90(arr)
  new_arr = []
  arr[0].length.times { new_arr << [] }

  arr.each do |subarr|
    subarr.each_with_index { |element, idx| new_arr[idx].unshift(element) } 
  end

  new_arr
end

# def rotate180(arr)
#   new_arr = []

#   arr.each do |subarr|
#     new_arr.unshift(subarr.reverse)
#   end

#   new_arr
# end

# def rotate270(arr)
# end

# 90 degress
matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

# 180 degrees
# matrix3 = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))
# new_matrix4 = rotate180(matrix3)
# new_matrix5 = rotate270(matrix3)

p new_matrix1
p new_matrix2
p new_matrix3
# p new_matrix4
# p new_matrix5

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2
