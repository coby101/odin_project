# simple array structure to store a 3x3 grid with methods to
# add moves and display/clear board and find any 3 in a rows
class TicTacToeBoard
  private

  def display_cell(row, col)
    cell(row, col) || '_'
  end

  def cell(row, col)
    @board[row][col]
  end

  def mark_sqr(row, col, str)
    @board[row][col] = str
  end

  def validated_row(row)
    raise "Row must be in range \"a\" to \"c\". #{row} was given" unless ('a'..'c').include?(row.to_s.downcase)

    case row.to_s.downcase when 'a' then 0 when 'b' then 1 when 'c' then 2 end
  end

  def validated_col(col)
    raise "Row must be an integer. Value specified was #{row}" if col.to_i.to_s != col.to_s
    raise "Column must be in range 1..3. Value specified was #{col}" unless (1..3).include?(col.to_i)

    col.to_i - 1
  end

  public

  def initialize
    clear
  end

  def clear
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end

  def full?
    @board.all?(&:all?)
  end

  def display
    puts "\n        1_2_3"
    puts "      a|#{display_cell(0, 0)}|#{display_cell(0, 1)}|#{display_cell(0, 2)}|"
    puts "      b|#{display_cell(1, 0)}|#{display_cell(1, 1)}|#{display_cell(1, 2)}|"
    puts "      c|#{display_cell(2, 0)}|#{display_cell(2, 1)}|#{display_cell(2, 2)}|\n\n"
  end

  def record_play(token, row, col)
    v_row = validated_row row
    v_col = validated_col col

    raise "Token is length #{token.length}, should be 1" if token.length != 1
    raise "This space is taken by \"#{cell(_row, _col)}\"" if cell(v_row, v_col)

    mark_sqr(v_row, v_col, token)
  end

  def winner
    token = @board[0][0]
    if (@board[0][1] == token && @board[0][2] == token) ||
       (@board[1][0] == token && @board[2][0] == token)
      return token
    end
    token = @board[1][1]

    if (@board[1][0] == token && @board[1][2] == token) ||
       (@board[0][1] == token && @board[2][1] == token) ||
       (@board[0][0] == token && @board[2][2] == token) ||
       (@board[0][2] == token && @board[2][0] == token)
      return token
    end

    token = @board[2][2]
    if (@board[2][0] == token && @board[2][1] == token) ||
       (@board[0][2] == token && @board[1][2] == token)
      return token
    end
  end
end
