require 'io/console'

module Clearable
  def clear
    system('clear') || system('cls')
  end
end

class Board
  attr_accessor :squares
  attr_reader :matrix, :winning_lines

  def initialize(matrix)
    @matrix = matrix
    @squares = {}
    (1..(@matrix**2)).each { |key| @squares[key] = Square.new }
    @winning_lines = determine_winning_lines
  end

  def draw
    grid = ''
    1.upto(matrix) do |row|
      display_empty_row(grid, row)
      display_marker_row(grid, row)
      display_row_with_square_number(grid, row)
      display_divider_row(grid, row) unless row == matrix
    end
    puts grid
  end

  def format_available_moves
    moves = ''
    unmarked_keys.each_with_index do |move, idx|
      moves << if idx == 0
                 move.to_s
               elsif idx == unmarked_keys.size - 1
                 ", or #{move}."
               else
                 ", #{move}"
               end
    end
    moves
  end

  def []=(square, marker)
    @squares[square].marker = marker
  end

  def unmarked_keys
    squares.select { |_, square| square.unmarked? }.keys
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    winning_lines.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if winning_line?(squares)
    end
    nil
  end

  def full?
    unmarked_keys.empty?
  end

  def corner_squares
    [1, 1 + (matrix - 1), matrix**2 - (matrix - 1), matrix**2]
  end

  def center_square
    matrix**2 / 2 + 1
  end

  def reset
    (1..matrix**2).each { |key| squares[key] = Square.new }
  end

  private

  def determine_winning_lines
    row_wins + col_wins + diagonal_wins
  end

  def row_wins
    row_wins_array = []
    1.upto(matrix) do |row|
      row_wins_array << Array.new
      (row * matrix - (matrix - 1)).upto(row * matrix) do |column|
        row_wins_array[row - 1] << column
      end
    end
    row_wins_array
  end

  def col_wins
    col_wins_array = []
    1.upto(matrix) do |column|
      col_wins_array << Array.new
      sub_array = column - 1
      1.upto(matrix) do
        if col_wins_array[sub_array].empty?
          col_wins_array[sub_array] << column
        else
          col_wins_array[sub_array] << col_wins_array[sub_array].last + matrix
        end
      end
    end
    col_wins_array
  end

  def diagonal_wins
    diag_wins_array = [[], []]
    matrix.times do
      top_left_to_bottom_right_win(diag_wins_array[0])
      top_right_to_bottom_left_win(diag_wins_array[1])
    end
    diag_wins_array
  end

  def top_left_to_bottom_right_win(sub_array)
    sub_array << if sub_array.empty?
                   1
                 else
                   sub_array.last + matrix + 1
                 end
  end

  def top_right_to_bottom_left_win(sub_array)
    sub_array << if sub_array.empty?
                   matrix
                 else
                   sub_array.last + matrix - 1
                 end
  end

  def display_empty_row(grid, row)
    (row * matrix - (matrix - 1)).upto(row * matrix) do |square_number|
      break if row * matrix == square_number
      grid << "     |"
    end
    grid << "\n"
  end

  def display_marker_row(grid, row)
    (row * matrix - (matrix - 1)).upto(row * matrix) do |square_number|
      content = "  #{squares[square_number]}"
      grid << if row * matrix == square_number
                content
              else
                "#{content}  |"
              end
    end
    grid << "\n"
  end

  def display_row_with_square_number(grid, row)
    (row * matrix - (matrix - 1)).upto(row * matrix) do |square_number|
      width = 5 - square_number.to_s.length
      content = "#{' ' * width}#{square_number}"
      grid << if row * matrix == square_number
                content
              else
                "#{content}|"
              end
    end
    grid << "\n"
  end

  def display_divider_row(grid, row)
    (row * matrix - (matrix - 1)).upto(row * matrix) do |square_number|
      content = "-----"
      grid << if row * matrix == square_number
                content
              else
                "#{content}+"
              end
    end
    grid << "\n"
  end

  def winning_line?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != matrix
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def to_s
    marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :games_played, :wins, :ties
  attr_reader :name, :marker

  def initialize(wins, ties)
    @games_played = 0
    @wins = wins
    @ties = ties
  end

  def self.players_markers
    markers = []
    ObjectSpace.each_object(self) do |player|
      next if player.marker.nil?
      markers << player.marker.downcase
    end
    markers
  end

  def played_game
    self.games_played += 1
  end

  def won
    self.wins += 1
  end

  def tied
    self.ties += 1
  end

  private

  def smart_move(board)
    if first_move?(board)
      first_move(board)
    elsif winning_move(board)
      winning_move(board)
    elsif defensive_move(board)
      defensive_move(board)
    elsif offensive_move(board)
      offensive_move(board)
    else
      random_move(board)
    end
  end

  def first_move?(board)
    board.squares.none? { |square| square[1].marker == marker }
  end

  def first_move(board)
    possible_first_moves = board.corner_squares.push(board.center_square)
    valid_first_moves = possible_first_moves.select do |square|
      board.squares[square].marker == Square::INITIAL_MARKER
    end
    valid_first_moves.sample
  end

  def winning_move(board)
    board.winning_lines.each do |line|
      empty_square = nil
      marker_counter = 0
      line.each do |square|
        board_marker = board.squares[square].marker
        empty_square = square if board_marker == Square::INITIAL_MARKER
        marker_counter += 1 if board_marker == marker
      end
      if empty_square && marker_counter == board.matrix - 1
        return empty_square
      end
    end
    nil
  end

  def defensive_move(board)
    board.winning_lines.each do |line|
      empty_square = nil
      board_markers = []
      line.each do |square|
        board_marker = board.squares[square].marker
        empty_square = square if board_marker == Square::INITIAL_MARKER
        board_markers << board_marker if board_marker != Square::INITIAL_MARKER
      end
      if empty_square && board_markers.size == board.matrix - 1 &&
         board_markers.min == board_markers.max
        return empty_square
      end
    end
    nil
  end

  def offensive_move(board)
    available_lines = offensive_move_select_lines(board)
    return false if available_lines.empty?
    best_line = offensive_move_select_best_line(board, available_lines)
    return false if best_line.nil?
    offense_move_select_square_from_line(board, best_line)
  end

  def offensive_move_select_lines(board)
    board.winning_lines.select do |line|
      line.all? do |square|
        board.squares[square].marker == Square::INITIAL_MARKER ||
          board.squares[square].marker == marker
      end
    end
  end

  def offensive_move_select_best_line(board, available_lines)
    best_line = nil
    best_marker_count = 0
    available_lines.each do |line|
      marker_count = 0
      line.each do |square|
        marker_count += 1 if board.squares[square].marker == marker
      end
      if best_marker_count < marker_count
        best_marker_count = marker_count
        best_line = line
      end
    end
    best_line
  end

  def offense_move_select_square_from_line(board, best_line)
    hsh = {}
    best_line.each do |square|
      hsh[square] = board.squares[square].marker
    end
    hsh.reject { |_, value| value == marker }.keys.sample
  end

  def random_move(board)
    board.unmarked_keys.sample
  end
end

class Human < Player
  include Clearable

  attr_accessor :active

  @@num_human_players = 0

  def initialize
    @@num_human_players += 1
    @name = ask_for_name
    @marker = ask_for_marker
    @active = true
    super(0, 0)
  end

  def self.players_names
    names = []
    ObjectSpace.each_object(self) do |player|
      next if player.marker.nil?
      names << player.name.downcase
    end
    names
  end

  def move(board)
    choice = nil
    loop do
      puts "Choose a square: #{board.format_available_moves}"
      puts "Enter 's' for a suggestion:"
      choice = gets.chomp.downcase
      break if board.unmarked_keys.include?(choice.to_i)
      if choice == 's'
        puts "Try square #{smart_move(board)}."
      else
        puts "Sorry, that's not a valid choice."
      end
    end
    board.[]=(choice.to_i, marker)
  end

  def play_again
    puts "#{name}, would you like to play again?" if active
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

  private

  def ask_for_name
    clear
    puts "PLAYER #{@@num_human_players}"
    puts "What's your name?"
    loop do
      response = gets.chomp
      return response if valid_name?(response)
      alert_invalid_name
    end
  end

  def valid_name?(response)
    response.length >= 3 && !response.include?(' ') &&
      !self.class.players_names.include?(response.downcase)
  end

  def alert_invalid_name
    puts "Invalid entry. Your name:"
    puts "* must be unique -- players can't have the same name"
    puts '* should be at least 3 character long'
    puts '* should not include any spaces'
    puts ''
    puts 'Try again:'
  end

  def ask_for_marker
    display_marker_request
    process_marker_request
  end

  def display_marker_request
    clear
    puts "MARKER"
    puts "#{name}, what marker would you like to be?"
    puts ''
    puts 'Enter a single character:'
  end

  def process_marker_request
    loop do
      response = gets.chomp
      return response if valid_marker?(response.downcase)
      alert_invalid_marker
    end
  end

  def valid_marker?(response)
    response.length == 1 && !' '.include?(response) &&
      !self.class.players_markers.include?(response)
  end

  def alert_invalid_marker
    puts "Invalid entry. Your marker:"
    puts "* must be unique -- players can't have the same makers"
    puts '* should be 1 character long'
    puts '* cannot be a space character'
    puts ''
    puts 'Try again:'
  end
end

class Computer < Player
  COMPUTER_MARKERS = %w[C O ! *]

  def initialize(human_markers)
    @marker = choose_marker(human_markers)
    super(0, 0)
  end

  def move(board)
    square = smart_move(board)
    board.[]=(square, marker)
    display_computers_move(square)
  end

  private

  def choose_marker(human_markers)
    COMPUTER_MARKERS.reject { |char| human_markers.include?(char) }.sample
  end

  def display_computers_move(square)
    puts "The computer is going to take square #{square}."
    puts ''
    puts 'Press any key to continue:'
    STDIN.getch
  end
end

class TTTGame
  include Clearable
  attr_accessor :current_player
  attr_reader :matrix, :board, :humans, :active_humans, :computer

  def initialize
    display_welcome_message
    @humans = []
    ask_for_number_of_players.times { @humans << Human.new }
    @active_humans = @humans.clone
    @computer = Computer.new(human_markers)
    @matrix = ask_for_matrix_size
    @board = Board.new(@matrix)
    @current_player = @active_humans[0]
  end

  def play
    clear
    loop do
      display_board
      loop do
        current_player_moves
        clear_screen_and_display_board
        break if board.someone_won? || board.full?
      end
      determine_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def ask_for_number_of_players
    clear
    puts "NUMBER OF PLAYERS"
    puts 'How many players will play with the computer?'
    loop do
      response = gets.chomp
      return response.to_i if number_of_players_valid?(response)
      display_number_of_players_invalid_alert
    end
  end

  def number_of_players_valid?(response)
    response == response.to_i.to_s && (1..5).cover?(response.to_i)
  end

  def display_number_of_players_invalid_alert
    puts 'Invalid entry. Number of players should be:'
    puts '* a positive number'
    puts '* between 1 and 5'
    puts ''
  end

  def human_markers
    active_humans.each_with_object([]) do |human, markers|
      markers << human.marker
    end
  end

  def ask_for_matrix_size
    clear
    puts 'GRID SIZE'
    puts 'Based on the number of players, your grid should be'
    puts "a least #{minimum_matrix_size} squares wide."
    puts ''
    puts 'Enter the width of the grid:'
    loop do
      response = gets.chomp
      return response.to_i if matrix_size_valid?(response)
      display_invalid_matrix_size
    end
  end

  def minimum_matrix_size
    (active_humans.size + 1) * 2 - 1
  end

  def matrix_size_valid?(response)
    response == response.to_i.to_s && response.to_i.odd? &&
      response.to_i >= minimum_matrix_size
  end

  def display_invalid_matrix_size
    puts 'Invalid grid size. Size must be:'
    puts '* a single integer'
    puts '* an odd number'
    puts '* a least as big as the suggested grid size'
    puts ''
    puts 'Try again:'
  end

  def display_welcome_message
    clear
    puts "WELCOME TO TIC TAC TOE!"
    puts ''
    puts 'Press any key to continue:'
    STDIN.getch
  end

  def display_goodbye_message
    clear
    puts 'Thanks for playing Tic Tac Toe!'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_title
    puts 'Tic Tac Toe'
  end

  def display_board
    display_title
    puts ''
    display_score
    puts ''
    board.draw
    puts ''
    display_players_turn unless board.someone_won? || board.full?
    puts ''
  end

  def display_score
    puts 'SCORE:'
    active_humans.each do |human|
      display_human_scores(human)
    end
    display_computer_score
  end

  def display_human_scores(human)
    puts "#{human.name.upcase} (#{human.marker}):"
    puts "Games played: #{human.games_played}"
    puts "Wins: #{human.wins}, Ties: #{human.ties}"
    puts ''
  end

  def display_computer_score
    puts "COMPUTER (#{computer.marker}):"
    puts "Games played: #{computer.games_played}"
    puts "Wins: #{computer.wins}, Ties: #{computer.ties}"
    puts ''
  end

  def display_players_turn
    puts "#{current_player.name}, it's your turn!" if current_player.is_a? Human
  end

  def current_player_moves
    current_player.move(board)
    self.current_player = next_player
  end

  def next_player
    if current_player.class == Human
      current_human_index = active_humans.index(current_player)
      return computer if active_humans.size - 1 == current_human_index
      return active_humans[current_human_index + 1]
    end
    active_humans[0]
  end

  def determine_result
    marker = board.winning_marker
    display_result(marker)
    update_stats(marker)
    display_score
  end

  def display_result(marker)
    clear_screen_and_display_board
    if marker.nil?
      puts "It's a tie!"
    elsif marker == computer.marker
      puts "The computer won!"
    else
      active_humans.each do |human|
        if human.marker == marker
          puts "#{human.name}, you won!"
          break
        end
      end
    end
  end

  def update_stats(marker)
    if marker.nil?
      update_ties
    elsif marker == computer.marker
      update_computer_wins
    else
      update_human_wins(marker)
    end
    update_games_played
  end

  def update_ties
    active_humans.each(&:tied)
    computer.tied
  end

  def update_computer_wins
    computer.won
  end

  def update_human_wins(marker)
    active_humans.each do |human|
      if marker == human.marker
        human.won
        break
      end
    end
  end

  def update_games_played
    active_humans.each(&:played_game)
    computer.played_game
  end

  def play_again?
    humans.each(&:play_again)
    humans.any?(&:active)
  end

  def reset
    board.reset
    reset_active_players
    @current_player = active_humans[0]
    clear
  end

  def reset_active_players
    active_humans.clear
    humans.each { |human| active_humans << human if human.active }
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
