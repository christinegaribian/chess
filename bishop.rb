require_relative "slideable"
class Bishop < Piece
  include Slideable

  def initialize(position = [0,1], board, color)
    super(position, board, color)
    @directions = [:diagonal]
  end

  def to_s
    @color == :white ? "\u2657" : "\u265D"
  end
end
