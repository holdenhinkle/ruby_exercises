text = File.read("sample_file.txt")

sentences = text.scan(/[^\.!?]+[\.!?]/).map(&:strip)

longest_sentence = { }

# FIRST ATTEMPT
# sentences.each do |sentence|
#   if sentence.split.count > longest_sentence[:length]
#     longest_sentence[:sentence] = sentence
#     longest_sentence[:length] = sentence.split.count
#   end
# end

# BASED ON SOLUTION
longest_sentence[:sentence] = sentences.max_by { |sentence| sentence.split.size }

longest_sentence[:length] = longest_sentence[:sentence].split.size


puts "The longest sentence is #{longest_sentence[:length]} words long."
puts "Here it is:"
puts longest_sentence[:sentence]