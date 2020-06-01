require 'io/console'

LINE_WIDTH = 23
EMPTY_SQUARE = ' '
USERS_MARKER = 'X'
COMPUTERS_MARKER = 'O'
MATCH = 5
MIDDLE_SQUARE = 5
CORNER_SQUARES = [1, 3, 7, 9]
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                 [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
                 [1, 5, 9], [3, 5, 7]]            # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

def line_break
  puts ""
end

def clear_screen
  system('clear') || system('cls')
end

def wait
  sleep(2)
end

def begin_game(players)
  display_game_welcome
  ask_for_name(players)
  display_game_rules(players)
  display_start_game_prompt
end

def display_game_welcome
  clear_screen
  puts "Welcome to".center(LINE_WIDTH)
  display_game_title
  line_break
end

def ask_for_name(players)
  puts "Enter a screen name:"
  name = gets.chomp
  players[:user][:name] = name
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_game_rules(players)
  line_break
  puts "Hello, #{players[:user][:name]}!"
  line_break
  wait
  puts "#{players[:user][:name]}, you're 'X'"
  puts "and #{players[:computer][:name]}, the computer,"
  puts "is 'O'"
  line_break
  wait
  puts "Here are some simple rules:"
  line_break
  wait
  puts "1. The first player to"
  puts "win 5 games wins the"
  puts "match."
  line_break
  wait
  puts "2. To keep things fair,"
  puts "the player who goes"
  puts "first is chosen randomly."
  line_break
  wait
  puts "3. If you win a game then"
  puts "you get to go first the"
  puts "next game."
  line_break
  wait
  puts "Have fun #{players[:user][:name]}!"
  wait
  line_break
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def display_start_game_prompt
  puts "Press any key to start:"
  STDIN.getch
end

def display_board(players, squares)
  clear_screen
  display_game_title
  display_game_goal
  display_leader_board(players)
  display_grid(squares)
end

def display_game_title
  puts "*** tic tac toe ***".upcase.center(LINE_WIDTH)
  line_break
end

def display_game_goal
  puts "The first player".center(LINE_WIDTH)
  puts "to win 5 games".center(LINE_WIDTH)
  puts "wins the match!".center(LINE_WIDTH)
  line_break
end

def display_leader_board(players)
  display_match_score(players)
  display_game_score(players)
end

def display_match_score(players)
  puts "match score".upcase.center(LINE_WIDTH)
  # rubocop:disable Metrics/LineLength
  puts "X: #{players[:user][:name]}: #{players[:user][:match_score]}".center(LINE_WIDTH)
  puts "O: #{players[:computer][:name]}: #{players[:computer][:match_score]}".center(LINE_WIDTH)
  # rubocop:enable Metrics/LineLength
  line_break
end

def display_game_score(players)
  puts "game score".upcase.center(23)
  # rubocop:disable Metrics/LineLength
  puts "X: #{players[:user][:name]}: #{players[:user][:game_score]}".center(LINE_WIDTH)
  puts "O: #{players[:computer][:name]}: #{players[:computer][:game_score]}".center(LINE_WIDTH)
  # rubocop:enable Metrics/LineLength
  line_break
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_grid(squares)
  puts "       |       |       "
  puts "       |       |       "
  puts "   #{squares[1]}   |   #{squares[2]}   |   #{squares[3]}   "
  puts "       |       |       "
  puts "      1|      2|      3"
  puts "-----------------------"
  puts "       |       |       "
  puts "       |       |       "
  puts "   #{squares[4]}   |   #{squares[5]}   |   #{squares[6]}   "
  puts "       |       |       "
  puts "      4|      5|      6"
  puts "-----------------------"
  puts "       |       |       "
  puts "       |       |       "
  puts "   #{squares[7]}   |   #{squares[8]}   |   #{squares[9]}   "
  puts "       |       |       "
  puts "      7|      8|      9"
  line_break
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_squares
  squares = {}
  (1..9).each { |num| squares[num] = EMPTY_SQUARE }
  squares
end

def initialize_current_player(players)
  players.keys.sample.to_s
end

def display_current_player(current_player)
  if current_player == 'user'
    puts "You go first!"
  else
    puts "The computer goes first!"
  end
end

def alternate_player(current_player)
  current_player == 'user' ? 'computer' : 'user'
end

def players_turn(current_player, squares)
  current_player == 'user' ? users_turn(squares) : computers_turn(squares)
end

def users_turn(squares)
  prompt("Choose a valid square: #{joinor(valid_moves(squares))}")
  chosen_square = nil
  loop do
    chosen_square = gets.chomp.to_i
    break if valid_move?(chosen_square, squares)
    puts "That wasn't a valid square."
  end
  update_board!(USERS_MARKER, chosen_square, squares)
end

def computers_turn(squares)
  move = nil
  if ai_winning_move?(squares)
    move = ai_determine_winning_or_blocking_move(squares, COMPUTERS_MARKER)
  elsif ai_blocking_move?(squares)
    move = ai_determine_winning_or_blocking_move(squares, USERS_MARKER)
  elsif ai_offensive_move?(squares)
    move = ai_determine_offensive_move(squares)
  else
    move = ai_random_move(squares)
  end
  update_board!(COMPUTERS_MARKER, move, squares)
end

def ai_winning_move?(squares)
  ai_winning_or_blocking_move?(squares, COMPUTERS_MARKER)
end

def ai_blocking_move?(squares)
  ai_winning_or_blocking_move?(squares, USERS_MARKER)
end

def ai_winning_or_blocking_move?(squares, marker)
  WINNING_LINES.each do |line|
    if line.count { |square| squares[square] == marker } == 2 &&
       line.any? { |square| squares[square] == EMPTY_SQUARE }
      return true
    end
  end
  false
end

def ai_determine_winning_or_blocking_move(squares, marker)
  WINNING_LINES.each do |line|
    if line.count { |square| squares[square] == marker } == 2 &&
       line.each { |square| return square if squares[square] == EMPTY_SQUARE }
    end
  end
end

def ai_offensive_move?(squares)
  squares[5] == EMPTY_SQUARE ||
    CORNER_SQUARES.any? { |corner| squares[corner] == EMPTY_SQUARE }
end

def ai_determine_offensive_move(squares)
  if squares[5] == EMPTY_SQUARE
    MIDDLE_SQUARE
  else
    ai_corner_move(squares)
  end
end

def ai_corner_move(square)
  available_corners = []
  CORNER_SQUARES.each do |corner|
    available_corners << corner if square[corner] == EMPTY_SQUARE
  end
  available_corners.sample
end

def ai_random_move(squares)
  valid_moves(squares).sample
end

def joinor(array, delimiter = ', ', combining_word = 'or')
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(" #{combining_word} ")
  else
    array[-1] = "#{combining_word} #{array.last}"
    array.join(delimiter)
  end
end

def valid_move?(chosen_square, squares)
  squares[chosen_square] == EMPTY_SQUARE
end

def valid_moves(squares)
  squares.keys.select { |square| squares[square] == EMPTY_SQUARE }
end

def update_board!(marker, chosen_square, squares)
  squares[chosen_square] = marker
end

def game_over?(players, squares)
  game_winner?(players[:user][:marker], squares) ||
    game_winner?(players[:computer][:marker], squares) ||
    board_full?(squares)
end

def game_winner?(marker, squares)
  WINNING_LINES.each do |line|
    return true if line.all? { |square| squares[square] == marker }
  end
  false
end

def board_full?(squares)
  valid_moves(squares).empty?
end

def match_over?(players)
  players.any? { |player| match_winner?(player[1][:game_score]) }
end

def match_winner?(score)
  score == MATCH
end

def display_match_winner(players)
  clear_screen
  if match_winner?(players[:user][:game_score])
    display_user_won_match(players)
  else
    display_computer_won_match(players)
  end
  line_break
end

def display_user_won_match(players)
  players[:user][:match_score] += 1
  display_game_title
  display_leader_board(players)
  puts "#{players[:user][:name]}, you won the match!"
end

def display_computer_won_match(players)
  players[:computer][:match_score] += 1
  display_game_title
  display_leader_board(players)
  puts "#{players[:computer][:name]} won the match!"
end

def play_again?
  prompt("Would you like to play again?")
  play_again = ''
  loop do
    play_again = gets.chomp.downcase
    return true if %w[y yes].include?(play_again)
    return false if %w[n no].include?(play_again)
    puts "Sorry, I didn't get that. Enter y for yes or no for no."
  end
end

def display_goodbye_message
  clear_screen
  puts "You played...".center(LINE_WIDTH)
  line_break
  display_game_title
  puts "Have a great day!".center(LINE_WIDTH)
end

players = { user:
            { name: '', marker: USERS_MARKER, match_score: 0 },
            computer:
            { name: 'R2D2', marker: COMPUTERS_MARKER, match_score: 0 } }

begin_game(players)

loop do
  players.each { |_, value| value[:game_score] = 0 }
  current_player = initialize_current_player(players)

  loop do
    squares = initialize_squares
    display_board(players, squares)
    display_current_player(current_player)

    wait

    loop do
      players_turn(current_player, squares)
      display_board(players, squares)
      break if game_over?(players, squares)
      current_player = alternate_player(current_player)
    end

    if game_winner?(players[:user][:marker], squares)
      players[:user][:game_score] += 1
      display_board(players, squares)
      puts "#{players[:user][:name]}, you won!"
      current_player = 'user'
    elsif game_winner?(players[:computer][:marker], squares)
      players[:computer][:game_score] += 1
      display_board(players, squares)
      puts "#{players[:computer][:name]} won!"
      current_player = 'computer'
    else
      puts "#{players[:user][:name]}, it's a tie!"
    end

    wait

    break if match_over?(players)
  end

  display_match_winner(players)

  break unless play_again?
end

display_goodbye_message
