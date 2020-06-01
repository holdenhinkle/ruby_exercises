def featured(num)
  num += 1
  num += 1 until num.odd? && num % 7 == 0
  loop do
    if num % 7 == 0 &&
       num == num.to_s.chars.uniq.join.to_i
      return num
    elsif num >= 9_876_543_210
      return "There is no possible number that fulfills those requirements"
    else
      num += 14
    end
  end
end

p featured(12) == 21
p featured(20) == 21
p featured(21) == 35
p featured(997) == 1029
p featured(1029) == 1043
p featured(999_999) == 1_023_547
p featured(999_999_987) == 1_023_456_987

p featured(9_999_999_999) # -> There is no possible number that fulfills those requirements
