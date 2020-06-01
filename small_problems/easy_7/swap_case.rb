def swapcase(str)
  new_str = str.each_char.map do |char|
    char == char.upcase ? char.downcase : char.upcase
  end
  new_str.join
end

p swapcase('CamelCase') == 'cAMELcASE'
p swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'