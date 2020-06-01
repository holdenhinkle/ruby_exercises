# input: str
# output: str
# problem: swap the first and last characters of each word in a string. return the string.
# data structure: use an array to collect he updated words
# algorithm:
# split the string into an array of words
# map through the array of words
# upon each iteration in the block, conver the word to an array
# assign first character to last character and last character to first character using .first and .last arracy methods
# join the array which is returned from the black to map
# join the return array from map with an empty space

def swap(str)
  new_string = str.split.map do |word|
    chars_array = word.chars
    chars_array[0], chars_array[-1] = chars_array[-1], chars_array[0]
    chars_array.join
  end
  new_string.join(' ')
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'