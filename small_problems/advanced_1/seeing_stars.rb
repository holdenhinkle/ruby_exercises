CHAR = "*"

def star(n)
  inner_space = (n - 3) / 2
  outer_space = 0
  (3..n).step(2) do |counter|
    puts (" " * outer_space) + CHAR + (" " * inner_space) + CHAR + (" " * inner_space) + CHAR + (" " * outer_space)
    inner_space -= 1 unless counter == n - 2
    outer_space += 1 unless counter == n - 2
  end

  puts CHAR * n

  (3..n).step(2) do
    puts (" " * outer_space) + CHAR + (" " * inner_space) + CHAR + (" " * inner_space) + CHAR + (" " * outer_space)
    inner_space += 1
    outer_space -= 1
  end
end

# SOMEONE ELSE'S SOLUTION - AMAZING
# def star(num)
#   up = (num/2 - 1).downto(0).map { |spaces| %w(* * *).join(" " * spaces).center(num)  }
#   down = up.reverse
#   puts up, "*" * num, down
# end

star(7)
puts ""
star(9)
