VALID_CHOICES = [
  { name: 'rock', input: ['r', 'rock'], beats: ['scissors', 'lizard'] },
  { name: 'paper', input: ['p', 'paper'], beats: ['rock', 'spock'] },
  { name: 'scissors', input: ['s', 'scissors'], beats: ['paper', 'lizard'] },
  { name: 'spock', input: ['sp', 'spock'], beats: ['scissors', 'rock'] },
  { name: 'lizard', input: ['l', 'lizard'], beats: ['paper', 'spock'] }
]

WINNING_SCORE = 5

def clear_screen
  system('clear')
end

def wait
  sleep(2)
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def user_throws_hand
  prompt("Choose: (r)ock, (p)aper, (s)cissors, (sp)ock, (l)izard")
  user_input = nil
  loop do
    user_input = Kernel.gets().chomp().downcase
    return user_input if valid_choice?(user_input)
    prompt("Sorry, I didn't get that. Try again:")
  end
end

def computer_throws_hand
  VALID_CHOICES.sample[:name]
end

def valid_choice?(user_input)
  VALID_CHOICES.each do |hand, _|
    return true if hand[:input].include?(user_input)
  end
  false
end

def translate_input_to_hand_name(user_input)
  VALID_CHOICES.each do |hand, _|
    return hand[:name] if hand[:input].include?(user_input)
  end
end

def display_set_score(user_set_score, computer_set_score)
  prompt("SET SCORE")
  puts("User: #{user_set_score}, Computer #{computer_set_score}")
end

def display_game_score(user_game_score, computer_game_score)
  prompt("GAME SCORE")
  puts("User: #{user_game_score}, Computer #{computer_game_score}")
end

def win?(player_hand, other_player_hand)
  VALID_CHOICES.each do |choice|
    if choice[:name] == player_hand &&
       choice[:beats].include?(other_player_hand)
      return true
    end
  end
  false
end

def display_results(user_hand, computer_hand)
  if win?(user_hand, computer_hand)
    prompt("You won!")
  elsif user_hand == computer_hand
    prompt("It's a tie!")
  else
    prompt("The computer won!")
  end
end

def overall_winner?(user_game_score, computer_game_score)
  user_game_score >= WINNING_SCORE || computer_game_score >= WINNING_SCORE
end

def display_overall_winner(user_game_score)
  if user_game_score == WINNING_SCORE
    prompt("Congratulations. You won the set!")
  else
    prompt("The computer won the set.")
  end
end

def play_again?
  prompt("Play again? Enter (y)es or (n)o:")
  answer = nil
  loop do
    answer = gets().chomp().downcase()
    return true if %w(y yes).include?(answer)
    return false if %w(n no).include?(answer)
    puts("Sorry, I didn't get that. Try again.")
  end
end

user_set_score = 0
computer_set_score = 0

loop do
  user_game_score = 0
  computer_game_score = 0

  loop do
    clear_screen

    display_set_score(user_set_score, computer_set_score)

    display_game_score(user_game_score, computer_game_score)

    user_hand = translate_input_to_hand_name(user_throws_hand)

    computer_hand = computer_throws_hand

    prompt("You chose #{user_hand}. The computer chose #{computer_hand}.")

    display_results(user_hand, computer_hand)

    if win?(user_hand, computer_hand)
      user_game_score += 1
    elsif win?(computer_hand, user_hand)
      computer_game_score += 1
    end

    wait

    break if overall_winner?(user_game_score, computer_game_score)
  end

  clear_screen

  if user_game_score == WINNING_SCORE
    user_set_score += 1
  else
    computer_set_score += 1
  end

  display_set_score(user_set_score, computer_set_score)

  display_game_score(user_game_score, computer_game_score)

  display_overall_winner(user_game_score)

  wait

  break unless play_again?
end

prompt("Thanks for playing. Goodbye!")
