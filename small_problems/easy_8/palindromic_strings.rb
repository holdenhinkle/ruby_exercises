require 'pry'

def palindromes(str)
  substrings(str).select { |str| str == str.reverse && str.size > 1 }
end

def substrings(str)
  substrs = []
  str.length.times do
    substrs.concat(substrings_at_start(str))
    str.slice!(0)
  end
  substrs
end

def substrings_at_start(str)
  substr = ''
  str.chars.map { |char| substr  = substr + char }
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]