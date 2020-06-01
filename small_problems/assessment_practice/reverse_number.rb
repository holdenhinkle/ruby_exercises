def reverse_number(num)
  num.to_s.reverse.to_i
end

p reverse_number(12345) == 54321
p reverse_number(12213) == 31221
p reverse_number(456) == 654
p reverse_number(12000) == 21 # No leading zeros in return value!
p reverse_number(12003) == 30021
p reverse_number(1) == 1