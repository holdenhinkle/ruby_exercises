require 'io/console'

module Clearable
  def clear
    system('clear') || system('cls')
  end
end

module Continuable
  def press_any_key_to_continue(continue = 'continue')
    puts "Press any key to #{continue}:"
    STDIN.getch
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def <<(card)
    cards.push card
  end

  def <(other)
    total < other.total
  end

  def >(other)
    total > other.total
  end

  def total
    total = 0
    cards.each do |card|
      total = if %w[Jack Queen King].include?(card.value)
                total + 10
              elsif card.value == 'Ace'
                total + 11
              else
                total + card.value.to_i
              end
    end
    if total > Game21::CARD_TOTAL_MAXIMUM &&
       cards.any? { |card| card.value == 'Ace' }
      total = correct_for_aces(total)
    end
    total
  end

  private

  def correct_for_aces(total)
    cards.select { |card| card.value == 'Ace' }.size.times do
      total -= 10
      return total if total <= Game21::CARD_TOTAL_MAXIMUM
    end
    total
  end
end

class Deck
  SUITS = %w[Clubs Diamonds Hearts Spades]
  NUMBERS = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]

  attr_accessor :cards

  def initialize
    @cards = generate_deck.shuffle
  end

  private

  def generate_deck
    SUITS.each_with_object([]) do |suit, deck|
      NUMBERS.each { |number| deck << Card.new(suit, number) }
    end
  end
end

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{value} of #{suit}"
  end
end

class Participant
  include Clearable

  attr_accessor :turn_outcome
  attr_reader :name, :hand

  def initialize(msg)
    @name = ask_for_name(msg)
    @hand = Hand.new
    @turn_outcome = nil
  end

  def bust?
    hand.total > Game21::CARD_TOTAL_MAXIMUM
  end

  def won?
    hand.total == Game21::CARD_TOTAL_MAXIMUM
  end

  def status
    turn_outcome.to_s.upcase
  end

  def reset
    self.turn_outcome = nil
    @hand = Hand.new
  end

  def self.players_names
    names = []
    ObjectSpace.each_object(self) do |player|
      next if player.name.nil?
      names << player.name.downcase
    end
    names
  end

  private

  def ask_for_name(msg)
    clear
    puts "Player #{Player.display_count}:" if self.class == Player
    puts msg
    loop do
      response = gets.chomp
      return response if name_valid?(response)
      display_invalid_name_alert
    end
  end

  def name_valid?(response)
    response.length >= 3 && !response.include?(' ') &&
      !Participant.players_names.include?(response.downcase)
  end

  def display_invalid_name_alert
    puts(<<~INVALID)

      Invalid entry. Name must:
      * player names can't be the same
      * be 3 or more characters in length
      * not include spaces

      Try again:
    INVALID
  end
end

class Player < Participant
  attr_reader :active, :chips, :bet, :total_winnings, :games_played,
              :wins, :ties, :losses

  @count = 0

  def initialize
    self.class.count
    super("What's your name?")
    @active = true
    @chips = ask_for_chips
    @bet = 0
    @total_winnings = 0
    @games_played = 0
    @wins = 0
    @ties = 0
    @losses = 0
  end

  # ivar getter and setter methods don't work for class variables?
  # def self.count
  #   @count
  # end

  # def self.count=(n)
  #   @count += n
  # end

  def self.count
    @count += 1
  end

  def self.display_count
    @count
  end

  def make_bet
    response = ''
    loop do
      response = gets.chomp
      break if valid_bet?(response)
      display_invalid_bet_alert
    end
    self.bet = response.to_i
  end

  def process_win
    self.chips += bet
    self.total_winnings += bet
    self.wins += 1
    self.turn_outcome = :won
  end

  def process_loss
    self.chips -= bet
    self.total_winnings -= bet
    self.losses += 1
    self.turn_outcome = :lost
  end

  def process_tie
    self.ties += 1
  end

  def play_again
    puts "#{name}, would you like to play again? (y/n)" if active
    puts "#{name}, would you like to jump back in this round?" if !active
    loop do
      answer = gets.chomp.downcase
      if %w[n no].include?(answer)
        self.active = false
        break
      elsif %w[y yes].include?(answer)
        self.active = true
        break
      end
      puts "Sorry, I didn't get that. Enter yes or no..."
    end
  end

  def reset
    self.games_played += 1
    self.bet = 0
    super
  end

  private

  attr_writer :active, :chips, :bet, :total_winnings, :games_played,
              :wins, :ties, :losses

  def ask_for_chips
    puts ''
    puts "You can place a bet that you'll win after the dealer deals."
    puts ''
    puts "#{name}, how many chips do you have to bet with?"
    loop do
      response = gets.chomp
      return response.to_i if valid_number_of_chips?(response)
      display_invalid_number_of_chips_alert
    end
  end

  def valid_number_of_chips?(response)
    response == response.to_i.to_s && response.to_i >= 100
  end

  def display_invalid_number_of_chips_alert
    puts(<<~INVALID)

      Invalid entry. Number of chips must be:
      * a positive number
      * greater than or equal to 100

      Try again:
    INVALID
  end

  def valid_bet?(response)
    response == response.to_i.to_s && response.to_i <= chips
  end

  def display_invalid_bet_alert
    puts(<<~INVALID)

      Invalid entry. Your bet must:
      * greater than or equal to 0
      * be less than or equal than the number of chips you currently have

      Try again:
    INVALID
  end
end

class Dealer < Participant
  attr_accessor :deck, :turn

  def initialize
    super("What's the dealer's name?")
    @deck = Deck.new
    @turn = false
  end

  def deal
    self.deck = Deck.new if deck.cards.empty?
    deck.cards.pop
  end

  def reset
    self.turn = false
    super
  end
end

class Game21
  include Clearable
  include Continuable

  PLAYER_MAX = 7
  DEALER_MINIMUM = 17
  CARD_TOTAL_MAXIMUM = 21

  attr_accessor :dealer, :players, :active_players

  def initialize
    display_welcome_message
    @dealer = Dealer.new
    @players = []
    ask_for_number_of_players.times { @players << Player.new }
    @active_players = @players.clone
  end

  def start
    loop do
      display_table
      ready_to_start_this_round?
      take_bets
      deal_cards
      players_turn
      dealers_turn if any_players_stayed?
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    clear
    puts 'Welcome to 21!'
    puts ''
    press_any_key_to_continue('begin')
  end

  def ask_for_number_of_players
    clear
    puts 'How many players?'
    loop do
      response = gets.chomp
      return response.to_i if valid_number_of_players?(response)
      puts display_invalid_number_of_players_alert
    end
  end

  def valid_number_of_players?(response)
    response == response.to_i.to_s && (1..PLAYER_MAX).cover?(response.to_i)
  end

  def display_invalid_number_of_players_alert
    puts(<<~INVALID)

      Invalid entry. Number of players must be:
      * a positive number
      * between 1 - #{PLAYER_MAX}

      Try again:
    INVALID
  end

  def display_table
    full_deck_size = Deck::SUITS.size * Deck::NUMBERS.size
    current_deck_size = dealer.deck.cards.size
    clear
    display_game_title
    display_players_score
    display_hands if current_deck_size < full_deck_size
  end

  def display_game_title
    puts 'Game 21'
    puts ''
  end

  def display_players_score
    active_players.each do |player|
      puts "#{player.name.upcase}'S SCORE:"
      puts "Games played: #{player.games_played}"
      display_player_chips_and_winnings(player)
      display_player_scores(player)
      puts ''
    end
  end

  def display_player_chips_and_winnings(player)
    puts "Chips: #{player.chips}, Winnings: #{player.total_winnings} chips"
  end

  def display_player_scores(player)
    puts "Wins: #{player.wins}, Losses: #{player.losses}, Ties: #{player.ties}"
  end

  def ready_to_start_this_round?
    puts "#{dealer.name} is ready to deal."
    puts ''
    press_any_key_to_continue('start this round')
  end

  def deal_cards
    2.times do
      active_players.each do |player|
        player.hand << dealer.deal
        display_table
        sleep(1)
      end
      dealer.hand << dealer.deal
      display_table
      sleep(1)
    end
  end

  def display_hands
    puts "PLAYERS' HANDS"
    display_players_hands
    display_dealers_hand
  end

  def display_players_hands
    active_players.each do |player|
      display_players_hand_name(player)
      player.hand.cards.each { |card| puts card }
      puts ''
    end
  end

  def display_dealers_hand
    display_players_hand_name
    dealer.hand.cards.each_with_index do |card, index|
      if !dealer.turn && index == 0
        puts 'Facedown card'
      else
        puts card
      end
    end
    puts ''
  end

  def display_players_hand_name(player = dealer)
    name = player.name.upcase
    outcome = player.turn_outcome
    puts "#{name}#{' - ' + player.status unless outcome.nil?}"
  end

  def take_bets
    active_players.each do |player|
      display_table
      puts "#{player.name}, you currently have #{player.chips} chips."
      puts ''
      puts 'How many chips would you like to bet?'
      player.make_bet
      puts ''
      puts "You bet #{player.bet}."
      puts ''
      press_any_key_to_continue
    end
  end

  def players_turn
    active_players.each do |player|
      display_player_up(player)
      player_goes(player)
      determine_turn_outcome(player)
      display_players_turn_outcome(player)
      press_any_key_to_continue
    end
  end

  def display_player_up(player)
    display_table
    puts "Now it's #{player.name}'s' turn."
    puts ''
    press_any_key_to_continue
  end

  def player_goes(player)
    response = ''
    loop do
      break if player.won?
      display_table
      puts "#{player.name}, enter 'h' to hit or 's' to stay:"
      response = gets.chomp
      hit(player) if hit?(response)
      break if %w[s stay].include?(response) || player.bust?
      display_invalid_turn_choice_alert unless hit?(response)
    end
  end

  def display_invalid_turn_choice_alert
    puts "Invalid response."
    puts ''
    press_any_key_to_continue
  end

  def any_players_stayed?
    active_players.any? { |player| player.turn_outcome == :stayed }
  end

  def names_of_players_who_stayed
    player_names = players_who_stayed.each_with_object([]) do |player, names|
      names << player.name
    end
    if player_names.empty?
      ''
    elsif player_names.size == 1
      player_names.first
    elsif player_names.size == 2
      player_names.join(' and ')
    else
      player_names[-1] = "and #{player_names.last}"
      player_names.join(', ')
    end
  end

  def dealers_turn
    display_player_up(dealer)
    dealer.turn = true
    dealer_goes
    determine_turn_outcome(dealer)
    process_dealer_turn_outcome
  end

  def dealer_goes
    while dealer.hand.total <= DEALER_MINIMUM
      hit(dealer)
    end
  end

  def stay?(response)
    %w[s stay].include?(response)
  end

  def hit?(response)
    %w[h hit].include?(response)
  end

  def hit(player)
    player.hand << dealer.deal
    display_table
    puts "#{player.name} got a #{player.hand.cards.last}."
    puts ''
    press_any_key_to_continue
  end

  def determine_turn_outcome(player)
    player.turn_outcome = if player.hand.total < 21
                            :stayed
                          elsif player.hand.total == 21
                            :twentyone
                          else
                            :busted
                          end
  end

  def display_players_turn_outcome(player)
    display_table
    case player.turn_outcome
    when :stayed
      display_stayed(player)
    when :twentyone
      display_21(player)
      player.process_win
    when :busted
      display_busted(player)
      player.process_loss
    end
    puts ''
  end

  def players_who_stayed
    active_players.select { |player| player.turn_outcome == :stayed }
  end

  def process_dealer_turn_outcome
    display_table
    case dealer.turn_outcome
    when :twentyone
      dealer_outcome_21
    when :busted
      dealer_outcome_busted
    else
      compare_dealers_hand
    end
  end

  def dealer_outcome_21
    display_21(dealer)
    puts ''
    press_any_key_to_continue
    process_players_losses_after_dealer_21
  end

  def process_players_losses_after_dealer_21
    display_table
    puts "#{names_of_players_who_stayed}, you lost."
    puts ''
    players_who_stayed.each do |player|
      puts "#{player.name}, you lost #{player.bet} chips."
      puts ''
      player.process_loss
    end
    press_any_key_to_continue
  end

  def dealer_outcome_busted
    display_busted(dealer)
    puts ''
    press_any_key_to_continue
    process_players_wins_after_dealer_busts
  end

  def process_players_wins_after_dealer_busts
    display_table
    puts "#{names_of_players_who_stayed}, you won!"
    puts ''
    players_who_stayed.each do |player|
      puts "#{player.name}, you won #{player.bet} chips!"
      puts ''
      player.process_win
    end
    press_any_key_to_continue
  end

  def compare_dealers_hand
    display_stayed(dealer)
    puts ''
    puts "Let's see who won..."
    puts ''
    press_any_key_to_continue
    compare_dealers_hand_to_each_player_who_stayed
  end

  def compare_dealers_hand_to_each_player_who_stayed
    players_who_stayed.each do |player|
      display_player_being_compared(player)
      if player.hand > dealer.hand
        display_won(player)
        player.process_win
      elsif player.hand < dealer.hand
        display_won(dealer)
        display_lost(player)
        player.process_loss
      else
        display_tied(player)
        player.process_tie
      end
      press_any_key_to_continue
    end
  end

  def display_player_being_compared(player)
    display_table
    puts "#{player.name}, you have #{player.hand.total}."
    puts ''
  end

  def display_busted(player)
    puts "#{player.name}, you busted!"
    puts "\nYou lost #{player.bet} chips." if player.class == Player
  end

  def display_21(player)
    puts "#{player.name}, you got 21. You won!"
    puts "\nYou won #{player.bet} chips!" if player.class == Player
  end

  def display_stayed(player)
    puts "#{player.name} stayed with #{player.hand.total}."
  end

  def display_won(player)
    puts "#{player.name}, you won!"
    puts "\nYou won #{player.bet} chips!" if player.class == Player
    puts ''
  end

  def display_lost(player)
    puts "#{player.name}, you lost #{player.bet} chips."
    puts ''
  end

  def display_tied(player)
    puts "#{dealer.name} and #{player.name}, you tied!"
    puts ''
  end

  def play_again?
    players.each do |player|
      display_table
      player.play_again
    end
    players.any?(&:active)
  end

  def reset
    reset_active_players_instance_variable
    active_players.each(&:reset)
    dealer.reset
  end

  def reset_active_players_instance_variable
    active_players.clear
    players.each { |player| active_players << player if player.active }
  end

  def display_goodbye_message
    display_table
    puts 'Thanks for playing. Goodbye!'
  end
end

Game21.new.start
