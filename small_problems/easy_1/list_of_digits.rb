def digit_list(num)
   num.to_s.chars.map { |num| num.to_i }
end

# def digit_list(number)
#   number.to_s.chars.map(&:to_i)
# end

puts digit_list(12345) == [1, 2, 3, 4, 5]
puts digit_list(7) == [7]
puts digit_list(375290) == [3, 7, 5, 2, 9, 0]
puts digit_list(444) == [4, 4, 4]