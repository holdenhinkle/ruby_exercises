require 'pry'

def reverse(list)
  new_list = []
  list.reverse_each { |element| new_list.push(element) }
  new_list 
end

p reverse([1,2,3,4]) == [4,3,2,1]          # => true
p reverse(%w(a b c d e)) == %w(e d c b a)  # => true
p reverse(['abc']) == ['abc']              # => true
p reverse([]) == []                        # => true

puts list = [1, 2, 3]                      # => [1, 2, 3]
puts new_list = reverse(list)              # => [3, 2, 1]
puts list.object_id != new_list.object_id  # => true
puts list == [1, 2, 3]                     # => true
puts new_list == [3, 2, 1]                 # => true