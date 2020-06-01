def reverse_words(string)
  # short
  string.split.map { |word| word.length >= 5 ? word.reverse : word }.join(' ')
  # long
  # new_string = string.split.map do |word|
  #   if word.length >= 5
  #     word.reverse
  #   else
  #     word
  #   end
  # end
  # new_string.join(' ')
end


puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS