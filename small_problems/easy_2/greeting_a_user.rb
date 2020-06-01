require 'pry'

# VERSION 1
def greet_v1(name)
  if name.chars.last == "!"
    new_name = name.chars
    new_name.pop
    "Hello #{new_name.join}. Why are you screaming?".upcase
  else
    "Hello #{name}."
  end
end

def greet_v2(name)
  if name.end_with?('!')
    "Hello #{name.delete_suffix('!')}. Why are you screaming?".upcase
  else
    "Hello #{name}."
  end    
end

puts "What is your name?"
name = gets.chomp
puts greet_v1(name)
puts greet_v2(name)