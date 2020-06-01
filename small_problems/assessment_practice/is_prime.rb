# Write a method that will determine if an integer is prime.
# Don't use Prime class.

# input: integer
# output: boolean
# problem: write an algorithm that takes an integer as input and determines
# whether the integer is a prime number or not. It will return true or false.
# data structure: integer
# algorithm:
# if intger == 0 return false (1 is not a prime because primes are divisible by two numbers.)
# iterate through numbers 2 thru the integer given - 1 (we know every number is divisible by itself.)
# during iteration, return false if the integer % the current number == 0
# after iteration, return true (nothing returned false)

def is_prime?(num)
  return false if num == 0
  2.upto(num -1) do |n|
    return false if num % n == 0
  end
  true
end


p is_prime?(3) == true
p is_prime?(4) == false