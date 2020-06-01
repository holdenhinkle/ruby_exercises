numbers = []
%w(1st 2nd 3rd 4th 5th last).each do |label|
  puts "Enter the #{label} number:"
  numbers << gets.chomp.to_i
end

search_term = numbers.pop

if numbers.include?(search_term)
  puts "The number #{search_term} appears in #{numbers}."
else
  puts "The number #{search_term} does not appear in #{numbers}."
end