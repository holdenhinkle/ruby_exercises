# def triangle(a1, a2, a3)
#   angles = [a1, a2, a3]
#   case
#   when angles.sum != 180 || angles.include?(0) then :invalid
#   when angles.max > 90 then :obtuse
#   when angles.max == 90 then :right
#   else :acute
#   end
# end

def triangle(*angles)
  return :invalid if angles.sum != 180 || angles.include?(0)
  return :obtuse if angles.max > 90
  return :right if angles.max == 90
  :acute
end

p triangle(60, 70, 50) == :acute
p triangle(30, 90, 60) == :right
p triangle(120, 50, 10) == :obtuse
p triangle(0, 90, 90) == :invalid
p triangle(50, 50, 50) == :invalid