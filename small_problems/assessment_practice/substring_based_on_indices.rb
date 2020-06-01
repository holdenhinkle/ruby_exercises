# input: string, int, int
# string is a word
# int1 - starting index
# int2 - number of characters to be returned
# output: string
# problem: Write a method that will return a substring based on specified indices.
# algorithm:
# method parameter will take a string, index integer and num_characters integer set to 1 by default
# call slice on the str with index and num_characters

# def substring(string, index, num_chars = 1)
#   string.slice(index, num_chars)
# end

# MANUUALY
# set substring variable == ''

# iterate through the string num_chars times
# each iteration:
# shovel letter at string(index) into substring 
# increment index by 1
# return substring

def substring(string, index, num_chars = 1)
  substring = ''
  beginning_index = index
  num_chars.times do
    substring << string[index] unless string[index] == nil
    index += 1
  end
  substring
end

p substring("honey", 0, 3) == "hon"
p substring("honey", 1, 2) == "on"
p substring("honey", 3, 9) == "ey"
p substring("honey", 2) == "n"






