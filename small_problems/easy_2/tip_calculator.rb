def calc_tip(bill, percentage)
  bill * (percentage / 100)
end

def calc_total(bill, tip)
  bill + tip
end

puts "What is the bill?"
bill = gets.chomp.to_f

puts "What is the tip percentage?"
percentage = gets.chomp.to_f

tip = calc_tip(bill, percentage).round(2)

total = calc_total(bill, tip).round(2)

puts "The tip is $#{tip}"
puts "The total is $#{total}"
