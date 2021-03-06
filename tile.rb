require 'byebug'
require 'colorize'

class Tile
  
  attr_reader :board, :bomb
  attr_accessor :flagged, :pos, :explored

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

    @explored, @bomb, @flagged = false, false, false
  end

  def inspect
    { pos: pos, explored: explored, bomb: bomb, flagged: flagged}
  end

  def neighbors
    adjacents = DELTAS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |row, col|
      [row, col].all? do |point|
        point.between?(0, board.board_size-1)
      end
    end
    adjacents.map { |pos| @board[pos] }
  end


  def adjacent_bomb_count
    neighbors.select(&:bomb).count
  end

  def explore
    # debugger
    return self if explored
    return self if flagged

    @explored = true
    if !bomb && adjacent_bomb_count == 0
      neighbors.each {|neighbor| neighbor.explore}
    end

    self
  end

  def plant_bomb
    @bomb = true
  end

  def flag
    @flagged = !flagged unless explored
  end
  
  def render
    if flagged
      "F".red
    elsif explored
      adjacent_bomb_count == 0 ? "_".light_blue : adjacent_bomb_count.to_s.light_green
    else
      "*".yellow
    end
  end
  
  def reveal
  ### called at the end of the game to show the board in its revealed state
    if flagged
      bomb ? "F".light_green : "f".red
    elsif bomb
      explored ? "X".black.on_red : "B".red
    else
      adjacent_bomb_count == 0 ? "_".light_blue : adjacent_bomb_count.to_s.light_green
    end
  end
end