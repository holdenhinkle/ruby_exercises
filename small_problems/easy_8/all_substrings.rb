require 'pry'

def substrings(str)
  substrs = []
  str.length.times do
    substrs.concat(substrstrings_at_start(str))
    str.slice!(0)
  end
  substrs
end

def substrings_at_start(str)
  substr = ''
  str.chars.map { |char| substr  = substr + char }
end

p substrings('abcde')

p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde', 
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]