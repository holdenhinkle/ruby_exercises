# recursion
def fib_r(n)
  return n if n < 2
  fib_r(n - 1) + fib_r(n - 2)
end

# procedural
def fib_p(n)
  first, last = 1, 1
  3.upto(n) do
    first, last = last, first + last
  end
  last
end

p fib_r(3)
p fib_p(3)