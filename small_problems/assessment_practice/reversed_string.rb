# def reverse_string(str)
#   reversed_string = []
#   str.chars.each { |letter| reversed_string.unshift(letter)
#   reversed_string.join
# end

# def reverse_string(str)
#   str.chars.each_with_object([]) { |letter, reversed_string| reversed_string.unshift(letter) }.join
# end

def reverse_string(str)
  str.chars.each_with_object("") { |letter, reversed_string| reversed_string.prepend(letter) }
end

p reverse_string("Holden")