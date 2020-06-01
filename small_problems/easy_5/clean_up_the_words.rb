require 'pry'

def cleanup(str)
  new_str = []
  str.each_char do |char|
    if ('a'..'z').include?(char)
      new_str << char
    else
      new_str << ' '      
    end
  end
  new_str.join.squeeze
end

def cleanup(str)
  str.chars.map { |char| ('a'..'z').include?(char) ? char : ' ' }.join.squeeze
end

p cleanup("---what's my +*& line?")
p cleanup("---what's my +*& line?") == ' what s my line '