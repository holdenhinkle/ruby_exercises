# Given 2 strings, your job is to find out if there is a substring
# that appears in both strings. You will return true if you find a
# substring that appears in both strings, or false if you do not.
# We only care about substrings that are longer than one letter long.

# Create a method that takes two strings as an argmument
# Create an array of all substrings starting at each index.
# Iterate through all substrings and see if the substring is in the other string
# If it is in the other string return true, else return false

def substring_test(str1, str2)
  substrings = find_substrings(str1)
  substrings.each do |substring|
    return true if str2.downcase.include?(substring.downcase)
  end
  false
end

def find_substrings(str)
  results =[]
  (str.length - 1).times do |start_idx|
    (start_idx + 1).upto(str.length) do |end_idx|
      results << str[start_idx..end_idx]
    end
  end
  results
end

p substring_test('Something', 'Fun') == false
p substring_test('Something', 'Home') == true
p substring_test('Something', 'Fun') == false
p substring_test('Something', '') == false
p substring_test('', 'Something') == false
p substring_test('BANANA', 'banana') == true
p substring_test('test', 'lllt') == false
p substring_test('', '') == false
p substring_test('1234567', '541265') == true
p substring_test('supercalifragilisticexpialidocious', 'SoundOfItIsAtrociou') == true