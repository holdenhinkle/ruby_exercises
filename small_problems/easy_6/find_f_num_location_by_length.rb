# def find_fibonacci_index_by_length(length)
#   fibonacci_numbers = []
#   index = 1
#   loop do
#     if index == 1 || index == 2
#       fibonacci_numbers.push(1)
#     else
#       fibonacci_numbers.push(fibonacci_numbers[-2] + fibonacci_numbers.last)
#     end
#     break if fibonacci_numbers.last.to_s.length == length
#     index += 1
#   end
#   index
# end

def find_fibonacci_index_by_length(length)
  index = 3
  previous_num, current_num = 1, 1
  loop do
    previous_num, current_num = current_num, current_num + previous_num
    break if current_num.to_s.length == length
    index += 1
  end
  index
end

p find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
p find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
p find_fibonacci_index_by_length(10) == 45
p find_fibonacci_index_by_length(100) == 476
p find_fibonacci_index_by_length(1000) == 4782
p find_fibonacci_index_by_length(10000) == 47847