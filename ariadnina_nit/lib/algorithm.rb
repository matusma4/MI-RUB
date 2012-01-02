# To change this template, choose Tools | Templates
# and open the template in the editor.
require_relative 'cave'
require_relative 'path'
require_relative 'labyrinth'

class Algorithm

  attr_accessor :labyrinth, :trip, :output, :start, :stop, :count, :position

  def initialize(arguments)
    @labyrinth = Labyrinth.new(arguments[0].to_s())
    @start = arguments[1].to_i()
    @position = arguments[1].to_i()
    @stop = arguments[2].to_i()
    @trip = Array.new()
    @output = ""
  end

  # core method where the path THERE and BACK is found
  def solve
    @position = @start
    @count = 1

    # GO THERE
    @output += "GO AND FIND IT\r\n"
    while(@position != @stop)
      # find out where to go
      actual_path = get_next_path()
      if(actual_path == nil)
        puts "no path available"
        return "no path available"
      end
      # go there and make a note
      actual_path.use_path(@count)
      @count += 1
      go_there(actual_path)
    end

    # GO BACK AS FAST AS POSSIBLE
    @output += "\r\nAND NOW GO BACK\r\n"
    while(@position != @start)
      actual_path = get_path_home()
      go_there(actual_path)
    end

    puts "#{@output}"
    return @output
  end

  # make an actual move from one cave to another
  def go_there(actual_path)
    @trip.push(actual_path)
    if(@position == actual_path.from)
      @output += "#{@position} -> #{actual_path.to}, "
      @position = actual_path.to
    else
      @output += "#{@position} -> #{actual_path.from}, "
      @position = actual_path.from
    end
  end

  # find out where to go based on previous moves and marks
  # used only for going THERE
  def get_next_path()
    max = 0;
    max_path = nil;
    @labyrinth.get_cave(@position).adj_caves.each { |neighbor|
      path = @labyrinth.get_path(@position, neighbor)
      if(path.number == 0)
        return path
      end
      if(path.number > max && path.marked == false)
        max_path = path
      end
    }
    return max_path
  end

  # find out where to go based on previous moves and marks from the way THERE
  # used only for going BACK
  def get_path_home()
    min = @count;
    min_path = nil;
    @labyrinth.get_cave(@position).adj_caves.each { |neighbor|
      path = @labyrinth.get_path(@position, neighbor)
      if(path.number < min && path.number != 0)
        min = path.number
        min_path = path
      end
    }
    return min_path
  end

end

#solver = Algorithm.new(["../input2", 1, 10])
#solver.solve