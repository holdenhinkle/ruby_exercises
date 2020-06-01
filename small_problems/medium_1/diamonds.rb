def diamond(n)
  diamond_chars = 1
  loop do
    puts "#{'*' * diamond_chars}".center(n)
    break if diamond_chars == n
    diamond_chars += 2
  end

  diamond_chars -= 2
  loop do
    break if diamond_chars < 1
    puts "#{'*' * diamond_chars}".center(n)
    diamond_chars -= 2
  end
end

diamond(1)
diamond(3)
diamond(9)