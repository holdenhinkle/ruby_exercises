def perform_operation(num, operation)
  if operation == 's'
    sum = (1..num).inject(:+)
    puts "The sum of the integers between 1 and #{num} is #{sum}."
  else
    product = (1..num).inject(:*)
    puts "The product of the integers between 1 and #{num} is #{product}."
  end
end


puts "Please enter an integer greater than 0:"
num = gets.chomp.to_i

puts "Enter 's' to compute the sum, 'p' to compute the product:"
operation = gets.chomp

perform_operation(num, operation)