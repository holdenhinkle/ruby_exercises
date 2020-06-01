# A consonant is any letter of the alphabet except a, e, i ,o, u. The consonant substrings in 
# the word "zodiacs" are z, d, cs. Assuming a = 1, b = 2 ... z = 26, the values of these 
# substrings are 26 ,4, 22 because z = 26,d = 4,cs=3+19=22. The maximum value of these 
# substrings is 26. Therefore, solve("zodiacs") = 26.

# Given a lowercase string that has alphabetic characters only and no spaces, return 
# the highest value of consonant substrings.

# input: string, lowercase, only letters
# output: integer which represents the consonant with the greatest value (see below).
# problem: find the consonsant substring in the string with the highest value. A substring can be 
# just one consonsant or in can be consectuve consonsants. The value for each substring is the sum of
# the value of each letter in the substring based off it's position in the alphabet. 

# algorthim:
# create global variable: array of the alphabet, a-z
# create global variable: array of vowels
# create results variable and set it to 0
# create sum_of_values varaible and set it to 0
# convert string to array of chars (letters)
# iterate through each char by index
# if current letter is a consonsant, look up the value of the letter and at it to the sum_of_values varaible
#   if next letter in the array (index + 1) is a consonsant, next
#   else reassign results to current value if current value is greater than results
# return results

VOWELS = %w[a e i o u]
LETTERS = [*?a..?z]
CONSONANTS = LETTERS.reject { |letter| VOWELS.include?(letter) }

def solve(str)
  highest_value = 0
  sum_of_values = 0
  str.chars.each_with_index do |letter, idx|
    next if VOWELS.include?(letter)
    sum_of_values += LETTERS.index(letter) + 1
    next if CONSONANTS.include?(str[idx + 1])
    highest_value = sum_of_values if sum_of_values > highest_value
    sum_of_values = 0
  end
  highest_value
end

# Test cases:
p solve("zodiacs") == 26
p solve("chruschtschov") == 80
p solve("khrushchev") == 38
p solve("strength") == 57
p solve("catchphrase") == 73
p solve("twelfthstreet") == 103
p solve("mischtschenkoana") == 80