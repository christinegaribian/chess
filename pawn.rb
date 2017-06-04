class Pawn < Piece

  def initialize(position = [0,1], board, color)
    super(position, board, color)
    @direction = @color == :black ? 1 : -1
  end

  def to_s
    @color == :white ? "\u2659" : "\u265F"
  end

  def moves
    new_pos = [@position[0] + @direction, @position[1]]
    @board.in_bounds?(new_pos) && @board[new_pos].empty? ? [new_pos] : []
  end
end
