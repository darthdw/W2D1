require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  attr_reader :board

  def initialize(board = nil)
    board ||= Board.new
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def play
    while true
      render
      @cursor.get_input
      system("clear")
    end
  end

  def render
    @board.grid.each_index do |row_id|
      @board.grid[row_id].each_with_index do |el,idx|
        pos = row_id,idx
        element = black_and_white(el,pos)
        if @cursor.cursor_pos == pos
          print "#{element}".colorize(:red).blink
        else
          print "#{element}"
        end
      end
    print "\n"
    end
  end

  def black_and_white(el,pos)
    x,y = pos
    if (x + y).even?
      " #{el} "
    else
      " #{el} "
    end
  end
end

d = Display.new
d.play
