# Write a method that returns all substrings. No one letter words.
# input: string
# output: array of strings
# problem: find all substrings in a word that contain more than 1 character
# data structure: array
# algorithm:
# create results array = []
# iterate through the string starting at 0, upto the length of the string - 1, set this to start_index
# iterate through the string starting at the index up to the lenth of the string -1, set this to end_index
# push to results array if the selected string is > 1 charachters in length
# return results array

def substrings(str)
  results = []
  0.upto(str.length - 1) do |start_idx|
    (start_idx + 1).upto(str.length - 1) do |end_idx|
      results << str[start_idx..end_idx]
    end
  end
  results
end

p substrings("holden")
p substrings("Farhan")
p substrings("Burp")