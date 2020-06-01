def fib(n)
  return 1 if n <= 2
  fib(n - 1) + fib(n - 2)
end

def fibi(n)
  first, last = 1, 1
  3.upto(n) do
    first, last = last, first + last
  end
  last
end

p fib(10)
p fibi(10)


def fib(n)
  return 1 if n <= 2
  fib(n - 1) + fib(n - 2)
end

def fib(n)
  first, last = 1, 1
  3.upto(n) do
    first, last = last, first + last
  end
  last
end