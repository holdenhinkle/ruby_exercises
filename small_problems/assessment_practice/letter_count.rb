# You need to count letters in a given string and return the letter count 
# in a hash with 'letter' as key and count as 'value'.

# input: string of lowercase letters
# output: hash, where the keys are symbols of individual letters and the value is an integer
# problem: count how many times each letter in a string appears in the string. Each unique letter
# in a string should be a hash and the number of times that letter appears in the string should be the
# value of the hash.

# algorithim:
# create an empty hash
# convert the string to an array of chars
# iterate through the array one letter at a time
# upon each iteration check to see if the letter is a key in the hash
#   if it is a key, increase the corresonding value by 1
#   else had the letter to the hash with a value of one.
# return the hash

def letter_count(string)
  letters = Hash.new(0)
  string.each_char do |letter|
    letters[letter.to_sym] += 1
  end
  letters
end

# Text cases:
p letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1}
p letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}