# select the element out of the array if its index is a Fibonacci number

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

def fibinacci_indices(array)
  results = []
  0.upto(array.size - 1) do |idx|
    results << array[idx] if is_fibinacci?(idx)
  end
  results
end

def is_fibinacci?(idx)
  return true if idx == 2 || idx == 3
  1.upto(idx) do |n|
    return true if idx == calculate_fibonacci(n)
  end
  false
end

def calculate_fibonacci(n)
  return 1 if n <= 2
  calculate_fibonacci(n - 1) + calculate_fibonacci(n - 2)
end

p fibinacci_indices([0, 1, 2, 3, 4, 5])
# p fibinacci_indices([1, 1, 2, 3, 4]) == [1, 2, 3]
# p fibinacci_indices([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 11, 12, 13])