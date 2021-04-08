

class Tile
  
  attr_reader :board, :bomb
  attr_accessor :flagged, :pos

  DELTAS = [
    [-1,-1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0,  1],
    [1, -1],
    [1,  0],
    [1,  1]
  ].freeze

  def initialize(board, pos)
    @board, @pos = board, pos

    @revealed, @bomb, @flagged = false, false, false
  end



  def inspect
    {"pos" => @pos, "revealed"=> @revealed, "bomb?"=> @bomb, "flagged?"=> @flagged}
  end

  def get_neighbors
    adjacents = DELTAS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |row, col|
      [row, col].all? do |point|
        point.between?(0, board.board_size-1)
      end
    end
    adjacents.map { |pos| @board[pos] }
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