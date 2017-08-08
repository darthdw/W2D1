require_relative 'piece'
require 'byebug'

class Board

  attr_reader :grid

  def initialize(grid = nil)
    grid ||= Array.new(8) {Array.new(8)}
    @grid = grid
    make_starting_grid
  end

  def move_piece(start_pos, end_pos)
    byebug
    piece = self[start_pos]
    if piece.is_null_piece?
      raise ArgumentError, "No piece at selected location"
    elsif piece.is_piece? && piece.moves(start_pos).include?(end_pos)
      piece2 = self[end_pos]
      unless piece2.is_null_piece?
        self[end_pos] = NullPiece.instance
      end
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
      piece.position = end_pos
    else
      raise ArgumentError, "Position Invalid, wtf did you do?"
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
          self[pos] = set_piece(row,col)
        else
          self[pos] = NullPiece.instance
        end
      end
    end
  end

  def set_piece(row,col)
    color = :B if (0..1).include?(row)
    color = :W if (6..7).include?(row)

    case row
    when 0, 7
      case col
      when 0, 7
        Rook.new(color,[row,col],self)
      when 1, 6
        Knight.new(color,[row,col],self)
      when 2, 5
        Bishop.new(color,[row,col],self)
      when 3
        Queen.new(color,[row,col],self)
      when 4
        King.new(color,[row,col],self)
      else
        raise "SET PIECE ERROR: Royalty"
      end
    when 1, 6
      Pawn.new(color,[row,col],self)
    else
      raise "SET PIECE ERROR: Pawn"
    end
  end

end
