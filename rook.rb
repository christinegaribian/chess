require_relative "slideable"
class Rook < Piece
  include Slideable

  def initialize(position = [0,0], board, color)
    super(position, board, color)
    @directions = [:horizontal]
  end

  def to_s
    @color == :white ? "\u2656" : "\u265C"
  end
end
