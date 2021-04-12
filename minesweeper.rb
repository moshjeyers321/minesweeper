require_relative 'board'
require 'yaml'

class Minesweeper

  SIZES = {
    small: {grid_size: 9, num_bombs: 10},
    medium: {grid_size: 16, num_bombs: 40},
    large: {grid_size: 32, num_bombs: 160}
  }.freeze

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
      save
    end
  end

  def save
    puts "Enter filename to save at:"
    filename = gets.chomp

    File.write(filename,YAML.dump(self))
  end


  def play
    until @board.won? || @board.lost?
      @board.render
      move = get_move
      perform_move(*move)
    end

    if @board.won?
      puts "VICTORY!!!"
    end

    if @board.lost?
      @board.reveal
      puts "YOU HAVE LOST THE GAME"
    end
  end

end

if $PROGRAM_NAME == __FILE__

  case ARGV.count
  when 0
    Minesweeper.new(:small).play
  when 1
    #resume game, using first argument
    YAML.load_file(ARGV.shift).play
  end
end