OPERATORS = %w[+ - * / % **]

def perform_operations(num1, num2)
  OPERATORS.each do |operator| 
    puts "#{num1} #{operator} #{num2} = #{eval "#{num1} #{operator} #{num2}"}"
  end
end

puts "Enter the first number:"
num1 = gets.chomp

puts "Enter the second number:"
num2 = gets.chomp

perform_operations(num1, num2)