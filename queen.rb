require_relative "slideable"
class Queen < Piece
  include Slideable

  def initialize(position = [0,1], board, color)
    super(position, board, color)
    @directions = [:diagonal, :horizontal]
  end

  def to_s
    @color == :white ? "\u2655" : "\u265B"
  end

end
