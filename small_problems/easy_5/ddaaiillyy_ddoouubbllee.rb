require 'pry'

def crunch(str)
  arr = []
  str.each_char do |char|
    arr.push(char) unless arr.last == char
  end
  arr.join
end

p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch('4444abcabccba') == '4abcabcba'
p crunch('ggggggggggggggg') == 'g'
p crunch('a') == 'a'
p crunch('') == ''