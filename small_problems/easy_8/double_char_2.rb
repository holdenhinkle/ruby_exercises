require 'pry'

def double_consonants(str)
  result = ''
  str.chars do |char|
    result << char
    result << char if /[a-zA-Z&&[^aeiou]]/.match(char)
  end
  result
end

p double_consonants('String')
p double_consonants("Hello-World!")
p double_consonants("July 4th")
p double_consonants('')

p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""