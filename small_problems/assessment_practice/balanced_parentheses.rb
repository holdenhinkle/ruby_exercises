# input: string
# output: boolean
# problem: check to see if a string has a balanced set of parenthesis
# algorithm:
# create a variable called balanced and set it to 0
# convert the string to an array of chars and iterate through it using each
# on each iteration:
# if a char == '(' then increase balanced by 1
# if a char == ')' then decrease balanced by 1
# return false if balanced < 0
# at the end of all iterations return true if balanced == 0

def balancer(str)
  balanced = 0
  str.chars.each do |char|
    balanced += 1 if char == '('
    balanced -= 1 if char == ')'
    return false if balanced < 0
  end
  balanced == 0
end

p balancer("hi") == true
p balancer("(hi") == false
p balancer("hi)") == false
p balancer("(hi)") == true