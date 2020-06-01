# input: str
# output: boolean
# rules: check to see if paranthesis are properly balanced

# algorithm:
# Create a mechanism that balances open and closed paranthesis

# balance starts at 0
# iterate through each character in the string
# balance increases every time a new opening paranthesis is detected
# balance decreases every time a new closed paranthesis is detected
# if at any point the balance falls below 0, then return false
# if the balance is greater than 0 at the end retrun false
# return true if balance is 0 at the end


def balanced?(str)
  balance = 0
  str.each_char do |char|
    balance += 1 if char == '('
    balance -= 1 if char == ')'
    return false if balance < 0
  end
  balance == 0 ? true : false
end

p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false