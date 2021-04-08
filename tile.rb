

class Tile
  
  attr_reader :board, :bomb
  attr_accessor :flagged, :pos

  def initialize(board, pos)
    @board, @pos = board, pos

    @revealed, @bomb, @flagged = false, false, false
  end



  def inspect
    {"pos" => @pos, "revealed"=> @revealed, "bomb?"=> @bomb, "flagged?"=> @flagged}
  end

  def neighbors

  end

  def plant_bomb
    @bomb = true
  end

  # def ==(other_tile)
  #   other_tile.is_a?(Tile) &&
  #     other_tile.pos == self.pos
  # end

  def flag
    flagged = !flagged unless revealed
  end

  def reveal
    @revealed = true
  end

  def to_s

  end

  private

end