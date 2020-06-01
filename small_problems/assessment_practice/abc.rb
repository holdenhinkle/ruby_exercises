# input: string
# output: boolean
# rules: check each letter in the string against a block of two letters. if a block exists
# the letter is valid. blocks can only be used for one letter.

# algorithm:
# create a global variable that contains an array of the 2-letter blocks.
# create a method that takes the string argument
# create a copy of the global varaiable
# iterate through each letter in the string and check to see if the letter is in one of the 2-letter blocks
#  => if it is, delete that 2-letter block from the array
#  => else return false
# return true if the iteration completes

BLOCKS = %w[B:O X:K D:Q C:P N:A G:T R:E F:S J:W H:U V:I L:Y Z:M]

def block_word?(string)
  up_string = string.upcase
  BLOCKS.none? { |block| up_string.count(block) >= 2 }
end


p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true