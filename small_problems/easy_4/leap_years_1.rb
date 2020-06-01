def leap_year?(year)
  if year % 4 == 0
    return true unless year % 100 == 0 
    if year % 100 == 0 
      return true if year % 400 == 0
    end
  end
  false
end

def leap_year_2?(year)
 (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == false
p leap_year?(1) == false
p leap_year?(100) == false
p leap_year?(400) == true

puts "Version 2"

p leap_year_2?(2016) == true
p leap_year_2?(2015) == false
p leap_year_2?(2100) == false
p leap_year_2?(2400) == true
p leap_year_2?(240000) == true
p leap_year_2?(240001) == false
p leap_year_2?(2000) == true
p leap_year_2?(1900) == false
p leap_year_2?(1752) == true
p leap_year_2?(1700) == false
p leap_year_2?(1) == false
p leap_year_2?(100) == false
p leap_year_2?(400) == true