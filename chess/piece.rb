require_relative 'base_piece'
require 'colorize'

class King < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    @limit = true
    @unicode_hash = {
      :B => "\u265a",
      :W => "\u2654"
    }
    super
  end

  def move_set
    STRAIGHT_MOVESET + DIAGONAL_MOVESET
  end

  def in_danger?
    @board.grid.each do |row|
      row.each do |piece|
        next if piece.is_null_piece?
        next if piece.color == @color
        return true if piece.moves(piece.position).include?(@position)
      end
    end
    false
  end


end

class Queen < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    @limit = false
    @unicode_hash = {
      :B => "\u265b",
      :W => "\u2655"
    }
    super
  end

  def move_set
    STRAIGHT_MOVESET + DIAGONAL_MOVESET
  end

end

class Bishop < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    @limit = false
    @unicode_hash = {
      :B => "\u265d",
      :W => "\u2657"
    }
    super
  end

  def move_set
    DIAGONAL_MOVESET
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    @limit = false
    @unicode_hash = {
      :B => "\u265c",
      :W => "\u2656"
    }
    super
  end

  def move_set
    STRAIGHT_MOVESET
  end

end

class Knight < Piece
  include SteppingPiece

  def initialize(color, pos, board)
    @limit = true
    @unicode_hash = {
      :B => "\u265e",
      :W => "\u2658"
    }
    super
  end

  def move_set
    JUMPER_MOVESET
  end

end

class Pawn < Piece

  def initialize(color, pos, board)
    @limit = true
    @unicode_hash = {
      :B => "\u265f",
      :W => "\u2659"
    }
    super
  end

  def move_set
    set = []

    if @color == :W
      set = [ [-1, 0], [-1, 1], [-1, -1] ]
      set << [-2, 0] if @position.first == 6
    else
      set = [ [1, 0], [1, 1], [1, -1] ]
      set << [2, 0] if @position.first == 1
    end
    set
  end

end
