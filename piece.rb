class Piece
  attr_reader :board, :color
  attr_accessor :position

  def initialize(position, board, color)
    @position = position
    @board = board
    @board[position]= self
    @color = color
  end

  def to_s
    "-"
  end

  def copy_to_dup(board)
    # p self.to_s
    self.class.new(@position, board, @color)
  end

  def empty?
    self.is_a?(NullPiece)
  end

  def valid_moves
    valid_moves = []
    moves.each do |move|
      valid_moves << move unless move_into_check?(move)
    end
    valid_moves
  end

  private
  def move_into_check?(to_pos)
    test_board = @board.deep_dup
    test_board.move_piece(@position, to_pos)
    test_board.in_check?(@color)
  end
end
