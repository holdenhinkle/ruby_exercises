# return the number of friday the 13ths in the year given.

# use Date class

require 'date'

# def count_friday_the_13th(year)
#   total = 0
#   (1..12).each do |month|
#     total += 1 if Date.new(year, month, 13).friday?
#   end
#   total
# end

def count_friday_the_13th(year)
  (1..12).count { |month| Date.new(year, month, 13).friday? }
end

p count_friday_the_13th(1986)
p count_friday_the_13th(2015)
