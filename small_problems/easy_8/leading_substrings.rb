require 'pry'

def substrings_at_start(str)
  substr = ''
  str.chars.map { |char| substr  = substr + char }
end

p substrings_at_start('abc')
p substrings_at_start('a')
p substrings_at_start('xyzzy')

p substrings_at_start('abc') == ['a', 'ab', 'abc']
p substrings_at_start('a') == ['a']
p substrings_at_start('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']