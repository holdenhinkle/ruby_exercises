require 'pry'

NUMBERS = {
  0 => 'zero',
  1 => 'one',
  2 => 'two',
  3 => 'three',
  4 => 'four',
  5 => 'five',
  6 => 'six',
  7 => 'seven',
  8 => 'eight',
  9 => 'nine',
  10 => 'ten',
  11 => 'eleven',
  12 => 'twelve',
  13 => 'thirteen',
  14 => 'fourteen',
  15 => 'fifteen',
  16 => 'sixteen',
  17 => 'seventeen',
  18 => 'eighteen',
  19 => 'nineteen'
}

# def alphabetic_number_sort(arr)
#   hsh = {}
#   arr.each { |num| hsh[num] = NUMBERS[num] }
#   hsh.sort_by { |_, value| value }.to_h.keys
# end

# def alphabetic_number_sort(arr)
#   arr.sort_by { |num| NUMBERS[num] }
# end

def alphabetic_number_sort(arr)
  arr.sort { |a, b| NUMBERS[a] <=> NUMBERS[b] }
end


p alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]