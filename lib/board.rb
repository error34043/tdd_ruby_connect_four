# frozen_string_literal: true

class String
  def use_code(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red;          use_code(31) end
  def green;        use_code(32) end
  def yellow;       use_code(33) end
  def blue;         use_code(34) end
  def magenta;      use_code(35) end
  def teal;         use_code(36) end

  def bg_red;       use_code(41) end
  def bg_green;     use_code(42) end
  def bg_yellow;    use_code(43) end
  def bg_blue;      use_code(44) end
  def bg_magenta;   use_code(45) end
  def bg_teal;      use_code(46) end
  def invert_color;  use_code(7) end

  def typed
    arr = self.split('')
    arr.each do |char|
      print char
      sleep 0.07
    end
    return nil
  end
end

class Board
  attr_accessor :board
  attr_reader :TOP_RIGHT_BOX, :TOP_LEFT_BOX, :MID_RIGHT_BOX, :MID_LEFT_BOX, :BOTTOM_RIGHT_BOX, :BOTTOM_LEFT_BOX, :MID_TOP_BOX, :MID_BOTTOM_BOX, :MID_BOX, :LINE_VERTICAL, :LINE_HORIZONTAL

  TOP_RIGHT_BOX = "\u2510" # ┐
  TOP_LEFT_BOX = "\u250c" # ┌
  MID_RIGHT_BOX = "\u2524" # ┤
  MID_LEFT_BOX = "\u251c" # ├
  BOTTOM_RIGHT_BOX = "\u2518" # ┘
  BOTTOM_LEFT_BOX = "\u2514" # └
  MID_TOP_BOX = "\u252c" # ┬
  MID_BOTTOM_BOX = "\u2534" # ┴
  MID_BOX = "\u253c" # ┼
  LINE_VERTICAL = "\u2502" # │
  LINE_HORIZONTAL = "\u2500" # ─
  
  def initialize
    @board = generate_empty_board
  end

  def row
    row_arr = []
    7.times { row_arr << '    ' }
    row_arr
  end

  def generate_empty_board
    board = []
    6.times { board << row }
    board
  end

  def divider
    "#{MID_LEFT_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_RIGHT_BOX}"
  end

  def starter
    "#{TOP_LEFT_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_TOP_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_TOP_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_TOP_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_TOP_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_TOP_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_TOP_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{TOP_RIGHT_BOX}"
  end

  def ender
    "#{BOTTOM_LEFT_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOTTOM_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOTTOM_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOTTOM_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOTTOM_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOTTOM_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{MID_BOTTOM_BOX}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{LINE_HORIZONTAL}#{BOTTOM_RIGHT_BOX}"
  end

  def row_display(row_array)
    row_str = ["#{LINE_VERTICAL}"]
    row_array.each do |cell|
      row_str << cell
      row_str << "#{LINE_VERTICAL}"
    end
    row_str = row_str.join('')
  end

  def display(_ = @board)
    entire_board = [starter]
    @board.each do |row|
      entire_board << row_display(row)
      entire_board << divider
    end
    entire_board.pop
    entire_board << ender
    entire_board.each do |pretty_row|
      puts pretty_row
    end
  end

  def generate_column_array(column)
    column_arr = []
    @board.each do |row|
      column_arr << row[column]
    end
    column_arr
  end

  def valid_move?(move)
    move -= 1
    return false unless (0..7).include?(move)
    column_arr = generate_column_array(move)
    return false unless column_arr.include?('    ')
    true
  end

  def add_move_to_board(move, user_token)
    return false unless valid_move?(move)
    move -= 1
    column_arr = generate_column_array(move)
    (column_arr.length - 1).downto(0) do |index|
      if column_arr[index] == '    '
        column_arr[index] = " #{user_token}  "
        break
      end
    end
    column_arr.each_with_index do |cell, index|
      @board[index][move] = cell
    end
    @board
  end

  def win_horizontal?
    @board.each do |row|
      for i in (0..3) do
        test_row = row.slice(i, 4)
        elements_in_test = test_row.uniq
        return true if elements_in_test.length == 1 && !elements_in_test.include?('    ')
      end
    end
    false
  end

  def win_vertical?
    for i in (0..6) do
      test_column = generate_column_array(i)
      number_of_tokens = test_column.chunk { |ele| ele }.map { |token, appearances| [token, appearances.length] }
      (number_of_tokens.length - 1).downto(0) do |index|
        if number_of_tokens[index].include?('    ')
          number_of_tokens.delete_at(index) 
          next
        end
        return true if number_of_tokens[index].include?(4)
      end
    end
    false
  end

  def check_diagonal(row, column)
    row_shift = row.between?(0, 2) ? 1 : -1
    column_shift = column.between?(0, 3) ? 1 : -1
    four_in_line = []
    0.upto(3) do |i|
      four_in_line << @board[row + (row_shift * i)][column + (column_shift * i)]
    end
    test_elements = four_in_line.uniq
    return true if test_elements.length == 1 && !test_elements.include?('    ')
    false
  end

  def win_diagonal?
    for i in (0..5) do
      for j in (0..6) do
        return true if check_diagonal(i, j)
      end
    end
    false
  end

  def filled_up?
    row_tests = []
    @board.each do |row|
      row_tests << row.include?('    ') ? true : false
    end
    !row_tests.include?(true)
  end

  def victory?
    win_horizontal? || win_vertical? || win_diagonal?
  end
end
