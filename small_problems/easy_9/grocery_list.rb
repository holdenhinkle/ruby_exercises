# def buy_fruit(arr)
#   arr.map { |sub| [sub[0]] * sub[1] }.flatten
# end

def buy_fruit(arr)
  arr.map { |fruit, quantity| [fruit] * quantity }.flatten
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]