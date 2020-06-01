NUMBERS = { '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '0' => 0 }

SIGNS = %w(+ -)

def string_to_signed_integer(string)
  sign = determine_sign(string)
  string = strip_sign(string)
  sign * convert_to_integer(string)
end

def determine_sign(string)
  string.include?('-') ? -1 : 1
end

def strip_sign(string)
  string[0] = '' if SIGNS.include?(string[0])
  string
end

def convert_to_integer(string)
  integer = 0
  place = string.length - 1
  string.chars.each do |char|
    if place > 0 && char != '0'
      integer += char == '0' ? 10 ** place : 10 ** place * NUMBERS[char]
    else
      integer += NUMBERS[char]
    end
    place -= 1
  end
  integer
end

p string_to_signed_integer('4321') == 4321
p string_to_signed_integer('-570') == -570
p string_to_signed_integer('+100') == 100
