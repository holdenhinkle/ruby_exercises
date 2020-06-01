NUMBERS = %w[one two three four five six seven eight nine ten]
OPERATORS = ['plus', 'minus', 'times', 'divided by']

# def mathphrase(num)
#   phrase = ''
#   (num).times do
#     phrase << NUMBERS.sample + ' '
#     phrase << OPERATORS.sample + ' '
#   end
#   phrase << NUMBERS.sample
# end

# p mathphrase(1)
# p mathphrase(2)
# p mathphrase(5)

def mathphrase(num)
  phrase = ''
  (num).times do
    phrase << NUMBERS.sample + ' '
    phrase << OPERATORS.sample + ' '
  end
  phrase << NUMBERS.sample
end

10.times { p mathphrase(rand(1..20)) }