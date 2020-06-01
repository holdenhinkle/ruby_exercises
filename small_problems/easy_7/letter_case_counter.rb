def letter_case_count(str)
  hsh = { lowercase: 0, uppercase: 0, neither: 0 }
  str.each_char do |char|
    if /[[:upper:]]/.match(char)
      hsh[:uppercase] += 1
    elsif /[[:lower:]]/.match(char)
      hsh[:lowercase] += 1
    else
      hsh[:neither] += 1
    end
  end
  hsh   
end

p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }