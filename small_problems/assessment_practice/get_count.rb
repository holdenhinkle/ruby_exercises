# Return the number (count) of vowels in the given string.
# We will consider a, e, i, o, and u as vowels.
# The input string will only consist of lower case letters and/or spaces.

# input: string of lower case letters and/or spaces.
# output: integer which represents the number of vowels

# problem:
# given a string (the input as defined above), count the number of vowels in the string.

# algorithm:
# create an array of vowels
# create a variable called num_vowels and set it to 0
# conver the string to an array of chars
# interate through the chars (letters) array using each
# in the each block, if the letter is included in the array of vowels
# if it is, increase the num_vowels variable by 1, otherwise skip the letter
# return num_vowels

VOWELS = %w[a e i o u]

def get_count(string)
  num_vowels = 0
  string.chars.each do |letter|
    num_vowels += 1 if VOWELS.include?(letter)
  end
  num_vowels 
end

# Test cases:
p get_count("abracadabra") == 5
p get_count("chumbawamba") == 4