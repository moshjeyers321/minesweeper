

class Tile

  def initialize(board)
    @board = board
    @board_size = board.length
    @revealed = false
    @bomb = false
    @flagged = false

  end



  def inspect

  end

  def neighbors

  end

  def ==(other_tile)
    other_tile.is_a?(Tile) &&
      other_tile.
  end

  def flag
    if !flagged
      flagged = true
    else
      flagged = false
    end
  end

  def reveal
    @revealed = true
  end

  def to_s

  end

  private

  attr_accessor :flagged
end