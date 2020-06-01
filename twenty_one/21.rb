require 'io/console'

WIDTH = 50
SUITS = %w[Hearts Spades Clubs Diamonds]
VALUES = %w[1 2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
DEALER_MINIMUM = 17
MAXIMUM = 21
MATCH_SCORE = 5

def request_name(players)
  clear_screen
  loop do
    puts "Enter a screen name:"
    name = gets.chomp
    if valid_name?(name)
      players[:player][:name] = name
      break
    else
      display_invalid_name
    end
  end
end

def valid_name?(name)
  name.length >= 3 && name.chars.all? { |char| char != ' ' }
end

def display_invalid_name
  puts(<<~WARNING)
    Invalid Name!
    Your screen name must:
    * Be a last 3 characters long
    * Not include any empty spaces

  WARNING
end

def display_welcome(players)
  clear_screen
  display_game_title
  display_welcome_message(players)
  prompt_any_key_to_continue('start')
end

def display_game_title
  puts "*****     #{MAXIMUM}     *****".center(WIDTH)
  puts ""
end

def display_welcome_message(players)
  center_text("#{players[:player][:name]}, welcome to #{MAXIMUM}!")
  puts ""
  center_text("* The goal of #{MAXIMUM} is to try to get as close to")
  center_text("#{MAXIMUM} as possible, without going over.")
  puts ""
  center_text("* If you go over #{MAXIMUM}, it's a 'bust' and you lose.")
  puts ""
  center_text("* If the dealer goes over #{MAXIMUM}, it's a 'bust' and")
  center_text("you win.")
  puts ""
  center_text("* If neither of you go over #{MAXIMUM}, the one closest")
  center_text("to #{MAXIMUM} wins, else it's a tie.")
  puts ""
  center_text("Have fun!")
  puts ""
end

def prompt_any_key_to_continue(msg)
  center_text("Press any key to #{msg}:")
  STDIN.getch
end

def prompt(msg)
  puts "=> #{msg}"
end

def center_text(msg)
  puts msg.to_s.center(WIDTH)
end

def clear_screen
  system('clear') || system('cls')
end

def wait
  sleep(2)
end

def build_deck
  deck = []
  SUITS.each { |suit| VALUES.each { |value| deck << [suit, value] } }
  deck
end

def deal(deck)
  dealers_hand = []
  players_hand = []
  2.times do
    dealers_hand << deck.pop
    players_hand << deck.pop
  end
  return dealers_hand, players_hand
end

def display_game_board(players, display_dealers_full_hand = false)
  clear_screen
  display_game_title
  display_score(players)
  display_dealers_hand(players[:dealer][:hand], display_dealers_full_hand)
  display_players_hand(players[:player][:hand])
end

def display_score(players)
  prompt("SCORE")
  players.each do |_, player|
    puts player[:name].to_s
    puts player[:score].to_s
    puts ""
  end
end

def display_dealers_hand(cards, display_dealers_full_hand)
  prompt("DEALERS CARDS")
  cards.each_with_index do |card, idx|
    if idx > 0 && !display_dealers_full_hand
      puts "Facedown card"
    else
      puts "#{card[1]} of #{card[0]}"
    end
  end
  puts ""
end

def display_players_hand(cards)
  prompt("YOUR CARDS")
  cards.each { |card| puts "#{card[1]} of #{card[0]}" }
  puts ""
end

def players_turn(deck, players)
  loop do
    display_game_board(players)
    prompt("Enter H for 'hit' or S for 'stay':")
    response = ''
    loop do
      response = gets.chomp.downcase
      break if %w[h hit s stay].include?(response)
      puts "Sorry, I didn't get that. Try again."
    end
    hit!(deck, players) if hit?(response)
    break if stay?(response) || bust?(players[:player][:hand])
  end
end

def dealers_turn(deck, players)
  display_game_board(players, true)
  loop do
    break if total(players[:dealer][:hand]) >= DEALER_MINIMUM
    hit!(deck, players, 'dealer')
    display_game_board(players, true)
  end
end

def hit?(input)
  %w[h hit].include?(input)
end

def stay?(input)
  %w[s stay].include?(input)
end

def hit!(deck, players, player = 'player')
  player = player.to_sym
  card = deck.pop
  players[player][:hand] << card
  puts "#{players[player][:name]}, you just got a #{card[1]} of #{card[0]}."
  wait
end

def bust?(cards)
  total(cards) > MAXIMUM
end

def total(cards)
  total = 0
  cards.each do |card|
    total = if %w[Jack Queen King].include?(card[1])
              total + 10
            elsif card[1] == 'Ace'
              total + 11
            else
              total + card[1].to_i
            end
  end
  if total > MAXIMUM && cards.any? { |card| card[1] == 'Ace' }
    total = correct_for_aces(total, cards)
  end
  total
end

def correct_for_aces(total, cards)
  cards.select { |card| card[1] == 'Ace' }.size.times do
    total -= 10
    return total if total <= MAXIMUM
  end
  total
end

def display_results(players, results)
  display_game_board(players, true)
  display_totals(players)
  display_winner(players, results)
  update_score(players, results)
  prompt_any_key_to_continue('continue')
end

def display_totals(players)
  players_total = total(players[:player][:hand])
  dealers_total = total(players[:dealer][:hand])
  puts "#{players[:player][:name]}, your cards total #{players_total}."
  puts "#{players[:dealer][:name]}, your cards total #{dealers_total}."
  puts ""
end

def determine_winner(players)
  dealer_total = total(players[:dealer][:hand])
  player_total = total(players[:player][:hand])

  if player_total > MAXIMUM
    :player_busted
  elsif dealer_total > MAXIMUM
    :dealer_busted
  elsif dealer_total < player_total
    :player_won
  elsif dealer_total > player_total
    :dealer_won
  else
    :tie
  end
end

def display_winner(players, result)
  case result
  when :player_busted
    display_player_busted(players[:player][:name])
  when :dealer_busted
    display_dealer_busted(players[:player][:name])
  when :player_won
    display_player_wins
  when :dealer_won
    display_dealer_wins
  when :tie
    display_tie
  end
end

def display_player_busted(name)
  puts "#{name}, you busted! Dealer wins!"
  puts ""
end

def display_dealer_busted(name)
  puts "#{name}, the dealer busted! You win!"
  puts ""
end

def display_player_wins
  puts "You win!"
  puts ""
end

def display_dealer_wins
  puts "The dealer wins!"
  puts ""
end

def display_tie
  puts "It's a tie!"
  puts ""
end

def update_score(players, results)
  case results
  when :player_busted
    players[:dealer][:score] += 1
  when :dealer_busted
    players[:player][:score] += 1
  when :player_won
    players[:player][:score] += 1
  when :dealer_won
    players[:dealer][:score] += 1
  end
end

def match_winner?(players)
  players[:dealer][:score] == MATCH_SCORE ||
    players[:player][:score] == MATCH_SCORE
end

def display_match_winner(players)
  if players[:dealer][:score] == MATCH_SCORE
    puts "The dealer won the match!"
  else
    name = players[:player][:name]
    puts "#{name}, you won #{MATCH_SCORE} games. You won the match!"
  end
  puts ""
end

def play_again?
  puts "Would you like to play again? Enter y for yes or n for no."
  play_again = ''
  loop do
    play_again = gets.chomp.downcase
    return true if %w[y yes].include?(play_again)
    return false if %w[n no].include?(play_again)
    puts "Sorry, I didn't get that. Enter y for yes or n for no."
  end
end

def display_goodbye_message
  clear_screen
  puts "Thanks for playing!"
end

players = { dealer: { name: 'Dealer' },
            player: { name: '' } }

request_name(players)
display_welcome(players)

loop do
  deck = build_deck
  players.each { |_, details| details[:score] = 0 }

  loop do
    deck = build_deck.shuffle!
    players[:dealer][:hand], players[:player][:hand] = deal(deck)
    players_turn(deck, players)
    dealers_turn(deck, players) unless bust?(players[:player][:hand])
    display_results(players, determine_winner(players))
    break if match_winner?(players)
  end

  display_match_winner(players)

  break unless play_again?
end

display_goodbye_message
