require 'colorize'
require 'singleton'

class Piece

  # UNICODE_HASH = {}

  attr_reader :symbol, :position, :board, :color

  def initialize(color, position, board)
    @color = color
    set_symbol(@color)
    # @position = position
    # @board = board
  end

  def to_s
    "#{@symbol}".encode('utf-8')
  end

  def set_symbol(color)
    @symbol = @unicode_hash[color]
  end

end

class NullPiece < Piece

  include Singleton

  def initialize
    @unicode = "\u2432" #find the actual unicode for blank space

  end

end

module SlidingPiece
  STRAIGHT_MOVESET = [[1,0],[0,1],[-1,0],[0,-1]]
  DIAGONAL_MOVESET = [[1,1],[-1,1],[-1,-1],[1,-1]]
end

module SteppingPiece
  JUMPER_MOVESET = [[-2,-1],[-2,1],[2,-1],[2,1],[1,2],[-1,2],[1,-2],[-1,-2]]
end
