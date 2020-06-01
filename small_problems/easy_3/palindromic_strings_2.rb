def palindrome?(str)
  str == str.reverse
end

def prepare_string(str)
  palindrome?(str.downcase.delete('^a-z0-9'))
end

palindrome?('madam') == true
palindrome?('Madam') == false          # (case matters)
palindrome?("madam i'm adam") == false # (all characters matter)
palindrome?('356653') == true