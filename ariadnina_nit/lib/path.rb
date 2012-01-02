# Path class represents a connection between two Caves inside the Labyrinth
# Has information about the position (always the Cave with a smaller ID is taken as FROM point) and other parameters needed for the algorithm
class Path

  attr_accessor :from, :to, :number, :marked
  def initialize(from, to)
    if(from > to)
      @from = to
      @to = from
    else
      @from = from
      @to = to
    end
    @number = 0
    @marked = false
  end

  # go through this Path and leave an appropriate mark
  def use_path(count)
    if(@number == 0)
      @number = count
    else
      @marked = true
    end
  end

  def to_s
    return "#{from}-#{to}"
  end
  
end
