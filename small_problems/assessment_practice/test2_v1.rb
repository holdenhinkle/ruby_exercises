# Write a function that takes in a string of one or more words,
# and returns the same string, but with all five or more letter words
#  reversed. Strings passed in will
#   consist of only letters and spaces. Spaces will be included only
#  when more than one word is present.

# input = string
# output = string
# rules = input is a string of one or more word which consists of only letters or spaces

# algorithm:
# create a method that takes a string as the argumnent
# split the string into an array of words
# iterate through each word
# if word is 5 or more letters in length, reverse it
# put the words back together into a sentence
# return the sentence

def spin_words(str)
  words = str.split
  results = words.map do |word|
    word.length >= 5 ? word.reverse! : word
  end
  words.join(' ')
end

p spin_words("Hey fellow warriors") == "Hey wollef sroirraw"
p spin_words("This is a test") == "This is a test"
p spin_words("This is another test") == "This is rehtona test"