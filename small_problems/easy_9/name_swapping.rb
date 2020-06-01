# def swap_name(str)
#   full_name = str.split
#   "#{full_name[1]}, #{full_name[0]}"
# end

def swap_name(name)
  name.split(' ').reverse.join(', ')
end

p swap_name('Joe Roberts') == 'Roberts, Joe'