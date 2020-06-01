def word_sizes(str)
  hsh = Hash.new(0)
  str.split.each do |word|
    clean_word = word.delete('^A-Za-z')
    hsh[clean_word.length] += 1
  end
  hsh
end

# VALID_CHARS = [*('a'..'z'), *('A'..'Z'), ' ']

# def word_sizes(str)
#   hsh = Hash.new(0)
#   clean_sentence(str).split.each do |word|
#     hsh[word.length] += 1
#   end
#   hsh
# end

# def clean_sentence(str)
#   str.chars.map { |char| is_valid?(char) ? char : '' }.join
# end

# def is_valid?(char)
#   VALID_CHARS.include?(char)
# end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
p word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
p word_sizes('') == {}