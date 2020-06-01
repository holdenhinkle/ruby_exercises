require 'pry'

NOUNS = %w[dog cat mouse tree bird bike stump]
VERBS = %w[ran walked slithered meowed laughed limped]
ADJECTIVES = %w[blue pretty uggly happy pink hairy]
ADVERBS = %w[easily lazily noisly excitedly]

# VERSION 1:
text_1 = File.read('madlibs_template.txt')

text_1.split('\n').each do |line|
  new_line = line.split.map do |word|
    if word == 'noun'
      word.gsub!('noun', NOUNS.sample)
    elsif word == 'verb'
      word.gsub!('verb', VERBS.sample)
    elsif word == 'adjective'
      word.gsub!('adjective', ADJECTIVES.sample)
    else
      word
    end
  end
  puts new_line.join(' ')
end

# VERSION 2
text_2 = File.read('madlibs_template_2.txt')

def noun
  NOUNS.sample
end

def verb
  VERBS.sample
end

def adjective
  ADJECTIVES.sample
end

puts eval(text_2)

# VERSION 3:
File.open('madlibs_template_3.txt') do |file|
  binding.pry
  file.each do |line|
    puts format(line, noun:        NOUNS.sample,
                      verb:        VERBS.sample,
                      adjective:   ADJECTIVES.sample,
                      adverb:      ADVERBS.sample )
  end
end