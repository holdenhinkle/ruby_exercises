NUMBERS = { '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '0' => 0 }

# The easiest way:
# def string_to_integer(string)
#   eval(string)
# end

def string_to_integer(string)
  integer = 0
  place = string.length - 1
  string.chars.each do |char|
    if place > 0
      integer += char == '0' ? 10 ** place : 10 ** place * NUMBERS[char]
    else
      integer += NUMBERS[char]
    end
    place -= 1
  end
  integer
end

p string_to_integer('4321') == 4321
p string_to_integer('570') == 570
p string_to_integer('57482349') == 57482349