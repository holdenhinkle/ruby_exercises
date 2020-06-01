def max_rotation(num)
  num_str = num.to_s
  num_str.length.times do |idx|
    num_str = rotate_rightmost_digits(num_str, idx)
  end
  num_str.to_i
end

def rotate_rightmost_digits(num_str, idx)
  num_chars = num_str.chars
  num_chars.push(num_chars.delete_at(idx)).join
end

p max_rotation(735291) == 321579
p max_rotation(3) == 3
p max_rotation(35) == 53
p max_rotation(105) == 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) == 7_321_609_845