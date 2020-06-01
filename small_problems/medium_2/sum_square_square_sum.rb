# def sum_square_difference(num)
#   square_of_the_sum(num) - sum_of_the_squares(num)
# end

# def square_of_the_sum(num)
#   sum = 0
#   1.upto(num) do |n|
#     sum += n
#   end
#   sum**2
# end

# def sum_of_the_squares(num)
#   sum = 0
#   1.upto(num) do |n|
#     sum += n**2
#   end
#   sum
# end

def sum_square_difference(num)
  arr = [*1..num]
  square_of_the_sum = arr.sum**2
  sum_of_the_squares = arr.sum { |n| n**2 }
  square_of_the_sum - sum_of_the_squares
end

# -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)

p sum_square_difference(3)
p sum_square_difference(10)
p sum_square_difference(1)
p sum_square_difference(100)

p sum_square_difference(3) == 22
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150