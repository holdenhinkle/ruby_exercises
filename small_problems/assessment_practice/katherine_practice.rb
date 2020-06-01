# Given a string of words, you need to find the highest scoring word.

# Each letter of a word scores points according to it's position in the alphabet:
# a = 1, b = 2, c = 3 etc.

# You need to return the highest scoring word as a string.

# If two words score the same, return the word that appears earliest in the original string.

# All letters will be lowercase and all inputs will be valid.

# input: string
# output: string
# rules: asign a value to each string which will be the sum of the values assigned to each letter of the string. the string with the highest value is returned

# algorithm:
# split the string into an array of words
# create a results local variable within the method that we initialize to nil. This result variable will store that word with the highest value
# iterate through the array of words
# covert each word into an array of characters
# iterate through each character
# sum the value of each character in the word
# if the sum is greater than the word in the results variable we will resassign results to the new word
# return result

LETTERS = [*?a..?z]

def alphabet_score(str)
  words = str.split 
  best_word = ''
  words.each do |word|
    best_word = word if word_value(word) > word_value(best_word)
  end
  best_word
end

def word_value(word)
  word.chars.map { |letter| LETTERS.index(letter) + 1 }.sum
end

p alphabet_score('man i need a taxi up to ubud') == 'taxi'
p alphabet_score('what time are we climbing up the volcano') == 'volcano'
p alphabet_score('take me to semynak') == 'semynak'
p alphabet_score('aa b') == 'aa'
