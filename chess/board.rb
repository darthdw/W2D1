require_relative 'piece'

class Board

  attr_reader :grid

  def initialize(grid = nil)
    grid ||= Array.new(8) {Array.new(8)}
    @grid = grid
    make_starting_grid
  end

  def move_piece(start_pos, end_pos)
    if !self[start_pos].is_a?(NullPiece) && self[end_pos].is_a?(NullPiece)
       self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    else
       raise ArgumentError, "Position Invalid"
    end
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,val)
    x,y = pos
    @grid[x][y] = val
  end

  protected

  def make_starting_grid
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        pos = [row,col]
        if (0..1).include?(row) || (6..7).include?(row)
          self[pos] = Piece.new
        else
          self[pos] = NullPiece.new
        end
      end
    end
  end

end
