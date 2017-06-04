require_relative "player"
class HumanPlayer < Player

  def make_move
    from_pos, to_pos = @display.get_valid_cursor_move(@color)
    @board.move_piece(from_pos, to_pos)
    @display.render 
  end

end
