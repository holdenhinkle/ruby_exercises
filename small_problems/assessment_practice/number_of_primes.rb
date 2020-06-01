# Write a method that will take an array of numbers and return
# the number of primes in the array

# input: array of integers
# output: integer which represents the number of primes in the array
# problem: count how many numbers in the array are primes
# algorithm:
# iterate through the array with each_with_object, and create an integer object set to zero
# through each iterate, increment the counter by 1 if the number is zero.
# the method should return the integer

# def count_primes(arr)
#   counter = 0
#   arr.each do |n|
#     counter += 1 if is_prime?(n)
#   end
#   counter
# end

# def count_primes(arr)
#   arr.map { |n| is_prime?(n) ? 1 : 0 }.sum
# end

def count_primes(arr)
  arr.count { |n| is_prime?(n) }
end

def is_prime?(num)
  return false if num == 1
  2.upto(num -1) do |n|
    return false if num % n == 0
  end
  true
end

p count_primes([1,2,3,4])
p count_primes([4,6,8,10])