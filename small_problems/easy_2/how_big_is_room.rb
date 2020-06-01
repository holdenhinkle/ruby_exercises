SQUARE_FOOT = 10.7639 

def calculate_square_meters(length, width)
  length * width
end

def calculate_square_feet(length, width)
  (length * width * SQUARE_FOOT).round(2)
end

puts "Length:"

length = gets.chomp.to_i

puts "Width:"

width = gets.chomp.to_i

puts "The area of the room is #{calculate_square_meters(length, width)} square meters (#{calculate_square_feet(length, width)} square feet)."