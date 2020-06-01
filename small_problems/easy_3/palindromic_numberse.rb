def palindrome?(str)
  str == str.reverse
end

def palindromic_number?(num)
  palindrome?(num.to_s)
end

palindromic_number?(34543) == true
palindromic_number?(123210) == false
palindromic_number?(22) == true
palindromic_number?(5) == true