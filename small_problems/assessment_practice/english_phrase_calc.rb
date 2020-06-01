# problem: Convert english phrase into a mathematical expression, step by step
# input: str
# output: integer
# data structure: 
# numbers hash, where the word is the key, the value is the corresponding integer
# operators hash, where the word is the key, the value is the operator
# array, where each word in the string is an array

# algorithm:
# create hash of numbers, word is key, integer is value
# create hash of operators, word is key, operator character is value
# create empty string variable called equation
# convert given string to array of words
# iterate through the array, each_with_index:
# index .odd?
# determine number
# if word .to_i == word the word is an integer and is added to equation
# else look up number value in the hash
# determine operator
# look up operator in the hash
# run equation string using enum. this value is returned.

NUMBERS = { 'zero' => '0',
            'one' => '1',
            'two' => '2',
            'three' => '3',
            'four' => '4',
            'five' => '5',
            'six' => '6',
            'seven' => '7',
            'eight' => '8',
            'nine' => '9',
            'ten' => '10'
          }

OPERATORS = { 'plus' => '+', 'minus' => '-', 'times' => '*', 'divided by' => '/' }

# VERSION 1 - 'divided by' doesn't work
# def computer(string)
#   equation = ''
#   string.split.each_with_index do |word, idx|
#     if idx.even?
#       if word.to_i.to_s == word
#         equation << word
#       else
#         equation << NUMBERS[word]
#       end
#     else
#       equation << OPERATORS[word]
#     end
#   end
#   eval(equation)
# end

# VERSION 2
def computer(string)
  NUMBERS.each { |word, num| string.gsub!(word, num) }
  OPERATORS.each { |word, op| string.gsub!(word, op) }
  eval(string)
end

p computer("4 divided by two") == 2
p computer("two plus two") == 4
p computer("seven minus six") == 1
p computer("zero plus 8") == 8
p computer("2 plus six") == 8
p computer("2 plus two minus three") == 1
p computer("three minus 1 plus five minus 4 plus six plus 10 minus 4") == 15
