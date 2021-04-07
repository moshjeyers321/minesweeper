

class Tile

  attr_reader :board

  def initialize(board)
    @board = board
    @board_size = board.length
    @revealed = false
    @bomb = false
    @flagged = false

  end



  def inspect
    { "revealed"=> @revealed, "bomb?"=> @bomb, "flagged?"=> @flagged, "pos"=> self.pos}
  end

  def neighbors

  end

  def pos
    pos = nil
    board.each.with_index do |row, xi|
      row.each.with_index do |col, yi|
        pos = [xi, yi] if self == board[xi,yi]
      end
    end
    pos
  end

  def ==(other_tile)
    other_tile.is_a?(Tile) &&
      other_tile.pos == self.pos
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