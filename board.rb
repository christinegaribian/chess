require_relative "piece"
require_relative "null_piece"
require_relative "queen"
require_relative "bishop"
require_relative "rook"
require_relative 'display'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'

require  "byebug"

class Board
  attr_reader :grid
  def initialize(grid = nil)
    if grid.nil?
      @grid = Array.new(8) { Array.new(8) }
      populate_new_grid
    else
      @grid = grid
    end
  end

  def populate_new_grid
    (2..5).each do |row_index|
      @grid[row_index].each_index do |col_index|
        @grid[row_index][col_index] = NullPiece.instance
      end
    end

    @grid[0] = fancy_row(0, :black)
    @grid[7] = fancy_row(7, :white)
    @grid[1] = pawn_row(1, :black)
    @grid[6] = pawn_row(6, :white)
  end

  def pawn_row(row, color)
    pawns = []
    8.times do |i|
      pawns << Pawn.new([row, i], self, color)
    end
    pawns
  end

  def fancy_row(r, color)
    [Rook.new([r, 0], self, color),
    Knight.new([r, 1], self, color),
    Bishop.new([r, 2], self, color),
    Queen.new([r, 3], self, color),
    King.new([r, 4], self, color),
    Bishop.new([r, 5], self, color),
    Knight.new([r, 6], self, color),
    Rook.new([r, 7], self, color)]
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    raise "No piece to move" if self[start_pos].is_a?(NullPiece)
    # raise "Position already taken" unless self[end_pos].is_a?(NullPiece)

    piece = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos] = piece
    piece.position = end_pos

  end

  def in_bounds?(pos)
    x, y = pos
    x >= 0 && x <= 7 && y >= 0 && y <= 7
  end

  def valid_move?(start_pos, end_pos)
    return false if start_pos.nil? || end_pos.nil?
    # debugger
    current_piece = self[start_pos]
    current_piece.valid_moves.include? end_pos
  end

  def find_king(color)
    @grid.each_index do |row_idx|
      @grid[row_idx].each_index do |col_idx|
        cur_pos = [row_idx, col_idx]
        return cur_pos if self[cur_pos].is_a?(King) && self[cur_pos].color == color
      end
    end
  end

  def find_pieces(color)
    pieces = []
    @grid.each_index do |row_idx|
      @grid[row_idx].each_index do |col_idx|
        piece = self[[row_idx, col_idx]]
        pieces << piece if piece.color == color
      end
    end
    pieces
  end

  def in_check?(color)
    king_pos = find_king(color)
    other_color = color == :black ? :white : :black
    opponent_pieces = find_pieces(other_color)
    opponent_pieces.each do |piece|
      return true if piece.moves.include? king_pos
    end
    false
  end

  def checkmate?(color)
    incheck = in_check?(color)
    if incheck
      return find_pieces(color).all? { |piece| piece.valid_moves.empty? }
    end

    false
  end

  def deep_dup
    new_grid = Array.new(8) { Array.new(8) }
    new_board = Board.new(new_grid)

    @grid.each_index do |row_idx|
      @grid[row_idx].each_index do |col_idx|
        new_grid[row_idx][col_idx] = (@grid[row_idx][col_idx]).copy_to_dup(new_board)
      end
    end

    new_board
  end

end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  # queen = Queen.new([2,3], board)
  # rook = Rook.new([2,1], board)
  # bishop = Bishop.new([2,2], board)
  # king = King.new([4,2], board)
  # knight = Knight.new([3,3], board)
  #   pawn = Pawn.new([1,1], board, 1)
  display.render
  # p pawn.moves
  display.test_cursor

end
