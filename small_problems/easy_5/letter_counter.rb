# def word_sizes(str)
#   hsh = {}
#   str.split.each do |word|
#     hsh[word.length] = 0 unless hsh.has_key?(word.length)
#     hsh[word.length] += 1
#   end
# end

def word_sizes(str)
  hsh = Hash.new(0)
  str.split.each do |word|
    hsh[word.length] += 1
  end
  hsh
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
p word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
p word_sizes('') == {}