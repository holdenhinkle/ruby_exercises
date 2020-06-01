def ascii_value(str)
  sum = 0
  str.chars.each do |char|
    sum += char.ord
  end
  sum
end

def ascii_value(str)
  sum = 0
  str.each_char { |char| sum += char.ord }
  sum
end

def ascii_value(str)
  str.chars.inject(0) { |sum, char| sum += char.ord }
end

def ascii_value(str)
  str.chars.map { |char| char.ord }.sum
end

def ascii_value(str)
  str.chars.map(&:ord).sum
end

def ascii_value(str)
  str.bytes.sum
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0