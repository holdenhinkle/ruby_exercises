def staggered_case(words)
  staggered = words.chars.each_with_index.map do |char, idx|
    idx.even? ? char.upcase : char.downcase
  end
  staggered.join
end

p staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
p staggered_case('ALL_CAPS') == 'AlL_CaPs'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'