# def letter_percentages(str)
#   text_cases = { lowercase: 0, uppercase: 0, neither: 0 }
#   determine_letter_cases(str, text_cases)
#   calculate_case_percentages(str, text_cases)
# end

# def determine_letter_cases(str, text_cases)
#   str.chars.each do |char|
#     if char.match(/[a-z]/)
#       text_cases[:lowercase] += 1
#     elsif char.match(/[A-Z]/)
#       text_cases[:uppercase] += 1
#     else
#       text_cases[:neither] += 1
#     end
#   end
# end

# def calculate_case_percentages(str, text_cases)
#   text_cases.each do |key, value|
#     text_cases[key] = (value / str.length.to_f) * 100
#   end
# end

def letter_percentages(str)
  text_cases = {}
  determine_letter_cases(str, text_cases)
  calculate_case_percentages(str, text_cases)
end

def determine_letter_cases(str, text_cases)
  chars = str.chars
  text_cases[:uppercase] = chars.count { |char| char =~ /[A-Z]/ }
  text_cases[:lowercase] = chars.count { |char| char =~ /[a-z]/ }
  text_cases[:neither] = chars.count { |char| char =~ /[^a-zA-Z]/ }
end

def calculate_case_percentages(str, text_cases)
  text_cases.each do |key, value|
    text_cases[key] = (value / str.length.to_f) * 100
  end
end

p letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
p letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }