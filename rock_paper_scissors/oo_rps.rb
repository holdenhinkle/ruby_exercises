require 'io/console'

# The RPSGame class is the game engine
class RPSGame
  NUM_GAMES_TO_WIN = 10

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    @number_of_games = 0
    @current_winner = nil
  end

  def play
    display_welcome_message
    press_any_key_to_continue('begin')

    loop do
      play_game
      break if human.score == NUM_GAMES_TO_WIN ||
               computer.score == NUM_GAMES_TO_WIN
      press_any_key_to_continue
    end

    display_overall_winner
    display_goodbye_message
  end

  def display_welcome_message
    system('clear') || system('cls')
    puts "#{human.name}, welcome to #{Moves.choices}!"
    puts ''
    puts "The first player to win #{NUM_GAMES_TO_WIN} games wins!"
    puts ''
  end

  def press_any_key_to_continue(go = 'continue')
    puts "Press any key to #{go}:"
    STDIN.getch
  end

  def play_game
    system('clear') || system('cls')
    display_number_of_games
    display_score
    human.choose
    computer.choose(human.history)
    display_moves
    determine_winner
    display_winner
    update_score
  end

  def display_moves
    puts "#{human.name}, you chose #{human.move.value}."
    puts "#{computer.name}, the computer, chose #{computer.move.value}."
    puts ''
  end

  def determine_winner
    human_move = human.move.value
    computer_move = computer.move.value
    @current_winner = if Moves.winning(human_move).include?(computer_move)
                        :human
                      elsif Moves.winning(computer_move).include?(human_move)
                        :computer
                      else
                        :tie
                      end
  end

  def display_winner
    case @current_winner
    when :human
      puts "#{human.name}, you won!"
    when :computer
      puts 'The computer won!'
    else
      puts "It's a tie."
    end
    puts ''
  end

  def update_score
    @number_of_games += 1
    case @current_winner
    when :human
      human.won
    when :computer
      computer.won
    end
  end

  def display_number_of_games
    puts "Number of games: #{@number_of_games}"
  end

  def display_score
    human_score = human.score
    computer_score = computer.score
    puts "#{human.name}'s score: #{human_score}"
    puts "#{computer.name}'s score: #{computer_score}"
    puts "Ties: #{@number_of_games - human_score - computer_score}"
    puts ''
  end

  def display_overall_winner
    if human.score == 10
      puts "Congratulations #{human.name}! You won 10 games!"
    else
      puts "Game over. #{computer.name} won #{NUM_GAMES_TO_WIN} games."
    end
    puts ''
  end

  def display_goodbye_message
    puts "Thanks for playing #{Moves.choices}. Good bye!"
  end
end

# The Player class is the super class for Human and Computer
class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = []
  end

  def display_history
    system('clear') || system('cls')
    if history.empty?
      puts "You don't have any history yet. Play your first round."
    else
      puts "You've made #{history.size} move(s):"
      history.each_with_index { |move, idx| puts "#{idx + 1}. #{move}" }
    end
    puts ''
  end

  def won
    self.score += 1
  end
end

# The Human class handles the player's name and moves
class Human < Player
  def set_name
    system('clear') || system('cls')
    response = ''
    loop do
      puts "Hello! What's your name?"
      response = gets.chomp.capitalize
      break if valid_name?(response)
      display_invalid_name
    end
    self.name = response
  end

  def choose
    response = nil
    loop do
      choose_prompt
      response = gets.chomp.downcase
      display_history if response == 'h'
      break if Moves.valid?(response)
      puts 'Invalid entry. Please try again.' if response != 'h'
      puts ''
    end
    self.move = Moves.new_move(self, Moves.convert_to_value(response))
  end

  private

  def choose_prompt
    puts "Make a choice: #{Moves.choices}."
    puts "Enter the word or 'r', 'p', 's', 'sp', 'l'."
    puts "Press 'h' to see your choice history."
  end

  def valid_name?(name)
    true unless name.length < 3 || name.chars.any?(' ')
  end

  def display_invalid_name
    puts 'Invalid entry. Your name:'
    puts '* Cannot include empty spaces'
    puts '* Must be at least 3 characters long'
    puts ''
  end
end

# The Computer class handles the computer's name and moves
class Computer < Player
  def set_name
    self.name = %w[R2D2 Hal Chappie BB8].sample
  end

  def choose(human_history)
    history = ignore_humans_current_move(human_history)

    if two_or_more_moves?(history) &&
       last_two_moves_were_the_same?(history)
      self.move = Moves.new_move(self, Moves.defensive(history.last))
    elsif three_or_more_moves?(history) &&
          half_or_more_moves_were_the_same?(history)
      self.move = Moves.new_move(self, Moves.defensive(half_move(history)))
    else
      self.move = Moves.new_move(self, Moves.random)
    end
  end

  private

  # no cheating - the computer shouldn't know the human's current move
  def ignore_humans_current_move(human_history)
    history = human_history.clone
    history.pop
    history
  end

  def two_or_more_moves?(history)
    history.size >= 2
  end

  def three_or_more_moves?(history)
    history.size >= 3
  end

  def last_two_moves_were_the_same?(history)
    history[-1] == history[-2]
  end

  def half_or_more_moves_were_the_same?(history)
    Moves::CHOICES.each do |choice|
      return true if history.count(choice[:name]) >= history.size / 2.0
    end
    false
  end

  def half_move(history)
    Moves::CHOICES.each do |choice|
      return choice[:name] if history.count(choice[:name]) >= history.size / 2.0
    end
  end
end

# The Moves class is the super class to the Rock, Paper, Scissors, Spock and
# Lizard classes.
class Moves
  CHOICES = [
    { name: 'rock', input: %w(r rock),
      wins_to: %w(scissors lizard), looses_to: %w(paper spock) },
    { name: 'paper', input: %w(p paper),
      wins_to: %w(rock spock), looses_to: %w(scissors lizard) },
    { name: 'scissors', input: %w(s scissors),
      wins_to: %w(paper lizard), looses_to: %w(rock spock) },
    { name: 'spock', input: %w(sp spock),
      wins_to: %w(scissors rock), looses_to: %w(paper lizard) },
    { name: 'lizard', input: %w(l lizard),
      wins_to: %w(paper spock), looses_to: %w(rock scissors) }
  ].freeze

  attr_reader :value

  def initialize(player, value)
    @value = value
    player.history << value
  end

  def self.choices
    CHOICES.map { |choice| choice[:name].capitalize }.join(', ')
  end

  def self.new_move(player, choice)
    case choice
    when 'rock' then Rock.new(player)
    when 'paper' then Paper.new(player)
    when 'scissors' then Scissors.new(player)
    when 'spock' then Spock.new(player)
    when 'lizard' then Lizard.new(player)
    end
  end

  def self.random
    CHOICES.each_with_object([]) { |choice, arr| arr << choice[:name] }.sample
  end

  def self.defensive(move)
    CHOICES.each do |choice|
      return choice[:looses_to].sample if choice[:name] == move
    end
  end

  def self.valid?(move)
    CHOICES.each { |choice| return true if choice[:input].include?(move) }
    false
  end

  def self.convert_to_value(move)
    CHOICES.each do |choice|
      return choice[:name] if choice[:input].include?(move)
    end
  end

  def self.winning(move)
    Moves::CHOICES.each do |choice|
      return choice[:wins_to] if choice[:name] == move
    end
  end

  def to_s
    @choice
  end
end

# The Rock class is a sub-class of the Moves class
class Rock < Moves
  def initialize(player)
    super(player, 'rock')
  end
end

# The Paper class is a sub-class of the Moves class
class Paper < Moves
  def initialize(player)
    super(player, 'paper')
  end
end

# The Scissors class is a sub-class of the Moves class
class Scissors < Moves
  def initialize(player)
    super(player, 'scissors')
  end
end

# The Spock class is a sub-class of the Moves class
class Spock < Moves
  def initialize(player)
    super(player, 'spock')
  end
end

# The Lizard class is a sub-class of the Moves class
class Lizard < Moves
  def initialize(player)
    super(player, 'lizard')
  end
end

RPSGame.new.play
