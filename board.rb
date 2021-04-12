require_relative "tile"

class Board

  attr_reader :board_size, :num_bombs, :board
  
  def initialize(board_size, num_bombs)
    @board_size, @num_bombs = board_size, num_bombs

    generate_board
  end

  def generate_board
    @board = Array.new(@board_size) do |row|
      Array.new(@board_size) { |col| Tile.new(self, [row, col]) }
    end

    plant_bombs
  end

  def plant_bombs
    total_bombs = 0
    while total_bombs < @num_bombs
      rand_pos = Array.new(2) { rand(@board_size) }

      tile = self[rand_pos]
      next if tile.bomb

      tile.plant_bomb
      total_bombs += 1
    end
  end

  def [](pos)
    x,y = pos
    @board[x][y]
  end

  def render(reveal = false)
    system("clear")
    puts "  #{(0...board_size).to_a.join(" ")}"
    board.each.with_index do |row, i|
      print_row = row.map { |tile| reveal ? tile.reveal : tile.render }.join(" ")
      puts "#{i} #{print_row}"
    end
  end

  def reveal
    render(true)
  end

  def won?
  board.flatten.all? { |tile| tile.bomb != tile.explored }
  end

  def lost?
  board.flatten.any? { |tile| tile.bomb && tile.explored }
  end

end