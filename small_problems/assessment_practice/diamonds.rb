# Write a method that displays a 4-pointed diamond in an n x n grid, 
# where n is an odd integer that is supplied as an argument to the method. 
# You may assume that the argument will always be an odd integer.

# input: integer, odd
# output: consecutive strings
# problem: take an integer which represents the width of a grid. create a 4-pointed
# diamond in the grid.
# data structure: string for each line of the diamond
# algorithm:

# display the first half of the diamond:
# iterate through the given integer using upto starting at 1 going up to the integer
# skip the iteration if n is even
# puts a * character and multiply it by n and then center it using the integer as the argment for the center method

# display the second half of the diamond:
# iterate through the given integer using downto starting at integer - 1 going downto to the 1
# skip the iteration if n is even
# puts a * character and multiply it by n and then center it using the integer as the argment for the center method

def diamond(num)
  1.upto(num) do |n|
    next if n.even?
    puts ("*" * n).center(num)
  end

  (num - 2).downto(1) do |n|
    next if n.even?
    puts ("*" * n).center(num)
  end
end

diamond(1)
diamond(3)
diamond(9)