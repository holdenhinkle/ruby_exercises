require 'pry'
# output: string of integers
# problem: print all prime numbers that occur between two given integers
# questions:
# is the low number always the first argument?
# what should happen if there are not any primes?
# algorithm:
# create an array called prime_numbers and set it to 0
# iterate through each number starting with the lower number given up to the highest number given.
# upon each iteration, check to see if the current number is a prime number
# create a helper method which checks if a number is prime or not
# add the current number to the prime_numbers array if the number is a prime number

# is_prime? helper method
# input: integer
# output: boolean
# problem: determine if a number is a prime number
# notes: a prime number is only disible between 1 and itself
# The first prime numbers are  The first few prime numbers are 2, 3, 5, 7, 11, 13, 17, 19, 23 and 29
# algorithm:
# iterate from 1 upto the given integer and check if the current number mod integer  == 0
# return true if 2
# skip the integer itself because primes are divisiable by themselves
# if it is not return false
# return true at the end of the iteration

# def find_primes(low_num, high_num)
#   prime_numbers = []
#   low_num.upto(high_num) do |num|
#     prime_numbers << num if is_prime?(num)
#   end
#   prime_numbers.join(', ')
# end

def find_primes(low_num, high_num)
  (low_num..high_num).select { |num| is_prime?(num) }.join(', ')
end

def is_prime?(num)
  return false if num == 1
  2.upto(num - 1) { |n| return false if num % n == 0 }
  true
end

p find_primes(1, 50)
p find_primes(3, 10)
p find_primes(5, 20)