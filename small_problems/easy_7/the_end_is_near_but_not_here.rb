def penultimate(words)
  words.split[-2]
end

p penultimate('last word') == 'last'
p penultimate('Launch School is great!') == 'is'