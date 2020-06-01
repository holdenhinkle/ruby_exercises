def bubble_sort!(arr)
  sorted = true
  loop do
    previous_value = arr[0]
    arr.each_with_index do |current_value, idx|
      if previous_value > current_value
        arr[idx - 1], arr[idx] = arr[idx], arr[idx - 1]
        sorted = false
      end
      previous_value = current_value
    end
    return arr if sorted
    sorted = true
  end
end

# LS SOLUTION
# def bubble_sort!(array)
#   loop do
#     swapped = false
#     1.upto(array.size - 1) do |index|
#       next if array[index - 1] <= array[index]
#       array[index - 1], array[index] = array[index], array[index - 1]
#       swapped = true
#     end

#     break unless swapped
#   end
#   nil
# end

array = [5, 3]
p bubble_sort!(array)
p array == [3, 5]

array = [6, 2, 7, 1, 4]
p bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
p bubble_sort!(array)
p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)