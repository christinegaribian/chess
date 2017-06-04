require 'byebug'
module Slideable
  def moves
    moves = []
    if @directions.include? :horizontal
      moves.concat(horizontal_moves)
    end
    if @directions.include? :diagonal
      moves.concat(diagonal_moves)
    end
    moves
  end

  private
  def horizontal_moves
    moves = []
    moves += grow_unblocked_moves_in_dir(1, 0)
    moves += grow_unblocked_moves_in_dir(0, 1)
    moves += grow_unblocked_moves_in_dir(-1, 0)
    moves += grow_unblocked_moves_in_dir(0, -1)
    moves
  end

  def diagonal_moves
    moves = []
    # debugger
    moves += grow_unblocked_moves_in_dir(1, 1)
    moves += grow_unblocked_moves_in_dir(-1, -1)
    moves += grow_unblocked_moves_in_dir(-1, 1)
    moves += grow_unblocked_moves_in_dir(1, -1)
    moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    # debugger
    # new_pos = @position
    moves = []

    new_pos = [@position[0] + dx, @position[1] + dy]

    while @board.in_bounds?(new_pos)

      if @board[new_pos].empty?
        moves << new_pos
      else
        if @board[new_pos].color != @color
          moves << new_pos
        end
        break
      end
      new_pos = [new_pos[0] + dx, new_pos[1] + dy]
    end

    # debugger
    moves
  end
end
