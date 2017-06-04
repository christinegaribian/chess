class Player
  attr_accessor :color

  def initialize(name, board)
    @board = board
    @display = Display.new(board)
    @name = name
  end


end
