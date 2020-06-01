def palindrome?(str)
  right_side_idx = str.length - 1
  0.upto(right_side_idx) do |left_side_idx|
    return false if str[left_side_idx] != str[right_side_idx]
    right_side_idx -=1
  end
  true
end

p palindrome?('madam') == true
p palindrome?('Hannah') == true
p palindrome?('hannah') == true
p palindrome?('holden') == false
p palindrome?('12321') == true
p palindrome?(' p2r2p ') == true
p palindrome?('12345') == false
p palindrome?('Emmerson') == true