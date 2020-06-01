puts "Please write word or multiple words:"

string = gets.chomp

num_chars = string.delete(' ').length

puts "There are #{num_chars} characters in \"#{string}\"."