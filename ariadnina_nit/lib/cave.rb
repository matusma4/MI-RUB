# Cave class represents a cave in the labyrinth
# Has information about the Caves directly connected with it by a Path
class Cave

  attr_accessor :id, :adj_caves
  
  def initialize(input_line)
    nodes = input_line.split(' ')
    @id = nodes[0].to_i()
    @adj_caves = Array.new()
    nodes.each { |n|
      if(n.to_i() != @id)
        @adj_caves.push(n.to_i())
      end
    }    
  end

end
