require 'pry'

def staggered_case(str)
  upcase_letter = true
  str.chars.each_with_object('') do |char, new_str|
    if /[[:alpha:]]/.match(char)
      upcase_letter ? new_str << char.upcase : new_str << char.downcase
      upcase_letter = !upcase_letter
    else
      new_str << char
    end
  end
end

p staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
p staggered_case('ALL CAPS') == 'AlL cApS'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'