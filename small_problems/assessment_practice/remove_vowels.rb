# input: array of strings
# output: array of string with the vowels removed from each string
# rules: the array is one level deep and the strings contain uppercase, lowercase, numbers, spaces and other punctuation.
# algorithm:
# create an array of all vowels
# Map through the array of strings
# map through the array of vowels
# call gsub on each string and replace each vowel with an empty string

# VOWELS = %w[a e i o u]

# def remove_vowels(arr)
#   arr.map do |str|
#     VOWELS.each { |vowel| str.gsub!(vowel, '') }
#     str
#   end
#     puts arr
# end

# def remove_vowels(arr)
#   arr.each do |str|
#     VOWELS.each { |vowel| str.gsub!(vowel, '') }
#   end
# end

def remove_vowels(arr)
  arr.each { |str| str.delete!('aeiou') }
end

p remove_vowels(['Holden', 'Farhan', 'Hadiya'])
p remove_vowels(['green', 'yellow', 'black', 'white'])
p remove_vowels(['Holden', 'Farhan', 'Hadiya']) == ['Hldn', 'Frhn', 'Hdy']
p remove_vowels(['green', 'yellow', 'black', 'white']) == ['grn', 'yllw', 'blck', 'wht']