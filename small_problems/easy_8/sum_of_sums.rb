# def sum_of_sums(arr)
#   sum = 0
#   arr.each_with_index do |num, idx|
#     loop do
#       sum += arr[idx]
#       break if idx == 0
#       idx -= 1
#     end
#   end
#   puts sum
# end

def sum_of_sums(nums)
  sum = 0
  nums.map { |num| sum += num }.reduce(:+)
end

# sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
# sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
# sum_of_sums([4]) == 4
# sum_of_sums([1, 2, 3, 4, 5]) == 35

p sum_of_sums([3, 5, 2])
p sum_of_sums([1, 5, 7, 3])
p sum_of_sums([4])
p sum_of_sums([1, 2, 3, 4, 5])