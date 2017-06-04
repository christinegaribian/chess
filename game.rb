require_relative "board"
require_relative "human_player"
require_relative "computer_player"
class Game

  def initialize(player1, player2)
    @board = Board.new
    @player1 = HumanPlayer.new("christine", @board)
    @player1.color = :white
    @player2 = HumanPlayer.new("sam", @board)
    @player2.color = :black
    @current_player = @player1
  end

  def play
    until @board.checkmate?(@player1.color) || @board.checkmate?(@player2.color)
      @current_player.make_move
      switch_players!
    end
    p @current_player
  end

  def switch_players!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end




if __FILE__ == $PROGRAM_NAME
  game = Game.new(" ", "carp")

  # queen = Queen.new([2,3], board)
  # rook = Rook.new([2,1], board)
  # bishop = Bishop.new([2,2], board)
  # king = King.new([4,2], board)
  # knight = Knight.new([3,3], board)
  #   pawn = Pawn.new([1,1], board, 1)
  game.play

end
