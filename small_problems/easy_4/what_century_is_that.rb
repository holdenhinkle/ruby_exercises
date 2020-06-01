ORDINAL_INDICATORS = { 1 =>'st', 2 => 'nd', 3 => 'rd' }

def century(year)
  century = year / 100 + 1
  century -= 1 if year % 100 == 0
  suffix(century)
end

def suffix(century)
  suffix = century % 10
  return "#{century}th" if [11, 12, 13].include?(century % 100)
  if (1..3).include?(suffix)
    "#{century}#{ORDINAL_INDICATORS[suffix]}"
  else
    "#{century}th"
  end
end

p century(2000)
p century(2001)
p century(1965)
p century(256)
p century(5)
p century(10103)
p century(1052)
p century(1127)
p century(11201)

# century(2000) == '20th'
# century(2001) == '21st'
# century(1965) == '20th'
# century(256) == '3rd'
# century(5) == '1st'
# century(10103) == '102nd'
# century(1052) == '11th'
# century(1127) == '12th'
# century(11201) == '113th'