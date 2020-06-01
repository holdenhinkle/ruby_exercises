SPACE = ' '
STAR = '*'

def triangle(n)
  spaces = n - 1
  stars = 1
  n.times do
    puts "#{SPACE * spaces}#{STAR * stars}"
    spaces -= 1
    stars += 1
  end
end

triangle(9)
triangle(5)