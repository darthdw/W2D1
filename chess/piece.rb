require_relative 'base_piece'

class King < Piece
  include SlidingPiece

  def initialize(color)
    @unicode_hash = {
      :B => "\u265a",
      :W => "\u2654"
    }
    super
  end

  def move_set
    STRAIGHT_MOVESET + DIAGONAL_MOVESET
  end


end

class Queen < Piece
  include SlidingPiece

  def initialize(color)
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

  def initialize(color)
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

  def initialize(color)
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

  def initialize(color)
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

  def initialize(color)
    @unicode_hash = {
      :B => "\u265f",
      :W => "\u2659"
    }
    super
  end

  def move_set


  end

end
