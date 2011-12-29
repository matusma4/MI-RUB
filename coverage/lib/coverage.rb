class Segment
  attr_accessor :start, :stop, :range
  def initialize(start, stop)
    @begin = start
    @end = stop
    @range = Range.new(start, stop)
  end

  def to_s
    return "#{@begin} #{@end}"
  end
end

class States
  INIT = 0
  LENGTH = 1
  SEGMENTS = 2
end

class Coverage_Solver
  attr_accessor :best_solution_config, :best_solution_seg_count

  def to_binary(dec, len)
    num = dec.to_s(2)
    add_zero = len - num.length
    add_zero.times { num = "0#{num}"  }
    return num
  end

  def solve_coverage(search_range, segments)

    num_configs = 2**segments.size
    @best_solution_config = 0
    @best_solution_seg_count = 50000

    num_configs.times { |i|

      range_covered = Range.new(0, 0, true)
      used_segments = 0
      config = to_binary(i, segments.size)
      config.length.times { |index|
        if(config[index].to_i() == 1)
          if((range_covered.to_a() & segments.at(index).range.to_a()).empty?)
            if(range_covered.to_a().include?((segments.at(index).range.begin.to_i()) - 1))
              range_covered[range_covered.find_index((segments.at(index).range.begin.to_i()) - 1)] = -50000
            end
            if(range_covered.to_a().include?((segments.at(index).range.last.to_i()) + 1))
              range_covered[range_covered.find_index((segments.at(index).range.last.to_i()) + 1)] = -50000
            end
          end
          range_covered = range_covered.to_a() | segments.at(index).range.to_a()
          used_segments += 1
        end
      }
      if((range_covered.to_a() & search_range.to_a()).sort == search_range.to_a() && used_segments < @best_solution_seg_count)
        @best_solution_config = i
        @best_solution_seg_count = used_segments
      end

    }
    result = ""
    if(@best_solution_config != 0)
      result += "#{@best_solution_seg_count}"
      config = to_binary(@best_solution_config, segments.size)
      config.length.times { |index|
        if(config[index].to_i() == 1)
          result += "\n#{segments.at(index).to_s}"
        end
      }
    else
      result = "0"
    end
    
    return result
  end

  def read_solve_print

    length = 0
    search_range = Range.new(0,0)
    segments = Array.new()
    state = States::INIT

    File.open("./coverage/input") do |file|
      while content = file.gets
        case state
        when States::INIT
          state = States::LENGTH
        when States::LENGTH
          length = content.to_i()
          if(length > 0)
            search_range = Range.new(0,length)
            segments = Array.new()
            state = States::SEGMENTS
          end
        when States::SEGMENTS
          elem = content.split(' ')
          if(elem[0].to_i()==0 && elem[1].to_i()==0)
            res = solve_coverage(search_range, segments)
            puts "#{res}";
            state = States::LENGTH
          else
            segments.push(Segment.new(elem[0].to_i(), elem[1].to_i()))
          end
        end

      end

    end

  end

end

#Coverage_Solver.new.read_solve_print
