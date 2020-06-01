# input: integer
# output: integer
# rules: calculate the sum of squares for an integer and subtract the square of sums of the integer

# algorithm:
# Call a helper method to calculate the sum of sqaures.
# Call a helper method to calculate the square of sums.
# Return the difference

# sum of sqaures helper method:
# iterate through the integer, creating an array containing 0 to the integer of squared integers, then sum them

# square of sum helper method:
# iteratethrough the integer, creating an array containing 0 to the integer, then square it


def sum_square_difference (num)
  sum_of_squares(num) - square_of_sums(num)
end

def sum_of_squares(num)
  sum = 0
  1.upto(num) do |n|
    sum += n
  end
  sum**2
end

def square_of_sums(num)
  sum = 0
  1.upto(num) do |n|
    sum += n**2
  end
  sum
end

p sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150