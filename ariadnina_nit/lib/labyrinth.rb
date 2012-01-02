require_relative 'cave'
require_relative 'path'

# Class which holds information about the Labyrinth - caves and paths between them
# methods: constructor and getters for caves and paths
class Labyrinth

  attr_accessor :caves, :paths, :num_caves, :num_paths

  def initialize(input_file)
    state = States::NODES_COUNT
    @caves = Array.new()
    @paths = Array.new()
    # create the caves and paths from the file
    File.open(input_file) do |file|
      while content = file.gets
        case state
        when States::NODES_COUNT
          @num_caves = content.to_i()
          state = States::NODE_LINE

        when States::NODE_LINE
          @caves.push(Cave.new(content))
          add_paths(content)
        end

      end
    end
  end

  # used by constructor - adds paths to the labyrinth
  def add_paths(l)
    line = l.split(' ')
    line.each { |n|
      n = n.to_i()
      if(n != line[0].to_i())
        
        if(get_path(line[0].to_i(), n)==0)
          path = Path.new(line[0].to_i(), n)
          @paths.push(path)
        end
      end
    }
  end

  # get path between these two caves
  def get_path(f, t)
    if(f > t)
      from = t
      to = f
    else
      from = f
      to = t
    end
    @paths.each { |path| return path if(path.from==from && path.to==to) }
    return 0
  end

  # get cave by id
  def get_cave(id)
    @caves.each { |cave| return cave if(cave.id.to_i == id.to_i) }
  end
    
end

# class used when parsing the input file - reading labyrinth specification
class States
  NODES_COUNT = 1
  NODE_LINE = 2
end

