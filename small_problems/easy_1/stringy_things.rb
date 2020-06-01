require 'pry'

def stringy(num)
  counter = 1
  binary_string = ''
  num.times do
    if counter.odd?
      binary_string += '1'
    else
      binary_string += '0'
    end
    counter += 1
  end
  binary_string
end


puts stringy(6)
puts stringy(9)
puts stringy(4)
puts stringy(7)

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'