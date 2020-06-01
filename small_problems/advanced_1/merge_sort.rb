# implement the merge_sort from:
# http://www.tutorialspoint.com/data_structures_algorithms/merge_sort_algorithm.htm

def merge_sort(a)
   return a if a.size == 1

   l1 = a[0...a.size / 2]
   l2 = a[a.size / 2...a.size]

   l1 = merge_sort(l1)
   l2 = merge_sort(l2)

   return merge(l1, l2)
end

def merge(a, b)
   c = []

   while a.any? && b.any?
      a[0] > b[0] ? c.push(b.delete_at(0)) : c.push(a.delete_at(0))
   end

   while a.any?
      c.push(a.delete_at(0))
   end

   while b.any?
      c.push(b.delete_at(0))
   end
   
   c
end

# THE FOLLOWING WORKS ON NUMBERS ONLY
# def merge(arr1, arr2)
#   results = []
#   min, max = min_max(arr1, arr2)
#   min.upto(max) do |num|
#     (arr1.count(num) + arr2.count(num)).times { results << num }
#   end
#   results
# end

# def min_max(arr1, arr2)
#   if arr1.empty?
#     return arr2.min, arr2.max
#   elsif arr2.empty?
#     return arr1.min, arr1.max
#   else
#     return [arr1.min, arr2.min].min, [arr1.max, arr2.max].max
#   end
# end

p merge_sort([9, 5, 7, 1])
p merge_sort([5, 3])
p merge_sort([6, 2, 7, 1, 4])
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie))
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46])

p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
