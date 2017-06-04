require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  include Singleton

  def initialize
  end
  def dup
    self
  end

  def copy_to_dup(board)
    self

  end

end
