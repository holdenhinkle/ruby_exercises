def triangle(s1, s2, s3)
  sides = [s1, s2, s3].sort
  return :invalid unless valid_triangle?(sides)
  triangle_type(sides)
end

def valid_triangle?(sides)
  sides[0] + sides[1] > sides[2] && sides.all? { |side| side > 0 }
end

def triangle_type(sides)
  if sides.uniq.count == 3
    :scalene
  elsif sides.uniq.count == 2
    :isosceles
  else
    :equilateral
  end
end

p triangle(3, 3, 3) == :equilateral
p triangle(3, 3, 1.5) == :isosceles
p triangle(3, 4, 5) == :scalene
p triangle(0, 3, 3) == :invalid
p triangle(3, 1, 1) == :invalid