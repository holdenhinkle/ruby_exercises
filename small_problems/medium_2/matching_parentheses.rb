def balanced?(str)
  paren_indexes = {open: [], closed: [] }

  str.chars.each_with_index do |char, idx|
    paren_indexes[:open] << idx if char == '('
    paren_indexes[:closed] << idx if char == ')'
  end

  if paren_indexes[:open].count == paren_indexes[:closed].count
    paren_indexes[:open].count.times.all? do |idx|
      paren_indexes[:open][idx] < paren_indexes[:closed][idx]
    end
  else
    false
  end
end

# LS SOLUTION
# def balanced?(string)
#   parens = 0
#   string.each_char do |char|
#     parens += 1 if char == '('
#     parens -= 1 if char == ')'
#     break if parens < 0
#   end

#   parens.zero?
# end

p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false