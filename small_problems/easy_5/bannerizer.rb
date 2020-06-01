def print_in_box(str)
  width = str.length + 2
  border(width)
  padding(width)
  puts "| #{str} |"
  padding(width)
  border(width)
end

def border(width)
  puts "+#{'-' * width}+"
end

def padding(width)
  puts "|#{' ' * width}|"
end

print_in_box('To boldly go where no one has gone before.')

print_in_box('')