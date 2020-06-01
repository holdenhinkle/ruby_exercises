# input: integer and string. the string represents the what the user wants to do
# output: a string which outputs a calculation
# problem: sum or determine the product from 1 to the integer the user entered
# data structure: integer and string
# algorithm:
# create a hash that has the compute options:
# hsh = { s: "sum", p: "product"}
# ask for integer
# store it in integer variable
# ask for sum or product
# store it in string variable
# call an orchestration method with the integer and the string
# orchestration method:
# puts sentence that says:
# "The [calculation] of of the integers between 1 and [number entered] is [result]"
# [calculation] - string interpolation for the desired computation
# [number entered] - string interpolation for the number entered
# [result] - string interpolation for the result

# result helper methods:
# sum
# iterate from 1 to the number entered using reduce with the symbol :+

# product
# iterate from 1 to the number entered using reduce with the symbol :*

OPERATIONS = { s: "sum", p: "product"}

def display_result(int, operation)
  puts "The #{OPERATIONS[operation.to_sym]} of the ints between 1 and #{int} is #{calc(int, operation)}."
end

def calc(int, operation)
  operation == 's' ? sum(int) : product(int)
end

def sum(int)
  1.upto(int).reduce(:+)
end

def product(int)
  1.upto(int).reduce(:*)
end

puts "Enter an integer greater than 0:"
int = gets.chomp.to_i
puts "Enter s to compute the sum or p to compute the product:"
operation = gets.chomp.downcase

display_result(int, operation)
