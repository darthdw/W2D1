require 'colorize'
require 'singleton'
require 'byebug'

class Piece

  # UNICODE_HASH = {}
  attr_accessor :position

  attr_reader :symbol, :board, :color, :limit

  def initialize(color, position, board)
    @color = color
    set_symbol(@color)
    @position = position
    @board = board
    # @queue FMR
  end

  def to_s
    "#{@symbol}".encode('utf-8')
  end

  def set_symbol(color)
    @symbol = @unicode_hash[color]
  end

  def advance_position(start_pos, diff)
    x, y = start_pos
    return [] unless is_in_range?(start_pos)
    result = []
    z, w = diff
    first = x + z
    second = y + w
    pos = [first,second]
    piece = @board[pos]
    result << pos if is_in_range?(pos) && (piece.is_null_piece? || self.is_foe?(pos))
    return result if @limit || piece.nil? || piece.is_piece?
    # byebug
    result += advance_position(pos,diff)
    result
  end

  #valid_position?

  def moves(start_pos, position_move_set = nil)
    position_move_set ||= move_set
    possible_move_set = []
    position_move_set.each do |diff|
      possible_move_set += advance_position(start_pos,diff)
    end
    possible_move_set
  end

  def is_in_range?(pos)
    x, y = pos
    (0..7).include?(x) && (0..7).include?(y)
  end

  def is_piece?
    true
  end

  def is_null_piece?
    false
  end

  def is_ally?(pos)
    @board[pos].is_piece? && @board[pos].color == @color
  end

  def is_foe?(pos)
    @board[pos].is_piece? && @board[pos].color != @color
  end

end

class NullPiece < Piece

  include Singleton

  def initialize
    @unicode = "\u2432" #find the actual unicode for blank space

  end

  def is_piece?
    false
  end

  def is_null_piece?
    true
  end

end

module SlidingPiece
  STRAIGHT_MOVESET = [[1,0],[0,1],[-1,0],[0,-1]]
  DIAGONAL_MOVESET = [[1,1],[-1,1],[-1,-1],[1,-1]]
end

module SteppingPiece
  JUMPER_MOVESET = [[-2,-1],[-2,1],[2,-1],[2,1],[1,2],[-1,2],[1,-2],[-1,-2]]
end
