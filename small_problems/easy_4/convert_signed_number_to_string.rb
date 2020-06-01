DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

def signed_integer_to_string(number)
  determine_sign(number) << integer_to_string(number)
end

def integer_to_string(number)
  number.abs.digits.reverse.map { |num| DIGITS[num] }.join
end

def determine_sign(number)
  sign = ''
  sign = '-' if number.negative?
  sign = '+' if number.positive?
  sign
end



p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'