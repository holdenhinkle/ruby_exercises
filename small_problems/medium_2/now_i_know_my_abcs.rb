BLOCKS = ['B:O', 'X:K', 'D:Q', 'C:P', 'N:A',
          'G:T', 'R:E', 'F:S', 'J:W', 'H:U',
          'V:I', 'L:Y', 'Z:M']

def block_word?(word)
  available_blocks = BLOCKS.clone
  used_blocks = []
  word.chars do |char|
    available_blocks.each_with_index do |block, idx|
      if block.include?(char.upcase)
        used_blocks.push(available_blocks.delete_at(idx))
        break
      end
    end
  end
  used_blocks.size == word.size
end

# LS SOLUTION:
# BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM).freeze

# def block_word?(string)
#   up_string = string.upcase
#   BLOCKS.none? { |block| up_string.count(block) >= 2 }
# end


p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true