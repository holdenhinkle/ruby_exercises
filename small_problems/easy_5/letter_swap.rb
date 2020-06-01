def swap(str)
  str.split.map { |word| swap_first_last_characters(word) }.join(' ')
end

def swap_first_last_characters(word)
  word[0], word[-1] = word[-1], word[0]
  word
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'