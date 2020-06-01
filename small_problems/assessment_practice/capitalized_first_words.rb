# Write a method that takes a string and returns a new string with
# each word capitalized.

# Words are any sequence of non-blank characters.

# input: string of words
# output: new string
# problem: capitalize each word
# data structure: string
# algorithm:
# convert string to array of words
# map through the words
# iterate through the array and capitalize each word using .capitalize method
# join the array back together with .join(' '), which is the return value of the method

# def word_cap(str)
#   str.split.map { |word| word.capitalize }.join(' ')
# end

def word_cap(str)
  str.split.map(&:capitalize).join(' ')
end

p word_cap("four score and seven")
p word_cap("very good, that was a good exercise!")