def palindromes(str)
  substrings(str).select { |str| str.length > 1 && str == str.reverse }
end

def substrings(str)
  substrings = []
  str.length.times do |start_idx|
    start_idx.upto(str.length - 1) do |end_idx|
      substrings << str[start_idx..end_idx]
    end
  end
  substrings
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