# input: array
# output: new array which is the reverse of the input array
# problem: reverse an array without using the built-in reverse method
# algorithm:
# call each_with_object on the array and create a new array object
# iterate through the array
# put each element at the beginning of the new array object
# the each_with_object will return the new array


def reverse_array(arr)
  arr.each_with_object([]) do |element, reversed_arr|
    reversed_arr.unshift(element)
  end
end

arr = [1,2,3,4,5]
p arr
p reverse_array([1,2,3,4,5])