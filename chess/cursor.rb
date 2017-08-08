require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1], # :left => [0,-1]
  right: [0, 1], # :left => [0,1]
  up: [-1, 0],   # :left => [-1,0]
  down: [1, 0]   # :left => [1,0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
  end

  def get_input
    key = KEYMAP[read_char] # => key = KEYMAP["\e[A"] => :up
    handle_key(key) # => MOVES[:up] => [-1,0]

  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :left
      update_pos(MOVES[:left])
    when :right
      update_pos(MOVES[:right])
    when :up
      update_pos(MOVES[:up])
    when :down
      update_pos(MOVES[:down])
    when :escape
      Process.exit(0)
    end
  end

  def update_pos(diff)
    @cursor_pos.each_index do |i|
      @cursor_pos[i] += diff[i]
      @cursor_pos[i] = 7 if @cursor_pos[i] == -1
      @cursor_pos[i] = 0 if @cursor_pos[i] == 8
    end
  end
end
