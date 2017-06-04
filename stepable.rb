require 'byebug'
module Stepable
  # assume instance var @bases
#   [[1,1],
# [0,1]
# [1,0]]

  def moves
    moves = []
    move_diffs.each do |diff|
      new_pos = [@position[0]+diff[0], @position[1] + diff[1]]
      moves << new_pos if @board.in_bounds?(new_pos) &&
        (@board[new_pos].empty? || @board[new_pos].color != @color)
    end
    moves
  end

  private

  def move_diffs
    diffs = []
    @bases.each do |base|
      x, y = base
      diffs += [[x,y],[-x,-y],[-x,y],[x,-y]]
    end
    diffs.uniq
  end
end
