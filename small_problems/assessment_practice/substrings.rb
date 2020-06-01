def substrings(str)
  substrings = []
  str.length.times do |start_idx|
    start_idx.upto(str.length - 1) do |end_idx|
      substrings << str[start_idx..end_idx]
    end
  end
  substrings
end

p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde', 
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]