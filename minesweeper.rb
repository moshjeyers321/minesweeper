require_relative 'board'
require 'yaml'

class Minesweeper

  SIZES = {
    small: {grid_size: 9, num_bombs: 10}
    medium: {grid_size: 16, num_bombs: 40}
    large: {grid_size: 32, num_bombs: 160}
  }

  def initialize(size)
    layout = SIZES[size]
    @board = Board.new(layout[:grid_size], layout[:num_bombs])
  end

  def get_move
    type, row_st, col_st = gets.chomp.split(" ")

    [type, [row_st.to_i, col_st.to_i]]
  end

  def perform_move(type, pos)

    tile = @board[pos]

    case type
    when "f"
      tile.flag
    when "e"
      tile.explore
    when "s"
      #will save once i get to that part
    end
  end


  def play
    until @board.won? || @board.lost?
      puts @board.render
      move = get_move
      perform_move(move)
    end

    if @board.won?
      puts "VICTORY!!!"
    end

    if @board.lose?
      puts @board.reveal
      puts "YOU HAVE LOST THE GAME"
    end
  end

end