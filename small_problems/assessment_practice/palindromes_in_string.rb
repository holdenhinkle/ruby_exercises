# Write a method that will return all palindromes in a string.
# input: string
# output: array of strings
# problem: Write a method that will return all palindromes in a string.
# data structure: array
# algorithm:
# using the substrings method we just wrote...
# palindromes method is called with a string as an argument
# call substrings on the string
# replace "results << str[start_idx..end_idx]" with something like:
#   substring = str[start_idx..end_idx]
#   results << substring if palindrome?(substring)

# palindrome? helper method
# set variable right_side_idx to str.length - 1
# iterate through the string using each_with_index
# compare the index with right_side_idx or equality
# return false if false
# decrement right_side_idx by 1
# after iteration, return true

def palindromes(str)
  longest_palindrome(substrings(str))
end

def substrings(str)
  results = []
  0.upto(str.length - 1) do |start_idx|
    (start_idx + 1).upto(str.length - 1) do |end_idx|
      substring = str[start_idx..end_idx]
      results << substring if is_palindrome?(substring)
    end
  end
  results
end

def is_palindrome?(str)
  right_side_idx = str.length - 1
  (str.length - 1).times do |left_side_idx|
    return false if str[left_side_idx] != str[right_side_idx]
    right_side_idx -= 1
  end
  true
end

def longest_palindrome(arr)
  longest = ''
  arr.each { |word| longest = word if word.length > longest.length }
  longest
end

p palindromes("ppop")