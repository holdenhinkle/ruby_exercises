require 'pry'

def reverse!(list)
  list.sort! { |a, b| b <=> a }
end

def reverse!(list)
  unless list.size <= 1
    index = list.length - 2
    loop do 
      element = list.delete_at(index)
      list.push(element)
      break if index == 0
      index -= 1
    end
  end
  list
end

p list = [1,2,3,4]
result = reverse!(list) # => [4,3,2,1]
p list == [4, 3, 2, 1]
p list.object_id == result.object_id

p list = %w(a b c d e)
reverse!(list) # => ["e", "d", "c", "b", "a"]
p list == ["e", "d", "c", "b", "a"]

p list = ['abc']
reverse!(list) # => ["abc"]
p list == ["abc"]

p list = []
reverse!(list) # => []
p list == []