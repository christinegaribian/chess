require_relative "stepable"
class King < Piece
  include Stepable

  def initialize(position = [0,1], board, color)
    super(position, board, color)
    @bases = [[1,0],[0,1],[1,1]]
  end

  def to_s
    @color == :white ? "\u2654" : "\u265A"
  end

end
